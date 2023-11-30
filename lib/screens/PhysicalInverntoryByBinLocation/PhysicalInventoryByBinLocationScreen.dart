// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:alessa_v2/controllers/PhysicalInventory/insertIntoWmsJournalCountingOnlyCLDetsController.dart';
import 'package:alessa_v2/controllers/PhysicalInventory/validateItemSerialNumberForJournalCountingOnlyCLDetsController.dart';
import 'package:alessa_v2/controllers/PhysicalInventoryByBinLocation/getWmsJournalCountingOnlyCLByBinLocationController.dart';
import 'package:alessa_v2/controllers/PhysicalInventoryByBinLocation/incrementQTYSCANNEDInJournalCountingOnlyCLByBinLocationController.dart';
import 'package:alessa_v2/models/GetWmsJournalCountingOnlyCLByAssignedToUserIdModel.dart';
import 'package:alessa_v2/models/validateItemSerialNumberForJournalCountingOnlyCLDetsModel.dart';
import 'package:alessa_v2/widgets/AppBarWidget.dart';
import 'package:alessa_v2/widgets/TextFormField.dart';
import 'package:alessa_v2/widgets/TextWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhysicalInventoryByBinLocationScreen extends StatefulWidget {
  const PhysicalInventoryByBinLocationScreen({super.key});

  @override
  State<PhysicalInventoryByBinLocationScreen> createState() =>
      _PhysicalInventoryByBinLocationScreenState();
}

class _PhysicalInventoryByBinLocationScreenState
    extends State<PhysicalInventoryByBinLocationScreen> {
  final TextEditingController _palletController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();

  List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel> tbl1 = [];
  List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel> filterTable = [];
  List<validateItemSerialNumberForJournalCountingOnlyCLDetsModel> tbl2 = [];

  String total = "0";
  String total2 = "0";

  List<bool> isMarked = [];

  String _site = "By Serial";
  String _site1 = "bin";

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

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Constants.showLoadingDialog(context);
      getWmsJournalCountingOnlyCLByBinLocationController
          .getData()
          .then((value) {
        setState(() {
          tbl1 = value;
          isMarked = List<bool>.generate(tbl1.length, (index) => false);
          total = tbl1.length.toString();
          filterTable = value;

          for (var element in tbl1) {
            binDropDownList.add(element.bINLOCATION.toString());
          }
          binDropDownList
              .removeWhere((element) => element == "null" || element == "");
          binDropDownList = binDropDownList.toSet().toList();
          binDropDownList.sort();

          for (var element in tbl1) {
            itemDropDownList.add(element.iTEMID.toString());
          }
          itemDropDownList
              .removeWhere((element) => element == "null" || element == "");
          itemDropDownList = itemDropDownList.toSet().toList();
          itemDropDownList.sort();

          itemDropDownValue = itemDropDownList[0];
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceAll("Exception:", "")),
          ),
        );
      });
    });
  }

  List<String> binDropDownValue = [];
  List<String> binDropDownList = [];

  String itemDropDownValue = "";
  List<String> itemDropDownList = [];

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
            title: "WMS Inventory".toUpperCase(),
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
        body: SizedBox(
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
                    color: Colors.orange.withOpacity(0.2),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.withOpacity(0.2),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: ListTile(
                          title: const AutoSizeText(
                            'Item Id',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          leading: Radio(
                            value: "item",
                            groupValue: _site1,
                            onChanged: (String? value) {
                              setState(() {
                                _site1 = value!;
                                print(_site1);
                                filterTable = tbl1;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const AutoSizeText(
                            'Bin Location',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          leading: Radio(
                            value: "bin",
                            groupValue: _site1,
                            onChanged: (String? value) {
                              setState(() {
                                _site1 = value!;
                                print(_site1);
                                filterTable = tbl1;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _site1 == "item" ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: TextWidget(
                      text: "Filter By Item Id",
                      color: Colors.blue[900]!,
                      fontSize: 15,
                    ),
                  ),
                ),
                Visibility(
                  visible: _site1 == "item" ? true : false,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            items: itemDropDownList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: TextWidget(
                                  text: value,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              );
                            }).toList(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                itemDropDownValue = value.toString();
                                filterTable = tbl1
                                    .where((element) =>
                                        element.iTEMID.toString().trim() ==
                                        value.toString().trim())
                                    .toList();
                                total = filterTable.length.toString();
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                              size: 20,
                            ),
                            value: itemDropDownValue,
                            elevation: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _site1 == "bin" ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Filter By Bin Location",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]!,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _site1 == "bin" ? true : false,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: MultiSelectDialogField(
                        items: binDropDownList
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          setState(() {
                            binDropDownValue = values;
                            // filter the table based on the selected bin locations in the values
                            filterTable = tbl1
                                .where((element) => values.contains(
                                    element.bINLOCATION.toString().trim()))
                                .toList();

                            total = filterTable.length.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    child: PaginatedDataTable(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TextWidget(text: "TOTAL", fontSize: 16),
                          const SizedBox(width: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextWidget(text: total, fontSize: 16),
                            ),
                          ),
                        ],
                      ),

                      columnSpacing: 10,
                      horizontalMargin: 20,
                      showCheckboxColumn: false,
                      headingRowHeight: 30,
                      dataRowHeight: 60,
                      primary: true,
                      showFirstLastButtons: true,
                      source: StudentDataSource(filterTable, context),
                      rowsPerPage: 3,
                      checkboxHorizontalMargin: 10,
                      columns: [
                        DataColumn(
                            label: Text(
                          'ITEM ID',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM NAME',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVERNTORY BY',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX DATE TIME',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED BY',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY ON HAND',
                          style: TextStyle(color: Colors.blue[900]!),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY SCANNED',
                          style: TextStyle(color: Colors.blue[900]!),
                        )),
                        DataColumn(
                            label: Text(
                          'QTY DIFFERENCE',
                          style: TextStyle(color: Colors.blue[900]!),
                        )),
                        DataColumn(
                            label: Text(
                          'BIN LOCATION',
                          style: TextStyle(color: Colors.blue[900]!),
                        )),
                      ], // Adjust the number of rows per page as needed
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: ListTile(
                          title: const Text('By Pallet'),
                          leading: Radio(
                            value: "By Pallet",
                            groupValue: _site,
                            onChanged: (String? value) {
                              // setState(() {
                              //   _site = value!;
                              //   print(_site);
                              // });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text('By Serial'),
                          leading: Radio(
                            value: "By Serial",
                            groupValue: _site,
                            onChanged: (String? value) {
                              setState(() {
                                _site = value!;
                                print(_site);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _site != "" ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    child: TextWidget(
                      text:
                          _site == "By Pallet" ? "Scan Pallet" : "Scan Serial#",
                      color: Colors.blue[900]!,
                      fontSize: 15,
                    ),
                  ),
                ),
                _site == "By Pallet"
                    ? Visibility(
                        visible: _site != "" ? true : false,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormFieldWidget(
                            controller: _palletController,
                            readOnly: false,
                            hintText: "Enter/Scan Pallet No",
                            width: MediaQuery.of(context).size.width * 0.9,
                            onEditingComplete: () {},
                          ),
                        ),
                      )
                    : Visibility(
                        visible: _site != "" ? true : false,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormFieldWidget(
                            controller: _serialController,
                            readOnly: false,
                            hintText: "Enter/Scan Serial No",
                            width: MediaQuery.of(context).size.width * 0.9,
                            onEditingComplete: () {
                              if (_serialController.text.trim().isEmpty) {
                                // hide keyboard
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                return;
                              }

                              FocusScope.of(context).requestFocus(FocusNode());
                              Constants.showLoadingDialog(context);
                              validateItemSerialNumberForJournalCountingOnlyCLDetsController
                                  .getData(_serialController.text.trim())
                                  .then((response) {
                                var table2 = response.allData![0];
                                print(table2.binLocation.toString().trim());

                                if (!tbl1.any((element) =>
                                    element.bINLOCATION.toString().trim() ==
                                    table2.binLocation.toString().trim())) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Mapped Bin Location not found in the list",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  tbl2.add(response);

                                  // // remove the selected pallet code row from the GetShipmentPalletizingList
                                  // tbl1.removeAt(
                                  //   tbl1.indexWhere(
                                  //     (element) =>
                                  //         element.bINLOCATION ==
                                  //         table2.binLocation.toString(),
                                  //   ),
                                  // );

                                  total2 = tbl2.length.toString();

                                  // total = tbl1.length.toString();
                                });
                                incrementQTYSCANNEDInJournalCountingOnlyCLByBinLocationController
                                    .getData(
                                  tbl1[0].tRXUSERIDASSIGNED.toString(),
                                  table2.trxDate.toString(),
                                  table2.binLocation.toString(),
                                )
                                    .then((value) {
                                  insertIntoWmsJournalCountingOnlyCLDetsController
                                      .getData(
                                    table2.toJson(),
                                    table2.classification.toString(),
                                    table2.binLocation.toString(),
                                    value.toString(),
                                    table2.itemSerialNo.toString(),
                                    table2.itemCode.toString(),
                                    table2.itemDesc.toString(),
                                    "physicalInventoryBinLocation",
                                  )
                                      .then((val) {
                                    setState(() {
                                      // if binLocation is contain in filterTable then qtyScanned will increase + 1
                                      filterTable[filterTable.indexWhere(
                                              (element) =>
                                                  element.bINLOCATION
                                                      .toString()
                                                      .trim() ==
                                                  table2.binLocation
                                                      .toString()
                                                      .trim())]
                                          .qTYSCANNED = filterTable[filterTable
                                                  .indexWhere((element) =>
                                                      element.bINLOCATION
                                                          .toString()
                                                          .trim() ==
                                                      table2.binLocation
                                                          .toString()
                                                          .trim())]
                                              .qTYSCANNED! +
                                          1;

                                      print(
                                          "Value: ${filterTable[filterTable.indexWhere((element) => element.bINLOCATION.toString().trim() == table2.binLocation.toString().trim())].qTYSCANNED}");

                                      print(
                                          "value1: ${filterTable[filterTable.indexWhere((element) => element.bINLOCATION.toString().trim() == table2.binLocation.toString().trim())].qTYSCANNED! + 1}");

                                      // if bin location is contain in filterTable then qtyDifference will be calculated as qtyScanned - qtyOnHand
                                      filterTable[filterTable.indexWhere((element) => element.bINLOCATION.toString().trim() == table2.binLocation.toString().trim())]
                                          .qTYDIFFERENCE = filterTable[
                                                  filterTable.indexWhere(
                                                      (element) =>
                                                          element.bINLOCATION
                                                              .toString()
                                                              .trim() ==
                                                          table2.binLocation
                                                              .toString()
                                                              .trim())]
                                              .qTYONHAND! -
                                          filterTable[filterTable.indexWhere(
                                                  (element) =>
                                                      element.bINLOCATION
                                                          .toString()
                                                          .trim() ==
                                                      table2.binLocation
                                                          .toString()
                                                          .trim())]
                                              .qTYSCANNED!;
                                    });
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Item Added Successfully",
                                        ),
                                      ),
                                    );
                                    _serialController.clear();
                                  }).onError((error, stackTrace) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          error
                                              .toString()
                                              .replaceAll("Exception:", ""),
                                        ),
                                      ),
                                    );
                                  });
                                }).onError((error, stackTrace) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        error
                                            .toString()
                                            .replaceAll("Exception:", ""),
                                      ),
                                    ),
                                  );
                                });
                              }).onError((error, stackTrace) {
                                // print("Hello");
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      error
                                          .toString()
                                          .replaceAll("Exception:", ''),
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
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
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM NAME',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'USER',
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
                            'CONFIG',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM SERIAL NO.',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'QTY SCANNED',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'BIN LOCATION',
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                        rows: tbl2.map((e) {
                          return DataRow(onSelectChanged: (value) {}, cells: [
                            DataCell(Text((tbl2.indexOf(e) + 1).toString())),
                            DataCell(Text(e.allData![0].itemCode ?? "")),
                            DataCell(Text(e.allData![0].itemDesc ?? "")),
                            DataCell(Text(e.allData![0].user ?? "")),
                            DataCell(Text(e.allData![0].sID ?? "")),
                            DataCell(Text(e.allData![0].classification ?? "")),
                            DataCell(Text(e.allData![0].itemSerialNo ?? "")),
                            DataCell(Text(e.allData![0].pO ?? "")),
                            DataCell(Text(e.allData![0].binLocation ?? "")),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                          child: TextWidget(text: total2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDataSource extends DataTableSource {
  List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel> students;
  BuildContext ctx;

  StudentDataSource(
    this.students,
    this.ctx,
  );

  @override
  DataRow? getRow(int index) {
    if (index >= students.length) {
      return null;
    }

    final student = students[index];

    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {},
      cells: [
        DataCell(SelectableText(student.iTEMID ?? '')),
        DataCell(SelectableText(student.iTEMNAME ?? '')),
        DataCell(SelectableText(student.iNVENTORYBY ?? '')),
        DataCell(SelectableText(student.tRXDATETIME ?? '')),
        DataCell(SelectableText(student.tRXUSERIDASSIGNED ?? '')),
        DataCell(SelectableText(student.tRXUSERIDASSIGNEDBY ?? '')),
        DataCell(SelectableText(student.qTYONHAND.toString() == "null"
            ? "0"
            : student.qTYONHAND.toString())),
        DataCell(SelectableText(student.qTYSCANNED.toString() == "null"
            ? "0"
            : student.qTYSCANNED.toString())),
        DataCell(SelectableText(student.qTYDIFFERENCE.toString() == "null"
            ? "0"
            : student.qTYDIFFERENCE.toString())),
        DataCell(SelectableText(student.bINLOCATION ?? '')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => students.length;

  @override
  int get selectedRowCount => 0;
}
