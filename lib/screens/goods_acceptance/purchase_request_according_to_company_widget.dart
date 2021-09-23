import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insoftpro_sueno_erp/environments/ERP_Strings.dart';
import 'package:insoftpro_sueno_erp/helpers/erp_toastr.dart';
import 'package:insoftpro_sueno_erp/models/purchase_request_detail_model/purchase_request_detail_model.dart';
import 'package:insoftpro_sueno_erp/models/purchase_request_model/purchase_request_model.dart';
import 'package:insoftpro_sueno_erp/screens/goods_acceptance/goods_acceptance_widget_1.dart';
import 'package:insoftpro_sueno_erp/services/purchase_request_according_to_company_service.dart';
import 'package:insoftpro_sueno_erp/styles/erp_style.dart';

class PurchaseRequestAccordingToCompany extends StatefulWidget {
  final int sayi;

  const PurchaseRequestAccordingToCompany({Key? key, required this.sayi})
      : super(key: key);

  @override
  _PurchaseRequestAccordingToCompanyState createState() =>
      _PurchaseRequestAccordingToCompanyState();
}

class _PurchaseRequestAccordingToCompanyState
    extends State<PurchaseRequestAccordingToCompany> {
  List<PurchaseRequestValue> purchaseRequestModelListOriginal = [];

  late var selected = false;
  List<int> selectedRequestList = [];
  PurchaseRequestDetail purchaserequestDetail = PurchaseRequestDetail();
  var txtSearch = TextEditingController();

  List<PurchaseRequestValue> purchaseRequestTrackModelFilter = [];

  Future<List<PurchaseRequestValue>> getPurchaseRequest() async {
    var service = PurchaseRequestAccordingToCompanyService
        .getPurchaseRequestAccordingToCompany(companyId: widget.sayi);
    final response = await service.getPurchaseRequestAccordingToCompany();
    if (response.statusCode == 200) {
      var jsons = jsonDecode(response.body);

      for (var json in jsons['value']) {
        var purchaseRequestTrackModel =
            PurchaseRequestTrack(code: json['purchaseRequestTrack']['code']);
        var value = PurchaseRequestValue(
            id: json['id'],
            purchaseRequestTrackId: json['purchaseRequestTrackId'],
            deadline: json['deadline'],
            isSelected: false,
            purchaseRequestTrack: purchaseRequestTrackModel);

        purchaseRequestModelListOriginal.add(value);
      }
      setState(() {});

      return purchaseRequestModelListOriginal;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<PurchaseRequestDetail> getPurchaseRequestDetail(
      var receiptTrackId) async {
    var service = PurchaseRequestAccordingToCompanyService
        .getPurchaseRequestAccordingToCompany(receiptNumber: receiptTrackId);

    final response = await service.getPurchaseRequestDetail();
    if (response.statusCode == 200) {
      var jsons = PurchaseRequestDetail.fromJson(jsonDecode(response.body));
      purchaserequestDetail = jsons;
      setState(() {});
      return purchaserequestDetail;
    } else {
      Fluttertoast.showToast(
          msg: response.statusCode.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    getPurchaseRequest().then((value) {
      purchaseRequestTrackModelFilter.addAll(value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text("➕ İrsaliye Oluştur"),
              onPressed: () {
                for (int i = 0;
                    i < purchaseRequestModelListOriginal.length;
                    i++) {
                  if (purchaseRequestModelListOriginal[i].isSelected) {
                    selectedRequestList
                        .add(purchaseRequestModelListOriginal[i].id);
                  }
                }

                selectedRequestList.isEmpty
                    ? ERPToastr.buildToast(
                        "Önce Seçim Yapmalısınız!", Colors.red.shade400)
                    : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoodsAcceptanceWidget1(
                                    selectedRequest: selectedRequestList)))
                        .then((value) => selectedRequestList.clear());
              },
              style: ERPStyle.ERPsuccessElevatedButtonStyle,
            ),
          ),
        ],
        backgroundColor: Colors.black54,
        title: TextField(
          controller: txtSearch,
          onChanged: (value) {
            purchaseRequestTrackModelFilter.clear();
            for (var item in purchaseRequestModelListOriginal) {
              if (item.purchaseRequestTrack.code
                  .toLowerCase()
                  .startsWith(value.toLowerCase())) {
                purchaseRequestTrackModelFilter.add(item);
                setState(() {});
              } else {}
            }
          },
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Fişlerde Aramak İçin Dokun...",
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: purchaseRequestTrackModelFilter == []
          ? const Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 10, left: 5),
              child: ListView(scrollDirection: Axis.vertical, children: [
                DataTable(
                    dividerThickness: 4,
                    onSelectAll: (value) {},
                    showBottomBorder: true,
                    columns: [
                      DataColumn(label: Text(ERPStrings.SECIM_ALANI)),
                      DataColumn(label: Text(ERPStrings.FIS_NUMARASI)),
                      DataColumn(label: Text(ERPStrings.TERMIN_TARIHI))
                    ],
                    rows: purchaseRequestTrackModelFilter
                        .map((element) => DataRow(
                              cells: [
                                DataCell(Checkbox(
                                  splashRadius: 50,
                                  value: element.isSelected,
                                  onChanged: (value) {
                                    for (int i = 0;
                                        i <
                                            purchaseRequestModelListOriginal
                                                .length;
                                        i++) {
                                      if (element.id ==
                                          purchaseRequestModelListOriginal[i]
                                              .id) {
                                        purchaseRequestModelListOriginal[i]
                                                .isSelected =
                                            !purchaseRequestModelListOriginal[i]
                                                .isSelected;
                                      }

                                      setState(() {});
                                    }
                                  },
                                )),
                                DataCell(
                                  Text("🔎  " +
                                      element.purchaseRequestTrack.code
                                          .toString()),
                                  onTap: () {
                                    getPurchaseRequestDetail(element.id).then(
                                        (value) =>
                                            buildPurchaseRequestDetailAlertDialog());
                                  },
                                ),
                                DataCell(Text(
                                    element.deadline.split("T")[0].toString())),
                              ],
                              selected: element.isSelected,
                            ))
                        .toList())
              ])),
    );
  }

  buildPurchaseRequestDetailAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: InteractiveViewer(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width / 50,
                left: MediaQuery.of(context).size.width / 60,
                right: MediaQuery.of(context).size.width / 50,
                top: MediaQuery.of(context).size.width / 50,
              ),
              child: AlertDialog(
                  scrollable: true,
                  buttonPadding: const EdgeInsets.only(bottom: 20),
                  actions: [
                    IconButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        icon: const Icon(Icons.close)),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: MediaQuery.of(context).size.width / 40,
                        showCheckboxColumn: true,
                        onSelectAll: (b) {},
                        sortAscending: true,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(ERPStrings.URUN_ADI),
                          ),
                          DataColumn(
                            label: Text(ERPStrings.BIRIM),
                          ),
                          DataColumn(
                            label: Text(ERPStrings.TALEP_EDILEN_MIKTAR),
                          ),
                          DataColumn(
                            label: Text(ERPStrings.BIRIM_FIYATI),
                          ),
                          DataColumn(
                            label: Text(ERPStrings.ALINMIS_MIKTAR),
                          ),
                          // DataColumn(
                          //   label: Text(ERPStrings.NOT),
                          // ),
                        ],
                        rows: purchaserequestDetail
                                    .purchaseRequestDetailValue ==
                                null
                            ? const [
                                DataRow(cells: [
                                  DataCell(CircularProgressIndicator()),
                                  DataCell(CircularProgressIndicator()),
                                  DataCell(CircularProgressIndicator()),
                                  DataCell(CircularProgressIndicator()),
                                  DataCell(CircularProgressIndicator()),
                                  // DataCell(CircularProgressIndicator()),
                                ])
                              ]
                            : purchaserequestDetail.purchaseRequestDetailValue!
                                .map(
                                  (element) => DataRow(
                                    cells: [
                                      buildStockNameDataCellField(element
                                          .purchaseRequestStock!.stock!.name),
                                      buildUnitNameDataCellField(element
                                          .purchaseRequestStock!.unit!.name),
                                      buildRequestedAmountDataCellField(element
                                          .purchaseRequestStock!
                                          .requestedAmount),
                                      buildPriceDataCellField(element.price),
                                      buildAcceptedAmountCellField(
                                          element.acceptedAmount),
                                      // buildNoteCellField(element.note),
                                    ],
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    IconButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ]),
            ),
          ),
        );
      },
    );
  }

  buildStockNameDataCellField(var stockName) {
    return DataCell(
      Text(
        stockName.toString(),
        style: const TextStyle(fontSize: 10),
      ),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildUnitNameDataCellField(var unitName) {
    return DataCell(
      Text(
        unitName.toString(),
        style: const TextStyle(fontSize: 10),
      ),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildRequestedAmountDataCellField(var requestedAmount) {
    return DataCell(
      Text(requestedAmount.toString().split(".")[0],
          style: const TextStyle(fontSize: 10)),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildPriceDataCellField(var price) {
    return DataCell(
      Text(price.toString(), style: const TextStyle(fontSize: 10)),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildAcceptedAmountCellField(var acceptedAmount) {
    return DataCell(
      Text(acceptedAmount.toString(), style: const TextStyle(fontSize: 10)),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildNoteCellField(var note) {
    return DataCell(
      Text(note.toString(), style: const TextStyle(fontSize: 10)),
      showEditIcon: false,
      placeholder: false,
    );
  }

  buildDataCellField(var data) {
    return DataCell(
      Text(data.toString(), style: const TextStyle(fontSize: 10)),
      showEditIcon: false,
      placeholder: false,
    );
  }
}
