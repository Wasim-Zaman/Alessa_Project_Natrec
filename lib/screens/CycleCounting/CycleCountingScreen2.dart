import '../../controllers/PickListAssigned/GetPickListTableDataController.dart';
import '../../controllers/PickListAssigned/getMappedBarcodedsByItemCodeAndBinLocationController.dart';
import '../../models/getMappedBarcodedsByItemCodeAndBinLocationModel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';

import '../../controllers/CycleCounting/insertWMSJournalCountingCLDetsController.dart';
import '../../controllers/CycleCounting/updateWmsournalCountingCLQtyScannedController.dart';
import '../../models/updateWmsJournalMovementClQtyScannedModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

// ignore: must_be_immutable
class CycleCountingScreen2 extends StatefulWidget {
  String iTEMID;
  String iTEMNAME;
  int qTY;
  String lEDGERACCOUNTIDOFFSET;
  String jOURNALID;
  String tRANSDATE;
  String iNVENTSITEID;
  String iNVENTLOCATIONID;
  String cONFIGID;
  String wMSLOCATIONID;
  String tRXDATETIME;
  String tRXUSERIDASSIGNED;
  String tRXUSERIDASSIGNEDBY;
  int iTEMSERIALNO;
  int qTYSCANNED;
  int qTYDIFFERENCE;

  CycleCountingScreen2({
    required this.iTEMID,
    required this.iTEMNAME,
    required this.qTY,
    required this.lEDGERACCOUNTIDOFFSET,
    required this.jOURNALID,
    required this.tRANSDATE,
    required this.iNVENTSITEID,
    required this.iNVENTLOCATIONID,
    required this.cONFIGID,
    required this.wMSLOCATIONID,
    required this.tRXDATETIME,
    required this.tRXUSERIDASSIGNED,
    required this.tRXUSERIDASSIGNEDBY,
    required this.iTEMSERIALNO,
    required this.qTYSCANNED,
    required this.qTYDIFFERENCE,
  });

  @override
  State<CycleCountingScreen2> createState() => _CycleCountingScreen2State();
}

class _CycleCountingScreen2State extends State<CycleCountingScreen2> {
  final TextEditingController _transferIdController = TextEditingController();
  final TextEditingController _palletTypeController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();

  String result = "0";
  String result2 = "0";
  List<String> serialNoList = [];
  List<bool> isMarked = [];

  List<getMappedBarcodedsByItemCodeAndBinLocationModel>
      GetShipmentPalletizingList = [];
  List<getMappedBarcodedsByItemCodeAndBinLocationModel>
      GetShipmentPalletizingList2 = [];

  updateWmsJournalMovementClQtyScannedModel
      updateWmsJournalMovementClQtyScannedList =
      updateWmsJournalMovementClQtyScannedModel();

  @override
  void initState() {
    super.initState();
    _transferIdController.text = widget.jOURNALID;

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Constants.showLoadingDialog(context);

      getMappedBarcodedsByItemCodeAndBinLocationController
          .getData(widget.iTEMID)
          .then((value) {
        dropDownList.clear();
        Navigator.pop(context);
        for (int i = 0; i < value.length; i++) {
          setState(() {
            if (value[i].binLocation != "") {
              dropDownList.add(value[i].binLocation ?? "");
            }
          });
        }

        // convert list to set to remove duplicate values
        Set<String> set = dropDownList.toSet();
        // convert set to list to get all values
        dropDownList = set.toList();

        setState(() {
          dropDownValue = dropDownList[0];
        });
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        setState(() {
          dropDownList.add("No Data Found");
          dropDownValue = dropDownList[0];
        });
      });
    });
  }

  String _site = "By Serial";

  String? dropDownValue;
  List<String> dropDownList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: const TextWidget(
                          text: "Transfer ID#",
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TextFormFieldWidget(
                          controller: _transferIdController,
                          readOnly: true,
                          hintText: "Transfer ID Number",
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {},
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: const TextWidget(
                              text: "From: ",
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.68,
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: DropdownSearch<String>(
                              items: dropDownList,
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value!;
                                });
                                FocusScope.of(context).unfocus();
                                Constants.showLoadingDialog(context);

                                GetPickListTableDataController.getData(
                                  widget.iTEMID,
                                  dropDownValue.toString(),
                                ).then((value) {
                                  setState(() {
                                    GetShipmentPalletizingList = value;
                                    Navigator.pop(context);
                                    result = value.length.toString();
                                  });
                                }).onError((error, stackTrace) {
                                  Navigator.pop(context);
                                  setState(() {
                                    GetShipmentPalletizingList = [];
                                    result = "0";
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(error.toString()),
                                    backgroundColor: Colors.red,
                                  ));
                                });
                              },
                              selectedItem: dropDownValue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Item ID:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.iTEMID,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Qty",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.qTY.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Qty Scanned",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.qTYSCANNED.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Pick Difference",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.qTYDIFFERENCE.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
                      rows: GetShipmentPalletizingList.map((e) {
                        return DataRow(onSelectChanged: (value) {}, cells: [
                          DataCell(SelectableText(
                              (GetShipmentPalletizingList.indexOf(e) + 1)
                                  .toString())),
                          DataCell(SelectableText(e.itemCode ?? "")),
                          DataCell(SelectableText(e.itemDesc ?? "")),
                          DataCell(SelectableText(e.gTIN ?? "")),
                          DataCell(SelectableText(e.remarks ?? "")),
                          DataCell(SelectableText(e.user ?? "")),
                          DataCell(SelectableText(e.classification ?? "")),
                          DataCell(SelectableText(e.mainLocation ?? "")),
                          DataCell(SelectableText(e.binLocation ?? "")),
                          DataCell(SelectableText(e.intCode ?? "")),
                          DataCell(
                            Row(
                              children: [
                                SelectableText(e.itemSerialNo ?? ""),
                                // icon for copying the serial number
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: e.itemSerialNo ?? "",
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Copied to Clipboard",
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy),
                                ),
                              ],
                            ),
                          ),
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
                      child: TextWidget(text: result.toString()),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
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
                    text: _site == "By Pallet" ? "Scan Pallet" : "Scan Serial#",
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
                          controller: _palletTypeController,
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
                          controller: _serialNoController,
                          readOnly: false,
                          hintText: "Enter/Scan Serial No",
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Constants.showLoadingDialog(context);
                            setState(
                              () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Constants.showLoadingDialog(context);

                                updateWmsournalCountingCLQtyScannedController
                                    .getData(
                                  widget.iTEMID,
                                  widget.jOURNALID,
                                  widget.tRXUSERIDASSIGNED,
                                )
                                    .then(
                                  (value) {
                                    setState(() {
                                      updateWmsJournalMovementClQtyScannedList =
                                          value;
                                    });
                                    insertWMSJournalCountingCLDetsController
                                        .getData(
                                            updateWmsJournalMovementClQtyScannedList,
                                            _serialNoController.text.trim())
                                        .then((value) {
                                      setState(
                                        () {
                                          // check if the entered serial no is not present in the GetShipmentPalletizingList
                                          if (GetShipmentPalletizingList.where(
                                                  (element) =>
                                                      element.itemSerialNo ==
                                                      _serialNoController.text
                                                          .trim())
                                              .toList()
                                              .isEmpty) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: TextWidget(
                                                  text:
                                                      "Serial No. not found in the list, please a serial no from the above list.",
                                                  color: Colors.white,
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          // append the selected pallet code row to the GetShipmentPalletizingList2
                                          GetShipmentPalletizingList2.add(
                                            GetShipmentPalletizingList
                                                .firstWhere(
                                              (element) =>
                                                  element.itemSerialNo ==
                                                  _serialNoController.text
                                                      .trim(),
                                            ),
                                          );
                                          // remove the selected pallet code row from the GetShipmentPalletizingList
                                          GetShipmentPalletizingList
                                              .removeWhere(
                                            (element) =>
                                                element.itemSerialNo ==
                                                _serialNoController.text.trim(),
                                          );
                                          result2 = GetShipmentPalletizingList2
                                              .length
                                              .toString();
                                          result = GetShipmentPalletizingList
                                              .length
                                              .toString();
                                        },
                                      );
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: TextWidget(
                                            text:
                                                "Record Inserted Successfully.",
                                            color: Colors.white,
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      _serialNoController.clear();
                                      Navigator.pop(context);
                                    }).onError(
                                      (error, stackTrace) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: TextWidget(
                                              text: error
                                                  .toString()
                                                  .replaceAll("Exception:", ""),
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: TextWidget(
                                          text: error.toString(),
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
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
                            label: Text('Item Code',
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
                      rows: GetShipmentPalletizingList2.map((e) {
                        return DataRow(onSelectChanged: (value) {}, cells: [
                          DataCell(Text(
                              (GetShipmentPalletizingList2.indexOf(e) + 1)
                                  .toString())),
                          DataCell(Text(e.itemCode ?? "")),
                          DataCell(Text(e.itemDesc ?? "")),
                          DataCell(Text(e.gTIN ?? "")),
                          DataCell(Text(e.remarks ?? "")),
                          DataCell(Text(e.user ?? "")),
                          DataCell(Text(e.classification ?? "")),
                          DataCell(Text(e.mainLocation ?? "")),
                          DataCell(Text(e.binLocation ?? "")),
                          DataCell(Text(e.intCode ?? "")),
                          DataCell(Text(e.itemSerialNo ?? "")),
                          DataCell(Text(e.mapDate ?? "")),
                          DataCell(Text(e.palletCode ?? "")),
                          DataCell(Text(e.reference ?? "")),
                          DataCell(Text(e.sID ?? "")),
                          DataCell(Text(e.cID ?? "")),
                          DataCell(Text(e.pO ?? "")),
                          DataCell(Text(e.trans.toString())),
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
                      child: TextWidget(text: result2.toString()),
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
    );
  }
}
