import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:erp-mockup___erp/environments/environment.dart';
import 'package:erp-mockup___erp/environments/erp_main_drawer.dart';
import 'package:erp-mockup___erp/models/register_model/register_model.dart';
import 'package:erp-mockup___erp/screens/goods_acceptance/purchase_request_according_to_company_widget.dart';
import 'package:http/http.dart' as http;
import 'package:erp-mockup___erp/screens/home_screen_widget.dart';

class ExpectedCompaniesWidget extends StatefulWidget {
  const ExpectedCompaniesWidget({Key? key}) : super(key: key);

  @override
  _ExpectedCompaniesWidgetState createState() =>
      _ExpectedCompaniesWidgetState();
}

class _ExpectedCompaniesWidgetState extends State<ExpectedCompaniesWidget> {
  List<RegisterValue> modelListFilter = [];
  List<RegisterValue> modelListOriginal = [];
  var txtExpectedCompaniesSearch = TextEditingController();

  final url = "PurchaseRequestCompany/GetWaitedCompanies";
  Future<List<RegisterValue>> getExpectedCompanies() async {
    final response = await http.get(
      Uri.parse(Environment.baseUrl + url),
      headers: Environment.apiHeader,
    );

    if (response.statusCode == 200) {
      var jsons = jsonDecode(response.body);

      List<RegisterValue> valueList = [];
      for (var json in jsons["value"]) {
        RegisterValue model = RegisterValue.fromJson(json);

        valueList.add(model);
      }
      setState(() {});
      return valueList;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();

    getExpectedCompanies().then((value) {
      modelListOriginal.addAll(value);
      modelListFilter.addAll(value);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              splashColor: Colors.amber,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenWidget()));
              },
              icon: const Icon(Icons.home)),
        ],
        title: TextField(
          controller: txtExpectedCompaniesSearch,
          onChanged: (value) {
            modelListFilter.clear();
            for (var item in modelListOriginal) {
              if (item.unvan.toLowerCase().startsWith(value.toLowerCase())) {
                modelListFilter.add(item);
              }
              setState(() {});
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
            hintText: "Beklenen Firmalarda Aramak İçin Dokun...",
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.black54,
      ),
      drawer: ERPMainDrawer.buildMainDrawer(context),
      body: modelListFilter.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            )
          // : ListView.builder(
          //     padding: const EdgeInsets.all(3),
          //     itemCount: modelListFilter.length,
          //     itemBuilder: (context, i) {
          //       return Card(
          //         shadowColor: Colors.amberAccent.shade100,
          //         margin: const EdgeInsets.all(10.0),
          //         elevation: 20,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         child: InkWell(
          //           splashColor: Colors.amber.withAlpha(500),
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) =>
          //                         PurchaseRequestAccordingToCompany(
          //                             sayi: modelListFilter[i].id)));
          //           },
          //           child: SizedBox(
          //             width: 70,
          //             height: 28,
          //             child: Text(
          //               modelListFilter[i].unvan,
          //               textAlign: TextAlign.center,
          //               style: const TextStyle(
          //                 fontSize: 18,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          : DataTable(
              dividerThickness: 5,
              showBottomBorder: true,
              columns: const [
                DataColumn(
                    label: Text(
                  "Firma Seçiniz...",
                )),
              ],
              rows: modelListFilter
                  .map((element) => DataRow(cells: [
                        DataCell(
                          Text(element.unvan),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PurchaseRequestAccordingToCompany(
                                            sayi: element.id)));
                          },
                        )
                      ]))
                  .toList()),
    );
  }
}
