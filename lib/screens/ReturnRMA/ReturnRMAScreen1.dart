// ignore_for_file: prefer_final_fields, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/ReturnRMA/getWmsReturnSalesOrderByReturnItemNumController.dart';
import '../../models/getWmsReturnSalesOrderByReturnItemNumModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextWidget.dart';
import '../../widgets/TextFormField.dart';
import 'ReturnRMAScreen2.dart';

var recQty;

class ReturnRMAScreen1 extends StatefulWidget {
  const ReturnRMAScreen1({super.key});

  @override
  State<ReturnRMAScreen1> createState() => _ReturnRMAScreen1State();
}

class _ReturnRMAScreen1State extends State<ReturnRMAScreen1> {
  TextEditingController _searchController = TextEditingController();
  String total = "0";
  List<getWmsReturnSalesOrderByReturnItemNumModel> table = [];
  List<bool> isMarked = [];

  String userName = "";
  String userID = "";

  void _showUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    final String? userId = prefs.getString('userId');
    final String? fullName = prefs.getString('fullName');
    // final String? userLevel = prefs.getString('userLevel');
    // final String? loc = prefs.getString('userLocation');

    setState(() {
      userName = fullName!;
      userID = userId!;
    });
  }

  @override
  void initState() {
    super.initState();
    _showUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            autoImplyLeading: true,
            onPressed: () {
              Get.back();
            },
            title: "Return  RMA".toUpperCase(),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    "assets/delete.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Current Logged in User Id: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userID,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[900]!,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const TextWidget(
                    text: "RMA*",
                    fontSize: 16,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TextFormFieldWidget(
                          controller: _searchController,
                          hintText: "Enter/Scan RMA",
                          width: MediaQuery.of(context).size.width * 0.73,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            if (_searchController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please enter RMA",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            Constants.showLoadingDialog(context);
                            getWmsReturnSalesOrderByReturnItemNumController
                                .getData(_searchController.text.trim())
                                .then((value) {
                              setState(() {
                                table = value;
                                isMarked = List<bool>.generate(
                                    table.length, (index) => false);
                                total = table.length.toString();

                                recQty = table[0].eXPECTEDRETQTY;
                              });
                              Navigator.of(context).pop();
                            }).onError((error, stackTrace) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    error
                                        .toString()
                                        .replaceAll("Exception", ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_searchController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please enter RMA",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            Constants.showLoadingDialog(context);
                            getWmsReturnSalesOrderByReturnItemNumController
                                .getData(_searchController.text.trim())
                                .then((value) {
                              setState(() {
                                table = value;
                                isMarked = List<bool>.generate(
                                    table.length, (index) => false);
                                total = table.length.toString();

                                recQty = table[0].eXPECTEDRETQTY;
                              });
                              Navigator.of(context).pop();
                            }).onError((error, stackTrace) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    error
                                        .toString()
                                        .replaceAll("Exception", ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                          child: Image.asset('assets/finder.png',
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: 60,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: const TextWidget(
                    text: "Items*",
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showCheckboxColumn: false,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey.withOpacity(0.2)),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        columns: const [
                          DataColumn(
                              label: Text(
                            'ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM ID',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM NAME',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'EXPECTED RET QTY',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'SALES ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'RETURN ITEM NUM',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'INVENT SITE ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'INVENT LOCATION ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'CONFIG ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'WMS LOCATION ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                        ],
                        rows: table.map((e) {
                          return DataRow(
                              onSelectChanged: (value) {
                                Get.to(() => ReturnRMAScreen2(
                                      cONFIGID: e.cONFIGID.toString(),
                                      eXPECTEDRETQTY: int.parse(e.eXPECTEDRETQTY
                                                  .toString()) ==
                                              "null"
                                          ? 0
                                          : int.parse(
                                              e.eXPECTEDRETQTY.toString()),
                                      iNVENTLOCATIONID:
                                          e.iNVENTLOCATIONID.toString(),
                                      iNVENTSITEID: e.iNVENTSITEID.toString(),
                                      iTEMID: e.iTEMID.toString(),
                                      nAME: e.nAME.toString(),
                                      rETURNITEMNUM: e.rETURNITEMNUM.toString(),
                                      sALESID: e.sALESID.toString(),
                                      wMSLOCATIONID: e.wMSLOCATIONID.toString(),
                                      tble: e,
                                    ));
                              },
                              cells: [
                                DataCell(
                                    Text((table.indexOf(e) + 1).toString())),
                                DataCell(Text(e.iTEMID.toString())),
                                DataCell(Text(e.nAME.toString())),
                                DataCell(Text(e.eXPECTEDRETQTY.toString())),
                                DataCell(Text(e.sALESID.toString())),
                                DataCell(Text(e.rETURNITEMNUM.toString())),
                                DataCell(Text(e.iNVENTSITEID.toString())),
                                DataCell(Text(e.iNVENTLOCATIONID.toString())),
                                DataCell(Text(e.cONFIGID.toString())),
                                DataCell(Text(e.wMSLOCATIONID.toString())),
                              ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const TextWidget(text: "TOTAL"),
                    const SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextWidget(text: total),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
