// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/TextFormField.dart';
import '../../../widgets/TextWidget.dart';
import '../../controllers/BinToBinFromAXAPTA/GetQtyReceivedController.dart';
import '../../controllers/BinToBinFromAXAPTA/getAxaptaTableData.dart';
import '../../models/GetAxaptaTableModel.dart';
import '../../utils/Constants.dart';
import 'BinToBinAxapta2Screen.dart';

class BinToBinAxaptaScreen extends StatefulWidget {
  const BinToBinAxaptaScreen({super.key});

  @override
  State<BinToBinAxaptaScreen> createState() => _BinToBinAxaptaScreenState();
}

class _BinToBinAxaptaScreenState extends State<BinToBinAxaptaScreen> {
  final TextEditingController _transferController = TextEditingController();
  String total = "0";

  List<GetAxaptaTableDataModel> table = [];
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: "Bin to Bin Transfer".toUpperCase(),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
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
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Internal AXAPTA*",
                  style: TextStyle(
                    color: Colors.blue[900]!,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: const TextWidget(
                  text: "Transfer ID*",
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
                        controller: _transferController,
                        hintText: "Enter/Scan Transfer ID",
                        width: MediaQuery.of(context).size.width * 0.73,
                        onEditingComplete: () {
                          onSearch();
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
                          onSearch();
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
                  text: "Shipment Details*",
                  fontSize: 16,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
                        // DataColumn(
                        //     label: Text(
                        //   'Mark',
                        //   style: TextStyle(color: Colors.white),
                        //   textAlign: TextAlign.center,
                        // )),
                        DataColumn(
                            label: Text(
                          'ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRANSFER ID',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'TRANSFER STATUS',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT LOCATION ID FROM',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT LOCATION ID To',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY TRANSFER',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY RECEIVED',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'CREATED DATE TIME',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'GROUP ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ],
                      rows: table.map((e) {
                        return DataRow(
                            onSelectChanged: (value) async {
                              // qty transfer is equal or greater than qty received
                              if (e.qTYRECEIVED! >= e.qTYTRANSFER!) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "All Quantities have been transfered."),
                                  ),
                                );
                                return;
                              }
                              Constants.showLoadingDialog(context);
                              num numb =
                                  await GetQtyReceivedController.getAllTable(
                                      e.tRANSFERID.toString(),
                                      e.iTEMID.toString());
                              try {
                                print("numb: $numb");
                                if (numb >= e.qTYTRANSFER!) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "All Quantities have been transfered."),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.of(context).pop();
                                setState(() {
                                  isMarked[table.indexOf(e)] = value!;
                                });
                                Get.to(
                                  () => BinToBinAxapta2Screen(
                                    TRANSFERID: e.tRANSFERID ?? "",
                                    TRANSFERSTATUS:
                                        int.parse(e.tRANSFERSTATUS.toString()),
                                    INVENTLOCATIONIDFROM:
                                        e.iNVENTLOCATIONIDFROM ?? "",
                                    INVENTLOCATIONIDTO:
                                        e.iNVENTLOCATIONIDTO ?? "",
                                    ITEMID: e.iTEMID ?? "",
                                    QTYTRANSFER:
                                        int.parse(e.qTYTRANSFER.toString()),
                                    QTYRECEIVED: int.parse(numb.toString()),
                                    CREATEDDATETIME: e.cREATEDDATETIME ?? "",
                                    GROUPID: e.gROUPID ?? "",
                                  ),
                                );
                              } catch (e) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e
                                        .toString()
                                        .replaceAll("Exception:", "")),
                                  ),
                                );
                              }
                            },
                            cells: [
                              DataCell(Text((table.indexOf(e) + 1).toString())),
                              DataCell(Text(e.tRANSFERID ?? "")),
                              DataCell(Text(e.tRANSFERSTATUS.toString())),
                              DataCell(Text(e.iNVENTLOCATIONIDFROM ?? "")),
                              DataCell(Text(e.iNVENTLOCATIONIDTO ?? "")),
                              DataCell(Text(e.iTEMID ?? "")),
                              DataCell(Text(e.qTYTRANSFER.toString())),
                              DataCell(Text(e.qTYRECEIVED.toString())),
                              DataCell(Text(e.cREATEDDATETIME ?? "")),
                              DataCell(Text(e.gROUPID ?? "")),
                            ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const TextWidget(text: "TOTAL"),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
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
            ],
          ),
        ),
      ),
    );
  }

  void onSearch() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Constants.showLoadingDialog(context);
    GetAxaptaTableDataController.getAllTable(_transferController.text.trim())
        .then((value) {
      Navigator.of(context).pop();
      setState(() {
        table = value;
        isMarked = List<bool>.generate(table.length, (index) => false);
        total = table.length.toString();
      });
    }).onError((error, stackTrace) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll("Exception:", "")),
        ),
      );
    });
  }
}
