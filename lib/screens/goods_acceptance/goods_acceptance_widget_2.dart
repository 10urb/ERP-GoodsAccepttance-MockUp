// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:erp_mockup/environments/erp_strings.dart';
import 'package:erp_mockup/helpers/erp_toastr.dart';
import 'package:erp_mockup/models/generate_dispatch_model/generate_dispatch_model.dart';
import 'package:erp_mockup/models/market_place_model/market_place_model.dart';
import 'package:erp_mockup/models/new_dispatch_model/new_dispatch_model.dart';
import 'package:erp_mockup/models/stock_model/stock_model.dart';
import 'package:erp_mockup/models/store_model/store_model.dart';
import 'package:erp_mockup/models/unit_model/unit_model.dart';
import 'package:erp_mockup/screens/goods_acceptance/expected_companies_widget.dart';
import 'package:erp_mockup/services/dispatch_service.dart';
import 'package:erp_mockup/services/market_place_service.dart';
import 'package:erp_mockup/services/stock_service.dart';
import 'package:erp_mockup/services/store_service.dart';
import 'package:erp_mockup/services/unit_service.dart';
import 'package:erp_mockup/styles/erp_style.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class GoodsAcceptanceWidget2 extends StatefulWidget {
  final NewDispatch? newDispatch;
  final GenerateDispatchModel? generateDispatchModel;
  final List<int>? selectedRequest;

  const GoodsAcceptanceWidget2(
      {Key? key,
      required this.selectedRequest,
      required this.generateDispatchModel,
      required this.newDispatch})
      : super(key: key);

  @override
  _GoodAcceptanceWidgetState createState() => _GoodAcceptanceWidgetState();
}

class _GoodAcceptanceWidgetState extends State<GoodsAcceptanceWidget2> {
  var newStockId, newStoreId, newUnitId;

  late NewDispatchModel newDispatchModel;
  late List<MarketPlaceValue> marketPlaceValue = [];
  late int newPurchaseRequestKey;

  var txtAmount = TextEditingController(),
      txtStoreName = TextEditingController(),
      txtTaxRate = TextEditingController(),
      txtStockName = TextEditingController(),
      txtUnitName = TextEditingController(),
      txtUnitPrice = TextEditingController(),
      txtEditAreaAmount = TextEditingController(),
      txtEditAreaUnits = TextEditingController(),
      txtDescriptionAdd = TextEditingController(),
      txtEditAreaStores = TextEditingController();

  var newUnitName,
      newStoreName,
      newPrice,
      newStockName,
      newAmount,
      newDescription;
  double newTaxRate = 1;
  bool confirm = false;

  List<UnitValue> unitValueModelList = [];
  List<StockValue> stockValueModelList = [];
  List<StoreValue> storeValueModelList = [];
  List<Items> dispatchItemsFilter = [];

  List<NewDispatchItem> newDispatchItemsList = [];
  List<int>? newPurchaseRequestKeyList = [];

  var formKey = GlobalKey<FormState>();
  PatternValidator numberPatternValidator =
      PatternValidator("[1-9]", errorText: "Sadece Rakam Girebilirsiniz!");
  RequiredValidator requiredFieldValidator =
      RequiredValidator(errorText: ERPStrings.ZORUNLU_ALAN);

  double newTotalPrice = 0;

  double newTotalPriceWithTax = 0;

  Future getUnits() async {
    var unitService = UnitService();
    var response = await unitService.getUnits();
    if (response.statusCode == 200) {
      var jsons = UnitModel.fromJson(jsonDecode(response.body));
      for (var unitValue in jsons.value!) {
        unitValueModelList.add(unitValue);
      }

      return unitValueModelList;
    }
  }

  Future postNewDispatch(NewDispatchModel dispatchModel) async {
    DispatchService dispatchService = DispatchService();
    var response =
        await dispatchService.postSaveDispatchFromRequest(dispatchModel);
    return response.statusCode;
  }

  bool isLoaded = false;
  Future getStocks() async {
    var stockService = StockService();
    var response = await stockService.getStocks();
    if (response.statusCode == 200) {
      var jsons = StockModel.fromJson(jsonDecode(response.body));
      for (var stockValue in jsons.value!) {
        stockValueModelList.add(stockValue);
      }
      isLoaded = true;
      return stockValueModelList;
    }
  }

  Future getMarketPrice() async {
    MarketPlaceService marketPlaceService = MarketPlaceService();
    var response = await marketPlaceService.getMarketPrice();
    if (response.statusCode == 200) {
      var jsons = MarketPlaceModel.fromJson(jsonDecode(response.body));
      for (var marketPrice in jsons.marketPlaceValue!) {
        marketPlaceValue.add(marketPrice);
      }

      return marketPlaceValue;
    } else {
      ERPToastr.buildToast(
          "Hal Fiyatı Bağlantı Başarısız :" + response.statusCode.toString(),
          Colors.red.shade400);
    }
  }

  Future getStores() async {
    var storeService = StoreService();
    var response = await storeService.getStores();
    if (response.statusCode == 200) {
      var jsons = StoreModel.fromJson(jsonDecode(response.body));
      for (var storeValue in jsons.value!) {
        storeValueModelList.add(storeValue);
      }

      return storeValueModelList;
    }
  }

  @override
  void initState() {
    super.initState();
//Listeye elemanları doldurur ek olarak toplam fiyatları hesaplar
    for (var element in widget.generateDispatchModel!.items!) {
      dispatchItemsFilter.add(element);
      setState(() {});
      newTotalPrice = 0;
      newTotalPriceWithTax = 0;
      for (var item in dispatchItemsFilter) {
        var totalWithTax;
        var totalPrice = item.price! * item.amount!;
        newTotalPrice += totalPrice;

        item.taxRate == 0
            ? null
            : totalWithTax =
                (item.taxRate! * item.price! + item.price!) * item.amount!;
        totalWithTax == null ? null : newTotalPriceWithTax += totalWithTax;
      }
    }
    getUnits();
    getStocks();
    getStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ERPStyle.ERPappBarBackGroundColor,
        actions: [
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 90),
            child: buildRemoveLastElevatedButton(),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.arrow_drop_down),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                height: 50,
                child: const Text('Antalya Hal Fiyat Güncelle'),
                onTap: () {
                  getMarketPrice().whenComplete(() {
                    for (var dispatch in dispatchItemsFilter) {
                      for (var market in marketPlaceValue) {
                        if (market.stockMarketplacePrice?.stockId == null) {
                          continue;
                        } else {
                          if (dispatch.stockId ==
                              market.stockMarketplacePrice!.stockId) {
                            var newPrice2;
                            if (market.stockMarketplacePrice!
                                    .stockMarketplaceGroupDiscount!.discount1 !=
                                null) {
                              // ignore: avoid_print
                              print(dispatch.price.toString() + "eski  FİYAT");

                              newPrice2 = market.lowestPrice! *
                                  ((100 -
                                          market
                                              .stockMarketplacePrice!
                                              .stockMarketplaceGroupDiscount!
                                              .discount1!) /
                                      100);
                              // ignore: avoid_print
                              print(newPrice2.toString() + "YENİ FİYAT");

                              dispatch.price = newPrice2;

                              setState(() {});
                            } else {
                              ERPToastr.buildToast(
                                  "Fiyatsız Gelmeyen Ürünler Var!",
                                  Colors.pink.shade400);
                            }
                          }
                        }
                      }
                    }
                  });
                },
              ),
              PopupMenuItem(
                height: 50,
                child: const Text('Antalya TUTED Fiyat Güncelle'),
                onTap: () {},
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 90),
            child: ElevatedButton(
              onPressed: () {
                buildLastConfirmAlertDialog(context);
              },
              child: const Text("Kaydet Ve Bitir"),
              onLongPress: () {
                NewDispatchItem newDispatchItem;
                for (var item in dispatchItemsFilter) {
                  newDispatchItem = NewDispatchItem(
                      acceptedAmount: item.acceptedAmount,
                      aciklama: item.aciklama,
                      amount: item.amount,
                      price: item.price,
                      stockId: item.stockId,
                      marka: item.marka,
                      purchaseRequestId: item.purchaseRequestId,
                      purchaseRequestStockId: item.purchaseRequestStockId,
                      receiptNumber: item.receiptNumber,
                      requesterUser: item.requesterUser,
                      stockName: item.stockName,
                      storeId: item.storeId,
                      storeName: item.storeName,
                      taxRate: item.taxRate,
                      totalAmount: item.totalAmount,
                      trackCode: item.trackCode,
                      unitId: item.unitId,
                      unitName: item.unitName);
                  newDispatchItemsList.add(newDispatchItem);
                  setState(() {});
                }

                newPurchaseRequestKeyList = widget.selectedRequest;

                newDispatchModel = NewDispatchModel(
                    dispatch: widget.newDispatch,
                    newDispatchItem: newDispatchItemsList,
                    purchaseRequestKeys: newPurchaseRequestKeyList);

                postNewDispatch(newDispatchModel).then((value) => value == 200
                    ? ERPToastr.buildToast(
                        'İşlem Başarılı!', Colors.green.shade400)
                    : ERPToastr.buildToast(
                        'İşlem Başarısız!', Colors.red.shade400));
                print(newDispatchModel.dispatch!.file);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpectedCompaniesWidget()));
                setState(() {});
              },
              style: ERPStyle.ERPsuccessElevatedButtonStyle,
            ),
          ),
        ],
        title: TextField(
          onChanged: (value) {
            dispatchItemsFilter.clear();
            for (var item in widget.generateDispatchModel!.items!) {
              if (item.stockName!
                  .toLowerCase()
                  .startsWith(value.toLowerCase())) {
                dispatchItemsFilter.add(item);
              }
              setState(() {});
            }
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Ürün Adı İle Aramak İçin Dokun...",
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.green.shade200,
          onPressed: () {
            for (var storeValue in storeValueModelList) {
              if (storeValue.name == newStoreName) {
                storeValue.id = newStoreId;
              }
            }
            if (isLoaded) {
              buildAddReceiptItemAlertDialog(
                context,
              );
            } else {
              ERPToastr.buildToast(
                  "Veriler Yükleniyor, Tekrar Deneyin.", Colors.amber);
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            tooltip: "Toplam KDV'siz",
            icon: const Icon(
              Icons.equalizer,
            ),
            label: "Toplam KDV' siz\n" + newTotalPrice.toStringAsFixed(4),
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.equalizer),
              label:
                  "Toplam KDV' li\n" + newTotalPriceWithTax.toStringAsFixed(4)),
        ],
      ),
      body: widget.generateDispatchModel == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(scrollDirection: Axis.horizontal, children: [
              InteractiveViewer(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showCheckboxColumn: true,
                      dataRowHeight: 40,
                      horizontalMargin: MediaQuery.of(context).size.width / 50,
                      sortColumnIndex: 0,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade100),
                      columnSpacing: 50,
                      dividerThickness: 2,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(label: Text(ERPStrings.URUN_ADI)),
                        DataColumn(label: Text(ERPStrings.KONTROL_ALANI)),
                        DataColumn(label: Text(ERPStrings.MIKTAR)),
                        DataColumn(label: Text(ERPStrings.BIRIM)),
                        DataColumn(label: Text(ERPStrings.TOPLAM_MIKTAR)),
                        DataColumn(label: Text(ERPStrings.ALINMIS_MIKTAR)),
                        DataColumn(label: Text(ERPStrings.BIRIM_FIYATI)),
                        DataColumn(label: Text(ERPStrings.KDV_ORANI)),
                        DataColumn(label: Text(ERPStrings.DEPO)),
                        DataColumn(label: Text(ERPStrings.ACIKLAMA)),
                        DataColumn(label: Text(ERPStrings.TALEP_EDEN)),
                      ],
                      rows: dispatchItemsFilter.map((element) {
                        return DataRow(cells: [
                          buildStockNameDataCellField(element.stockName),
                          buildSelectionAreaDataCellField(
                              element.isSelected, element.stockId),
                          buildAmountDataCellField(element.amount, element),
                          buildUnitNameDataCellField(element.unitName, element),
                          buildTotalAmountDataCellField(element.totalAmount),
                          buildAcceptedAmountDataCellField(
                              element.acceptedAmount),
                          buildPriceDataCellField(element.price),
                          buildTaxRateDataCellField(element.taxRate),
                          buildStoreNameDataCellField(
                              element.storeName, element),
                          buildDescriptionDataCellField(element.aciklama),
                          buildRequesterUserDataCellField(
                              element.requesterUser),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ]),
    );
  }

  Future<void> displayAmountTextInputDialog(
      BuildContext context, Items items) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            actionsPadding: const EdgeInsets.all(15),
            backgroundColor: Colors.white,
            title: const Text(
              'Düzenle',
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              validator: MultiValidator(
                  [requiredFieldValidator, numberPatternValidator]),
              onChanged: (value) => newAmount = value,
              autofocus: true,
              controller: txtEditAreaAmount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: items.amount.toString().split(".")[0]),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Vazgeç'),
                style: ERPStyle.ERPcancelElevatedButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Onayla'),
                style: ERPStyle.ERPsuccessElevatedButtonStyle,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    for (int i = 0;
                        i < widget.generateDispatchModel!.items!.length;
                        i++) {
                      if (widget.generateDispatchModel!.items![i].stockId ==
                          items.stockId) {
                        widget.generateDispatchModel!.items![i].amount =
                            double.tryParse(newAmount);
                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                      buildCleanTextControllerField();
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> displayUnitsTextInputDialog(
      BuildContext context, Items items) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            actionsPadding: const EdgeInsets.all(15),
            backgroundColor: Colors.white,
            title: const Text(
              'Düzenle',
              textAlign: TextAlign.center,
            ),
            content: DropdownSearch(
              validator: (value) =>
                  value == null ? ERPStrings.ZORUNLU_ALAN : null,
              searchFieldProps: TextFieldProps(
                autofocus: true,
              ),
              onChanged: (value) => newUnitName = value,
              dialogMaxWidth: 20,
              maxHeight: 500,
              showClearButton: true,
              autoFocusSearchBox: true,
              hint: items.unitName,
              showSearchBox: true,
              label: "Birim Seçiniz...",
              onSaved: (text) {
                txtEditAreaUnits.text = text.toString();
              },
              items: unitValueModelList
                  .map((element) => element.name.toString())
                  .toList(),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Vazgeç'),
                style: ERPStyle.ERPcancelElevatedButtonStyle,
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                  buildCleanTextControllerField();
                },
              ),
              ElevatedButton(
                child: const Text('Onayla'),
                style: ERPStyle.ERPsuccessElevatedButtonStyle,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    for (int i = 0;
                        i < widget.generateDispatchModel!.items!.length;
                        i++) {
                      if (widget.generateDispatchModel!.items![i].stockId ==
                          items.stockId) {
                        widget.generateDispatchModel!.items![i].unitName =
                            newUnitName;
                      }
                    }
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> displayStoresTextInputDialog(
      BuildContext context, Items items) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            actionsPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width / 50),
            backgroundColor: Colors.white,
            title: const Text(
              'Düzenle',
              textAlign: TextAlign.center,
            ),
            content: DropdownSearch(
              label: "Depo Seçiniz...",
              validator: (value) =>
                  value == null ? ERPStrings.ZORUNLU_ALAN : null,
              searchFieldProps: TextFieldProps(
                autofocus: true,
              ),
              onChanged: (value) {
                txtEditAreaStores.text = value.toString();
                for (var storeValue in storeValueModelList) {
                  storeValue.name == txtEditAreaStores.text
                      ? items.storeId = storeValue.id
                      : null;
                }
              },
              clearButtonSplashRadius: 50,
              searchBoxController: txtEditAreaStores,
              dialogMaxWidth: 20,
              maxHeight: 500,
              showClearButton: true,
              autoFocusSearchBox: true,
              hint: items.unitName,
              showSearchBox: true,
              onSaved: (text) {
                txtEditAreaStores.text = text.toString();
              },
              items: storeValueModelList
                  .map((element) => element.name.toString())
                  .toList(),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Vazgeç'),
                style: ERPStyle.ERPcancelElevatedButtonStyle,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Onayla'),
                style: ERPStyle.ERPsuccessElevatedButtonStyle,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    for (int i = 0;
                        i < widget.generateDispatchModel!.items!.length;
                        i++) {
                      if (widget.generateDispatchModel!.items![i].stockId ==
                          items.stockId) {
                        widget.generateDispatchModel!.items![i].storeName =
                            txtEditAreaStores.text;
                        setState(() {});
                        Navigator.pop(context);
                        txtEditAreaUnits.clear();
                      }
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  buildStockNameDataCellField(var stockName) {
    return DataCell(
      Text(stockName.toString()),
    );
  }

  buildSelectionAreaDataCellField(var isSelected, var stockId) {
    return DataCell(Checkbox(
      fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
      splashRadius: 50,
      value: isSelected ?? false,
      onChanged: (value) {
        for (int i = 0; i < dispatchItemsFilter.length; i++) {
          if (stockId == dispatchItemsFilter[i].stockId) {
            dispatchItemsFilter[i].isSelected = value;
          }
          setState(() {});
        }
      },
    ));
  }

  buildTotalAmountDataCellField(var totalAmount) {
    return DataCell(
        Text(totalAmount == null ? "0" : totalAmount.toString().split(".")[0]));
  }

  buildAcceptedAmountDataCellField(var acceptedAmount) {
    return DataCell(Text(acceptedAmount == null
        ? "0"
        : acceptedAmount.toString().split(".")[0]));
  }

  buildAmountDataCellField(var amount, var element) {
    return DataCell(
      Text(amount.toString().split(".")[0]),
      showEditIcon: true,
      onTap: () {
        displayAmountTextInputDialog(context, element);
      },
    );
  }

  buildUnitNameDataCellField(var unitName, var element) {
    return DataCell(
      Text(unitName.toString()),
      showEditIcon: true,
      onTap: () {
        displayUnitsTextInputDialog(context, element);
      },
    );
  }

  buildPriceDataCellField(var price) {
    //_ Depo Şefi Fiyatı Virgülden Sonra 4 Hane İstiyor.
    return DataCell(
      Text(price == null
          ? "0"
          : "₺ " + double.tryParse(price.toString())!.toStringAsFixed(4)),
    );
  }

  buildTaxRateDataCellField(var taxRate) {
    return DataCell(Text(taxRate == null
        ? "Girilmemiş"
        : "% " + (taxRate * 100).toString().split(".")[0]));
  }

  buildDescriptionDataCellField(var description) {
    return DataCell(
        Text(description == null ? "  Yok" : description.toString()));
  }

  buildStoreNameDataCellField(var storeName, var element) {
    return DataCell(
      Text(storeName.toString()),
      showEditIcon: true,
      onTap: () {
        displayStoresTextInputDialog(context, element);
      },
    );
  }

  Future<void> buildAddReceiptItemAlertDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
          child: Container(
            margin: const EdgeInsets.only(left: 60, right: 60),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: AlertDialog(
                insetPadding: MediaQuery.of(context).padding / 20,
                backgroundColor: Colors.white,
                title: const Text(
                  'Ürün Kalemi Ekle',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  buildStoreNameAddDropDownSearchField(),
                  buildDividerField(),
                  buildStockNameAddDropDownSearchField(),
                  buildDividerField(),
                  buildUnitNameAddDropDownSearchField(),
                  buildDividerField(),
                  buildPriceAddTextField(),
                  buildDividerField(),
                  buildAmountAddTextField(),
                  buildDividerField(),
                  buildTaxRateAddTextField(),
                  buildDividerField(),
                  buildDescriptionAddTextField(),
                  buildDividerField(),
                  buildReceiptAddConfirmElevatedButton(),
                  buildReceiptAddCancelElevatedButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildCleanTextControllerField() {
    txtAmount.clear();
    txtEditAreaUnits.clear();
    txtEditAreaAmount.clear();
    txtStoreName.clear();
    txtStoreName.clear();
    txtTaxRate.clear();
    txtUnitName.clear();
    txtStockName.clear();
    txtUnitPrice.clear();
  }

  buildDividerField() {
    return const Divider(
      color: Colors.white,
      height: 15,
    );
  }

  buildStoreNameAddDropDownSearchField() {
    return DropdownSearch(
      searchFieldProps: TextFieldProps(
          autofocus: true, controller: TextEditingController(text: "")),
      validator: (value) => value == null ? ERPStrings.ZORUNLU_ALAN : null,
      onChanged: (value) {
        newStoreName = value;
        for (var storeValue in storeValueModelList) {
          storeValue.name == newStoreName ? newStoreId = storeValue.id : null;
        }
      },
      searchBoxDecoration: const InputDecoration(icon: Icon(Icons.search)),
      searchBoxController: txtEditAreaUnits,
      dialogMaxWidth: 20,
      maxHeight: 500,
      showClearButton: true,
      autoFocusSearchBox: true,
      showSearchBox: true,
      label: ERPStrings.DEPO_SECINIZ,
      items: storeValueModelList
          .map((element) => element.name.toString())
          .toList(),
    );
  }

  buildStockNameAddDropDownSearchField() {
    return DropdownSearch(
      validator: (value) => value == null ? ERPStrings.ZORUNLU_ALAN : null,
      searchFieldProps: TextFieldProps(
          autofocus: true, controller: TextEditingController(text: null)),
      onChanged: (value) => newStockName = value,
      mode: Mode.DIALOG,
      // popupItemDisabled: (String s) => s.startsWith('İ'),
      showSelectedItem: true,
      searchBoxDecoration: const InputDecoration(icon: Icon(Icons.search)),
      searchBoxController: txtEditAreaUnits,
      dialogMaxWidth: 20,
      maxHeight: 500,
      showClearButton: true,
      autoFocusSearchBox: true,
      showSearchBox: true,
      label: ERPStrings.URUN_ADI_SECINIZ,
      onSaved: (text) {
        txtEditAreaUnits.text = text.toString();
      },
      items: stockValueModelList
              .map((element) => element.name.toString())
              .toList()
              .isEmpty
          ? [ERPStrings.YUKLENIYOR]
          : stockValueModelList
              .map((element) => element.name.toString())
              .toList(),
    );
  }

  buildUnitNameAddDropDownSearchField() {
    return DropdownSearch(
      searchFieldProps: TextFieldProps(
          autofocus: true, controller: TextEditingController(text: "")),
      validator: (value) => value == null ? ERPStrings.ZORUNLU_ALAN : null,
      onChanged: (value) => newUnitName = value,
      searchBoxDecoration: const InputDecoration(icon: Icon(Icons.search)),
      searchBoxController: txtEditAreaUnits,
      dialogMaxWidth: 20,
      maxHeight: 500,
      showClearButton: true,
      autoFocusSearchBox: true,
      showSearchBox: true,
      label: ERPStrings.BIRIM_SECINIZ,
      items:
          unitValueModelList.map((element) => element.name.toString()).toList(),
    );
  }

  buildPriceAddTextField() {
    return TextFormField(
      textAlign: TextAlign.center,
      validator: MultiValidator([
        requiredFieldValidator,
        numberPatternValidator,
      ]),
      onChanged: (value) => newPrice = value,
      controller: txtUnitPrice,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text("Fiyat * :"), border: OutlineInputBorder()),
    );
  }

  buildAmountAddTextField() {
    return TextFormField(
      validator:
          MultiValidator([requiredFieldValidator, numberPatternValidator]),
      textAlign: TextAlign.center,
      onChanged: (value) => newAmount = value,
      controller: txtAmount,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text("Miktar * :"), border: OutlineInputBorder()),
    );
  }

  buildTaxRateAddTextField() {
    return TextFormField(
      textAlign: TextAlign.center,
      validator:
          MultiValidator([requiredFieldValidator, numberPatternValidator]),
      onChanged: (value) =>
          value == "" ? 0 : newTaxRate = double.tryParse(value)!,
      enableSuggestions: true,
      controller: txtTaxRate,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          suffixText: "%",
          label: Text("KDV Oranı % * :"),
          border: OutlineInputBorder()),
    );
  }

  buildDescriptionAddTextField() {
    return TextFormField(
      textAlign: TextAlign.center,
      onChanged: (value) => newDescription = value,
      controller: txtDescriptionAdd,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          label: Text("Açıklama:"), border: OutlineInputBorder()),
    );
  }

  buildReceiptAddConfirmElevatedButton() {
    return ElevatedButton(
        child: Text(ERPStrings.ONAYLA),
        style: ERPStyle.ERPsuccessElevatedButtonStyle,
        onPressed: () {
          for (var stockValue in stockValueModelList) {
            stockValue.name == newStockName ? newStockId = stockValue.id : null;
          }
          for (var unitValue in unitValueModelList) {
            unitValue.name == newUnitName ? newUnitId = unitValue.id : null;
          }
          if (formKey.currentState!.validate()) {
            Items newItem = Items(
              price: double.tryParse(newPrice),
              stockName: newStockName,
              stockId: newStockId,
              amount: double.tryParse(newAmount),
              storeName: newStoreName,
              storeId: newStoreId,
              taxRate: newTaxRate / 100,
              unitName: newUnitName,
              unitId: newUnitId,
              isSelected: false,
              aciklama: newDescription,
            );

            dispatchItemsFilter.add(newItem);
            setState(() {
              dispatchItemsFilter;
              Navigator.pop(context);
              buildCleanTextControllerField();
            });
          }
        });
  }

  buildRemoveLastElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          ERPToastr.buildToast("Geri Almak İçin Basılı Tutun!", Colors.green);
        },
        style: ERPStyle.ERPcancelRedElevatedButtonStyle,
        onLongPress: () {
          sleep(const Duration(seconds: 1));
          dispatchItemsFilter.length >
                  widget.generateDispatchModel!.items!.length
              ? dispatchItemsFilter.removeLast()
              : ERPToastr.buildToast(
                  "Sadece Eklediklerinizi Silebilirsiniz!", Colors.red);

          setState(() {
            dispatchItemsFilter;
          });
        },
        child: const Text("Ekleneni Geri Al"));
  }

  buildReceiptAddCancelElevatedButton() {
    return ElevatedButton(
      child: const Text('Vazgeç'),
      style: ERPStyle.ERPcancelElevatedButtonStyle,
      onPressed: () {
        buildCleanTextControllerField();
        Navigator.pop(context);
      },
    );
  }

  buildResetVariables() {
    newPrice = null;
    newStockName = null;
    newAmount = null;
    newStoreName = null;
    newTaxRate = 0;
    newUnitName = null;
    newDescription = null;
    setState(() {});
  }

  buildRequesterUserDataCellField(var requesterUser) {
    return DataCell(Text(
        requesterUser == null ? " Talep edilmedi." : requesterUser.toString()));
  }
}

Future<void> buildLastConfirmAlertDialog(
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
        title: const Text(
          'İrsaliye Oluşturulmasını Onaylıyorsanız Uzun Basın!',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Tamam'),
            style: ERPStyle.ERPsuccessElevatedButtonStyle,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Hayır'),
          //   style: ERPStyle.ERPsuccessElevatedButtonStyle,
          // ),
        ],
      );
    },
  );
}
