// ignore_for_file: use_build_context_synchronously

import 'package:alessa_v2/screens/UnAllocatedItem/UnAllocatedItemsScreen2.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/UnAllocatedItem/GetAllItemsReAllocationPickedController.dart';
import '../../models/GetItemInfoByPalletCodeModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextWidget.dart';

class UnAllocatedItemsScreen1 extends StatefulWidget {
  const UnAllocatedItemsScreen1({super.key});

  @override
  State<UnAllocatedItemsScreen1> createState() =>
      _UnAllocatedItemsScreen1State();
}

class _UnAllocatedItemsScreen1State extends State<UnAllocatedItemsScreen1> {
  String total = "0";
  List<GetItemInfoByPalletCodeModel> table = [];
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
    Future.delayed(Duration.zero, () async {
      try {
        Constants.showLoadingDialog(context);
        var value = await GetAllItemsReAllocationPickedController.getData();
        setState(() {
          table = value;
          isMarked = List<bool>.generate(table.length, (index) => false);
          total = table.length.toString();
        });
        Navigator.of(context).pop();
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceAll("Exception", ""),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
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
            title: "Un-Allocated Items".toUpperCase(),
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                              label: SelectableText('Item Code',
                                  style: TextStyle(color: Colors.white))),
                          DataColumn(
                              label: Text('Item Desc',
                                  style: TextStyle(color: Colors.white))),
                          DataColumn(
                              label: Text(
                            'GTIN',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Remarks',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'User',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Classification',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Main Location',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: SelectableText(
                            'Bin Location',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Int Code',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: SelectableText(
                            'Item Serial No.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Map Date',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: SelectableText(
                            'Pallet Code',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Reference',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'SID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'CID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'PO',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Trans',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                        ],
                        rows: table.map((e) {
                          return DataRow(
                              onSelectChanged: (value) {
                                Get.to(() => UnAllocatedItemsScreen2(
                                      itemCode: e.itemCode.toString(),
                                      itemDesc: e.itemDesc.toString(),
                                      itemSerialNo: e.itemSerialNo.toString(),
                                      binLocation: e.binLocation.toString(),
                                      cID: e.cID.toString(),
                                      classification:
                                          e.classification.toString(),
                                      gtin: e.gTIN.toString(),
                                      intCode: e.intCode.toString(),
                                      mainLocation: e.mainLocation.toString(),
                                      mapDate: e.mapDate.toString(),
                                      palletCode: e.palletCode.toString(),
                                      po: e.pO.toString(),
                                      reference: e.reference.toString(),
                                      remarks: e.remarks.toString(),
                                      sID: e.sID.toString(),
                                      user: e.user.toString(),
                                      trans: int.parse(e.trans.toString()),
                                    ));
                              },
                              cells: [
                                DataCell(SelectableText(
                                    (table.indexOf(e) + 1).toString())),
                                DataCell(SelectableText(e.itemCode ?? "")),
                                DataCell(SelectableText(e.itemDesc ?? "")),
                                DataCell(SelectableText(e.gTIN ?? "")),
                                DataCell(SelectableText(e.remarks ?? "")),
                                DataCell(SelectableText(e.user ?? "")),
                                DataCell(
                                    SelectableText(e.classification ?? "")),
                                DataCell(SelectableText(e.mainLocation ?? "")),
                                DataCell(SelectableText(e.binLocation ?? "")),
                                DataCell(SelectableText(e.intCode ?? "")),
                                DataCell(SelectableText(e.itemSerialNo ?? "")),
                                DataCell(SelectableText(e.mapDate ?? "")),
                                DataCell(SelectableText(e.palletCode ?? "")),
                                DataCell(SelectableText(e.reference ?? "")),
                                DataCell(SelectableText(e.sID ?? "")),
                                DataCell(SelectableText(e.cID ?? "")),
                                DataCell(SelectableText(e.pO ?? "")),
                                DataCell(SelectableText(e.trans.toString())),
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
