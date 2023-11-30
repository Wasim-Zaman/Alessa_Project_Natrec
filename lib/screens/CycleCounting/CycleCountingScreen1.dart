import 'package:alessa_v2/controllers/CycleCounting/insertWMSJournalCountingCLDetsController.dart';
import 'package:alessa_v2/controllers/CycleCounting/updateWmsournalCountingCLQtyScannedController.dart';
import 'package:alessa_v2/controllers/JournalMovement/ValidateItemSerialNumberForJournalMovementCLDetsController.dart';
import 'package:alessa_v2/models/GetmapBarcodeDataByBinLocationModel.dart';
import 'package:alessa_v2/models/updateWmsJournalMovementClQtyScannedModel.dart';
import 'package:alessa_v2/widgets/TextFormField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/CycleCounting/getWmsJournalCountingCLByAssignedToUserIdController.dart';
import '../../models/getWmsJournalMovementClByAssignedToUserIdModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextWidget.dart';

class CycleCountingScreen1 extends StatefulWidget {
  const CycleCountingScreen1({super.key});

  @override
  State<CycleCountingScreen1> createState() => _CycleCountingScreen1State();
}

class _CycleCountingScreen1State extends State<CycleCountingScreen1> {
  final TextEditingController _serialNoController = TextEditingController();

  String total = "0";
  String total2 = "0";
  List<getWmsJournalMovementClByAssignedToUserIdModel> table = [];
  List<getWmsJournalMovementClByAssignedToUserIdModel> filterTable = [];

  List<GetmapBarcodeDataByBinLocationModel> table2 = [];

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

  String? journalIdValue = "";
  List<String> journalIdList = [];

  List<String> itemIdValue = [];
  List<String> itemIdList = [];

  FocusNode _focusNode = FocusNode();

  updateWmsJournalMovementClQtyScannedModel
      updateWmsJournalMovementClQtyScannedList =
      updateWmsJournalMovementClQtyScannedModel();

  @override
  void initState() {
    super.initState();
    _showUserInfo();
    Future.delayed(Duration.zero, () {
      Constants.showLoadingDialog(context);
      getWmsJournalCountingCLByAssignedToUserIdController
          .getData()
          .then((value) {
        setState(() {
          table = value;

          filterTable = value;

          // get the journalIdList
          journalIdList =
              table.map((e) => e.jOURNALID.toString()).toSet().toList();
          // convert to set
          journalIdList = journalIdList.toSet().toList();
          // sort the list
          journalIdList.sort((a, b) => a.compareTo(b));
          // remove the empty string
          journalIdList.removeWhere((element) => element == "");
          journalIdValue = journalIdList[0];

          // get the itemIdList
          itemIdList = table.map((e) => e.iTEMID.toString()).toSet().toList();
          // convert to set
          itemIdList = itemIdList.toSet().toList();
          // sort the list
          itemIdList.sort((a, b) => a.compareTo(b));
          // remove the empty string
          itemIdList.removeWhere((element) => element == "");

          isMarked = List<bool>.generate(table.length, (index) => false);
          total = table.length.toString();
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
            title: "Cycle Counting".toUpperCase(),
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
                  child: Text(
                    "Filter By Journal ID",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(left: 20),
                  child: DropdownSearch<String>(
                    items: journalIdList,
                    onChanged: (value) {
                      setState(() {
                        journalIdValue = value!;
                        // filter the filterTable by journalIdValue
                        filterTable = table
                            .where((element) =>
                                element.jOURNALID.toString() ==
                                journalIdValue.toString())
                            .toList();
                        total = filterTable.length.toString();
                      });
                    },
                    selectedItem: journalIdValue,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Filter By Item Id",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: MultiSelectDialogField(
                      items:
                          itemIdList.map((e) => MultiSelectItem(e, e)).toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        itemIdValue = values;
                        setState(() {
                          filterTable = table
                              .where((element) =>
                                  itemIdValue.contains(
                                      element.iTEMID.toString().trim()) ==
                                  true)
                              .toList();
                          total = filterTable.length.toString();

                          if (itemIdValue.isEmpty || itemIdValue.length == 0) {
                            filterTable = table;
                            total = filterTable.length.toString();
                          }
                        });
                      },
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
                      // header: Text(
                      //   "Total: $total",
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.blue[900]!,
                      //   ),
                      // ),

                      columnSpacing: 10,
                      horizontalMargin: 20,
                      showCheckboxColumn: false,
                      headingRowHeight: 30,
                      dataRowHeight: 60,
                      primary: true,
                      showFirstLastButtons: true,
                      source: StudentDataSource(filterTable, context),
                      rowsPerPage: 5,
                      checkboxHorizontalMargin: 10,
                      columns: const [
                        DataColumn(
                            label: Text(
                          'ITEM ID',
                          style: TextStyle(color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM NAME',
                          style: TextStyle(color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'QTY',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'LEDGER ACCOUNT ID OFFSET',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'JOURNAL ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRANS DATE',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT SITE ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'INVENT LOCATION ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'CONFIG ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'WMS LOCATION ID',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX DATE TIME',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'TRX USER ID ASSIGNED BY',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM SERIAL NO',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY SCANNED',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'QTY DIFFERENCE',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                      ], // Adjust the number of rows per page as needed
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const TextWidget(
                      text: "TOTAL",
                      fontSize: 16,
                    ),
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
                        child: TextWidget(
                          text: total,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: TextWidget(
                    text: "Scan Serial#",
                    color: Colors.blue[900]!,
                    fontSize: 15,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    controller: _serialNoController,
                    focusNode: _focusNode,
                    readOnly: false,
                    hintText: "Enter/Scan Serial No",
                    width: MediaQuery.of(context).size.width * 0.9,
                    onEditingComplete: () {
                      String serialNo = _serialNoController.text
                          .trim()
                          .toString()
                          .replaceAll("", "");

                      if (serialNo.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }

                      FocusScope.of(context).requestFocus(FocusNode());
                      Constants.showLoadingDialog(context);

                      ValidateItemSerialNumberForJournalMovementCLDetsController
                          .getData(
                        serialNo.trim(),
                        'validateItemSerialNumberForJournalCountingOnlyCLDets',
                      ).then((validate) {
                        if (filterTable
                            .where((element) =>
                                element.iTEMID.toString().trim() !=
                                validate.itemCode.toString().trim())
                            .toList()
                            .isNotEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: TextWidget(
                                text:
                                    "Serial number not exist in mapped barcode.",
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        updateWmsournalCountingCLQtyScannedController
                            .getData(
                          filterTable
                              .where((element) =>
                                  element.iTEMID.toString().trim() ==
                                  validate.itemCode.toString().trim())
                              .toList()[0]
                              .iTEMID
                              .toString(),
                          filterTable
                              .where((element) =>
                                  element.iTEMID.toString().trim() ==
                                  validate.itemCode.toString().trim())
                              .toList()[0]
                              .jOURNALID
                              .toString(),
                          filterTable
                              .where((element) =>
                                  element.iTEMID.toString().trim() ==
                                  validate.itemCode.toString().trim())
                              .toList()[0]
                              .tRXUSERIDASSIGNED
                              .toString(),
                        )
                            .then((value) {
                          setState(() {
                            updateWmsJournalMovementClQtyScannedList = value;
                          });
                          insertWMSJournalCountingCLDetsController
                              .getData(
                            updateWmsJournalMovementClQtyScannedList,
                            serialNo.trim(),
                          )
                              .then((value) {
                            setState(
                              () {
                                // check if the entered serial no is not present in the table
                                if (table
                                    .where((element) =>
                                        element.iTEMSERIALNO
                                            .toString()
                                            .trim() !=
                                        serialNo.trim())
                                    .toList()
                                    .isEmpty) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: TextWidget(
                                        text:
                                            "Serial No. not found in the list, please scan a serial no from the above list.",
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                // increase the qtyScanned by 1 in filterTable
                                filterTable
                                    .where((element) =>
                                        element.iTEMID.toString().trim() ==
                                        validate.itemCode.toString().trim())
                                    .toList()[0]
                                    .qTYSCANNED = double.parse(filterTable
                                        .where((element) =>
                                            element.iTEMID.toString().trim() ==
                                            validate.itemCode.toString().trim())
                                        .toList()[0]
                                        .qTYSCANNED
                                        .toString()) +
                                    1;

                                // make qtyDifference = qty - qtyScanned
                                filterTable
                                    .where((element) =>
                                        element.iTEMID.toString().trim() ==
                                        validate.itemCode.toString().trim())
                                    .toList()[0]
                                    .qTYDIFFERENCE = double.parse(filterTable
                                        .where((element) =>
                                            element.iTEMID.toString().trim() ==
                                            validate.itemCode.toString().trim())
                                        .toList()[0]
                                        .qTY
                                        .toString()) -
                                    double.parse(filterTable
                                        .where((element) =>
                                            element.iTEMID.toString().trim() ==
                                            validate.itemCode.toString().trim())
                                        .toList()[0]
                                        .qTYSCANNED
                                        .toString());

                                table2.add(validate);
                                total2 = table2.length.toString();
                              },
                            );
                            _serialNoController.clear();

                            Navigator.pop(context);
                            FocusScope.of(context).requestFocus(_focusNode);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: TextWidget(
                                  text: "Record Inserted Successfully.",
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }).onError((error, stackTrace) {
                            Navigator.pop(context);
                          });
                        }).onError((error, stackTrace) {
                          Navigator.pop(context);
                        });
                      }).onError((error, stackTrace) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: TextWidget(
                              text:
                                  error.toString().replaceAll("Exception:", ""),
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                            'Item Code',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Item Desc',
                            style: TextStyle(color: Colors.white),
                          )),
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
                              label: Text(
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
                              label: Text(
                            'Item Serial No.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                            label: Text(
                              'Map Date',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Pallet Code',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Reference',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'S-ID',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'C-ID',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'PO',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Trans',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        rows: table2.map((e) {
                          return DataRow(onSelectChanged: (value) {}, cells: [
                            DataCell(SelectableText(
                                (table2.indexOf(e) + 1).toString())),
                            DataCell(SelectableText(e.itemCode ?? "")),
                            DataCell(SelectableText(e.itemDesc ?? "")),
                            DataCell(SelectableText(e.gTIN ?? "")),
                            DataCell(SelectableText(e.remarks ?? "")),
                            DataCell(SelectableText(e.user ?? "")),
                            DataCell(SelectableText(e.classification ?? "")),
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
                            DataCell(SelectableText(e.trans.toString() == "null"
                                ? "0"
                                : e.trans.toString())),
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
                    const TextWidget(
                      text: "TOTAL",
                      fontSize: 14,
                    ),
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
                        child: TextWidget(
                          text: total2.toString(),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
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
  List<getWmsJournalMovementClByAssignedToUserIdModel> students;
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
      onSelectChanged: (value) {
        // Get.to(() => ProfitAndLossScreen2(
        //       iTEMID: student.iTEMID.toString(),
        //       iTEMNAME: student.iTEMNAME.toString(),
        //       qTY: int.parse(student.qTY.toString()),
        //       lEDGERACCOUNTIDOFFSET: student.lEDGERACCOUNTIDOFFSET.toString(),
        //       jOURNALID: student.jOURNALID.toString(),
        //       tRANSDATE: student.tRANSDATE.toString(),
        //       iNVENTSITEID: student.iNVENTSITEID.toString(),
        //       iNVENTLOCATIONID: student.iNVENTLOCATIONID.toString(),
        //       cONFIGID: student.cONFIGID.toString(),
        //       wMSLOCATIONID: student.wMSLOCATIONID.toString(),
        //       tRXDATETIME: student.tRXDATETIME.toString(),
        //       tRXUSERIDASSIGNED: student.tRXUSERIDASSIGNED.toString(),
        //       tRXUSERIDASSIGNEDBY: student.tRXUSERIDASSIGNEDBY.toString(),
        //       iTEMSERIALNO: student.iTEMSERIALNO.toString() == "null"
        //           ? 0
        //           : int.parse(student.iTEMSERIALNO.toString()),
        //       qTYSCANNED: student.qTYSCANNED.toString() == "null"
        //           ? 0
        //           : int.parse(student.qTYSCANNED.toString()),
        //       qTYDIFFERENCE: student.qTYDIFFERENCE.toString() == "null"
        //           ? 0
        //           : int.parse(student.qTYDIFFERENCE.toString()),
        //     ));
      },
      cells: [
        DataCell(SelectableText(student.iTEMID ?? "")),
        DataCell(SelectableText(student.iTEMNAME ?? "")),
        DataCell(SelectableText(
            student.qTY.toString() == "null" ? "0" : student.qTY.toString())),
        DataCell(SelectableText(student.lEDGERACCOUNTIDOFFSET ?? "")),
        DataCell(SelectableText(student.jOURNALID ?? "")),
        DataCell(SelectableText(student.tRANSDATE ?? "")),
        DataCell(SelectableText(student.iNVENTSITEID ?? "")),
        DataCell(SelectableText(student.iNVENTLOCATIONID ?? "")),
        DataCell(SelectableText(student.cONFIGID ?? "")),
        DataCell(SelectableText(student.wMSLOCATIONID ?? "")),
        DataCell(SelectableText(student.tRXDATETIME ?? "")),
        DataCell(SelectableText(student.tRXUSERIDASSIGNED ?? "")),
        DataCell(SelectableText(student.tRXUSERIDASSIGNEDBY ?? "")),
        DataCell(SelectableText(student.iTEMSERIALNO.toString() == "null"
            ? ""
            : student.iTEMSERIALNO.toString())),
        DataCell(SelectableText(student.qTYSCANNED.toString() == "null"
            ? "0"
            : student.qTYSCANNED.toString())),
        DataCell(SelectableText(student.qTYDIFFERENCE.toString() == "null"
            ? "0"
            : student.qTYDIFFERENCE.toString())),
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
