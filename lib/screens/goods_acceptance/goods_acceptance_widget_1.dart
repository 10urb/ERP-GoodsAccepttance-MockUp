// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unnecessary_null_comparison, unnecessary_null_in_if_null_operators

import 'dart:convert';
import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insoftpro_sueno_erp/environments/environment.dart';
import 'package:insoftpro_sueno_erp/helpers/image_manager.dart';
import 'package:insoftpro_sueno_erp/models/file_model/file_model.dart';
import 'package:insoftpro_sueno_erp/models/generate_dispatch_model/generate_dispatch_model.dart';
import 'package:insoftpro_sueno_erp/models/new_dispatch_model/new_dispatch_model.dart';
import 'package:insoftpro_sueno_erp/models/register_response_model/register_response_model.dart';
import 'package:insoftpro_sueno_erp/screens/goods_acceptance/goods_acceptance_widget_2.dart';
import 'package:insoftpro_sueno_erp/services/currency_service.dart';
import 'package:insoftpro_sueno_erp/services/dispatch_service.dart';
import 'package:insoftpro_sueno_erp/services/register_service.dart';
import 'package:insoftpro_sueno_erp/services/upload_service.dart';
import 'package:insoftpro_sueno_erp/styles/erp_style.dart';

class GoodsAcceptanceWidget1 extends StatefulWidget {
  final List<int>? selectedRequest;

  const GoodsAcceptanceWidget1({Key? key, this.selectedRequest})
      : super(key: key);

  @override
  _GoodsAcceptanceWidget1State createState() => _GoodsAcceptanceWidget1State();
}

class _GoodsAcceptanceWidget1State extends State<GoodsAcceptanceWidget1> {
  GenerateDispatchModel? generateDispatchModelList;
  final formKey = GlobalKey<FormState>();
  final txtDispatchSerial = TextEditingController();
  final txtDispatchNumber = TextEditingController();
  final txtExchangeRate = TextEditingController();
  final txtDescription = TextEditingController();

  List<RegisterResponseValue> registerResponseValueList = [];
  late ImageManager imageManager;

  late NewDispatch newDispatch;

  bool? newIsBillControlFinish;
  var register;
  var currency;

  Widget _previewImages() {
    final String? retrieveError = imageManager.getRetrieveError();
    if (retrieveError != null) {
      return const Text("Error");
    }
    if (imageManager.imageFile != null) {
      return Semantics(
        key: UniqueKey(),
        child: Image.file(File(imageManager.imageFile!.path),
            scale: 4, fit: BoxFit.fill),
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  var newCompanyCurrentId,
      newIsBilled,
      newSerial,
      newSequence,
      newCurrencyId,
      newDetail,
      newUpdateDate,
      newCreatedAt = DateTime.now().toUtc(),
      newStatus = "GoodsAcceptance",
      newIsDone,
      newDispatchTypeId,
      newShipmentDate,
      newFile,
      newCompanyCurrent,
      newCurrency,
      newSonOnayHareket,
      newCreatedUserId,
      newLastUpdatedUserId,
      newLastUpdateAt,
      newCreadetUser,
      newLastUpdatedUser;

  Future postGenerateDispatchWithReceiptNumber() async {
    var dispatchService =
        DispatchService(receiptNumbers: widget.selectedRequest!);

    var response = await dispatchService.postGenerateDispatch();

    if (response.statusCode == 200) {
      var generateDispatchModel =
          GenerateDispatchModel.fromJson(jsonDecode(response.body));
      generateDispatchModelList = generateDispatchModel;
      setState(() {});
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future getRegisters() async {
    var registerService = RegisterService();
    var response = await registerService.getRegisters();
    if (response.statusCode == 200) {
      var jsons = RegisterResponseModel.fromJson(jsonDecode(response.body));

      for (var registerValue in jsons.registerResponseValue!) {
        registerResponseValueList.add(registerValue);
      }

      setState(() {});
      return registerResponseValueList;
    }
    throw Exception(response.statusCode);
  }

  Future getRegisterWithId(int registerId) async {
    var registerService = RegisterService();
    var json;
    await registerService
        .getRegisterWithId(registerId)
        .then((value) => json = jsonDecode(value.body));
    print(generateDispatchModelList!.val!.isBilled);
    setState(() {});
    return json['unvan'];
  }

  Future getCurrencyWithId(int currencyId) async {
    var currencyService = CurrencyService();
    var json;
    await currencyService
        .getCurrencyWithId(currencyId)
        .then((value) => json = jsonDecode(value.body));
    setState(() {});

    return json['id'];
  }

  // Future postImage() async {
  //   UploadService uploadService = UploadService();
  //   var response = await uploadService.postImage(imageManager.imageFile!);
  //   if (response.statusCode == 200) {
  //     var json = FileModel.fromJson(jsonDecode(response.toString()));
  //     return json.fileName;
  //   }
  // }

  Future postImage() async {
    UploadService uploadService = UploadService();
    var response = await uploadService.postImage(imageManager.imageFile!);
    print(response.data);

    print(response.extra);
    print(response.headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = FileModel.fromJson(jsonDecode(response.toString()));
      print(json.fileName);
      return json.fileName;
    }
  }

  @override
  void initState() {
    getRegisters();
    postGenerateDispatchWithReceiptNumber().whenComplete(() {
      getRegisterWithId(generateDispatchModelList!.val!.companyCurrentId!)
          .then((value) => register = value);
      getCurrencyWithId(generateDispatchModelList!.val!.currencyId!)
          .then((value) => currency = value);
    });

    imageManager = ImageManager(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return generateDispatchModelList != null
        ? Scaffold(
            appBar: AppBar(
              actions: [
                Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 90),
                  child: ElevatedButton(
                    child: const Text("Kaydet Ve Devam Et →"),
                    onPressed: () {
                      newDispatch = NewDispatch(
                        id: 0,
                        companyCurrentId: newCompanyCurrentId ??
                            generateDispatchModelList!.val!.companyCurrentId,
                        currencyId: newCurrencyId ??
                            generateDispatchModelList!.val!.currencyId,
                        currencyRate: 1,
                        dispatchTypeId: newDispatchTypeId ??
                            generateDispatchModelList!.val!.dispatchTypeId,
                        serial:
                            newSerial ?? generateDispatchModelList!.val!.serial,
                        detail:
                            newDetail ?? generateDispatchModelList!.val!.detail,
                        isDone:
                            newIsDone ?? generateDispatchModelList!.val!.isDone,
                        sequence: int.tryParse(newSequence.toString()) ??
                            generateDispatchModelList!.val!.sequence,
                        file: newFile,
                        isBilled: newIsBilled ??
                            generateDispatchModelList!.val!.isBilled,
                        updateDate:
                            DateTime.tryParse(newUpdateDate.toString()) ??
                                generateDispatchModelList!.val!.updateDate,
                        shipmentDate:
                            DateTime.tryParse(newShipmentDate.toString()) ??
                                generateDispatchModelList!.val!.shipmentDate,
                        status: newStatus,
                        isBillControlFinish: newIsBillControlFinish ??
                            generateDispatchModelList!.val!.isBillControlFinish,
                        companyCurrent: newCompanyCurrent ?? null,
                        currency: newCurrency ?? null,
                        sonOnayHareket: newSonOnayHareket ?? null,
                        createdUserId: newCreatedUserId ?? null,
                        lastUpdatedUserId: newLastUpdatedUserId ?? null,
                        dataStatus: generateDispatchModelList!.val!.dataStatus,
                        createdAt: newCreatedAt,
                        lastUpdatedAt: newLastUpdateAt ?? null,
                        createdUser: newCreadetUser ?? null,
                        lastUpdatedUser: newLastUpdatedUser ?? null,
                      );
                      print("new fileee 2   " + newFile.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodsAcceptanceWidget2(
                                  newDispatch: newDispatch,
                                  generateDispatchModel:
                                      generateDispatchModelList,
                                  selectedRequest: widget.selectedRequest)));
                    },
                    style: ERPStyle.ERPsuccessElevatedButtonStyle,
                  ),
                ),
              ],
              centerTitle: true,
              title: const Text("Mal Kabul - İrsaliye"),
              backgroundColor: Colors.black54,
            ),
            body: Center(
                child: ListView(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 25),
                    children: [
                  Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                          ),
                          buildDividerField(),
                          buildRegisterTitleDropDownSearchField(),
                          buildDividerField(),
                          buildIsBilledDropDownSearchField(),
                          buildDividerField(),
                          buildDispatchSerialField(generateDispatchModelList!
                              .val!.serial
                              .toString()),
                          buildDividerField(),
                          buildSequenceField(generateDispatchModelList!
                              .val!.sequence
                              .toString()),
                          buildDividerField(),
                          buildCurrencyRateField(currency.toString()),
                          buildDividerField(),
                          buildDescriptionField(
                              generateDispatchModelList!.val!.detail),
                          buildDividerField(),
                          buildUpdaDateDateTimeFormField(),
                          buildDividerField(),
                          buildShipmentDateDateTimeFormField(),
                          buildDividerField(),
                          buildDividerField(),
                          buildDividerField(),
                          Center(
                            child: !kIsWeb &&
                                    defaultTargetPlatform ==
                                        TargetPlatform.android
                                ? FutureBuilder<void>(
                                    future: imageManager.retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return const Text(
                                            'Fotoğraf test',
                                            textAlign: TextAlign.center,
                                          );
                                        case ConnectionState.done:
                                          return _previewImages();
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image/video error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return const Text(
                                              'Video test',
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                      }
                                    },
                                  )
                                : const Text("elseee"),
                          )
                        ],
                      )),
                ])),
            floatingActionButton:
                newIsBilled == true ? buildImageLoadButton() : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: FloatingActionButton.extended(
              elevation: 70,
              label: const Text(
                  "İnternet bağlantınızı Kontrol Edin Ve Tekrar Deneyin"),
              backgroundColor: Colors.amberAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildDispatchSerialField(String serial) {
    return TextFormField(
      onChanged: (value) => newSerial = value,
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      enableSuggestions: true,
      controller: txtDispatchSerial,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'İrsaliye Seri:  $serial',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
    );
  }

  Widget buildSequenceField(var sequence) {
    return TextFormField(
      onChanged: (value) => value == null || value == ""
          ? generateDispatchModelList!.val!.sequence
          : newSequence = value,
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      controller: txtDispatchNumber,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'İrsaliye Numara:  $sequence ',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
    );
  }

  Widget buildCurrencyRateField(var currencyId) {
    currencyId = 1;
    return TextFormField(
      onChanged: (value) =>
          value == null ? newCurrencyId = currencyId : newCurrencyId = value,
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      enableSuggestions: true,
      controller: txtExchangeRate,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Kur Değeri:   $currencyId',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
    );
  }

  Widget buildDescriptionField(var detail) {
    return TextFormField(
      onChanged: (value) => newDetail = value,
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      enableSuggestions: true,
      controller: txtDescription,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText:
            detail == null ? "Açıklama Giriniz..." : 'Açıklama :  $detail',
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    return FloatingActionButton.extended(
      heroTag: "cancelButton",
      label: const Icon(Icons.cancel),
      splashColor: ERPStyle.ERPsplashColor,
      backgroundColor: Colors.grey.shade400,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildImageLoadButton() {
    return FloatingActionButton.extended(
      heroTag: "imageLoadButton",
      label: const Text("Fotoğraf Yükle"),
      icon: const Icon(Icons.camera_alt),
      backgroundColor: Colors.amber.shade300,
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo),
                    title: const Text('Fotoğraf Çek'),
                    onTap: () async {
                      await imageManager.takePhoto2();
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Galeriden Seç'),
                    onTap: () async {
                      await imageManager.pickSelectedImage();
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.video_call),
                  //   title: const Text('Video Çek'),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              );
            });
      },
    );
  }

  buildDividerField() {
    return const Divider(
      color: Colors.white,
      height: 15,
    );
  }

  buildUpdaDateDateTimeFormField() {
    return DateTimeFormField(
      initialValue: generateDispatchModelList!.val!.updateDate,
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Düzenleme Tarihi',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (element) =>
          (element?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        print(DateTime.now().toUtc());
        newUpdateDate = value;
      },
    );
  }

  buildShipmentDateDateTimeFormField() {
    return DateTimeFormField(
      initialValue: generateDispatchModelList!.val!.shipmentDate,
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Sevk Tarihi',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (element) =>
          (element?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        newShipmentDate = value;
      },
    );
  }

  buildRegisterTitleDropDownSearchField() {
    return DropdownSearch(
      showClearButton: true,
      autoFocusSearchBox: true,
      showSearchBox: true,
      maxHeight: 800,
      dialogMaxWidth: 350,
      items: registerResponseValueList
          .map((element) => element.unvan.toString())
          .toList(),
      hint: register == null ? "Yükleniyor..." : register.toString(),
      onChanged: (value) {
        registerResponseValueList.map((element) {
          if (value == element.unvan) {
            newCompanyCurrentId = element.id;
          }
        }).toList();
      },
    );
  }

  var selectedItem;

  buildIsBilledDropDownSearchField() {
    List<String> billMap = ["Faturalı", "Faturasız"];

    return DropdownSearch(
      onChanged: (value) {
        selectedItem = value;

        value == "Faturalı" ? newIsBilled = true : newIsBilled = false;
        print(newIsBilled);
        setState(() {});
      },
      maxHeight: 120,
      selectedItem: generateDispatchModelList!.val!.isBilled == true
          ? billMap[0]
          : billMap[1],
      dialogMaxWidth: 50,
      items: billMap,
      hint: "Faturalı mı?",
    );
  }

  // imagePicker(){
  //     final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // Capture a photo
  //   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  // }
}
//http://erp.sueno.com.tr/api/PurchaseRequestCompany?%24orderby=deadline%20desc&%24top=50&%24select=id%2CpurchaseRequestTrackId%2Cdeadline&%24expand=purchaseRequestTrack(%24select%3Dcode)&%24filter=(dataStatus%20eq%20%27Activated%27)%20and%20(companyId%20eq%205)%20and%20(purchaseRequestTrack%2FdataStatus%20eq%20%27Activated%27)%20and%20(purchaseRequestCompanyOffers%2Fany(b%3Ab%2FisAccepted%20eq%20true%20and%20b%2FdataStatus%20eq%20%27Activated%27%20and%20b%2FpurchaseRequestStock%2FpurchaseRequestTrackId%20gt%200%20and%20b%2FpurchaseRequestStock%2FpurchaseRequestTrack%2FlastMovement%2FpurchaseRequestStepId%20ne%20%27GoodsAcceptence%27)%20eq%20true)&%24count=true