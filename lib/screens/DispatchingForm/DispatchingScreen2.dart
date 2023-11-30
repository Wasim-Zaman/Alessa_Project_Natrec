// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:alessa_v2/controllers/Dispatching/GetAllWmsTruckMasterController.dart';
import 'package:alessa_v2/controllers/Dispatching/GetPackingSlipTableClByItemIdAndPackingSlipIdController.dart';
import 'package:alessa_v2/controllers/Dispatching/InsertDispatchingScreen.dart';
import 'package:alessa_v2/controllers/Dispatching/InsertTblDispatchingDetailsDataCLController.dart';
import 'package:alessa_v2/models/GetPackingSlipTableClByItemIdAndPackingSlipIdModel.dart';

import 'package:flutter/services.dart';

import '../../utils/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

// ignore: must_be_immutable
class DispatchingScreen2 extends StatefulWidget {
  String salesId;
  String itemId;
  String name;
  String inventLocationId;
  String config;
  num ordered;
  String packingSlipId;
  String vehicleShipPlateNumber;

  DispatchingScreen2({
    required this.salesId,
    required this.itemId,
    required this.name,
    required this.inventLocationId,
    required this.config,
    required this.ordered,
    required this.packingSlipId,
    required this.vehicleShipPlateNumber,
  });

  @override
  State<DispatchingScreen2> createState() => _DispatchingScreen2State();
}

class _DispatchingScreen2State extends State<DispatchingScreen2> {
  final TextEditingController _transferIdController = TextEditingController();
  final TextEditingController _palletTypeController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _vehicleBarcodeSerialController =
      TextEditingController();

  String total = "0";
  List<String> serialNoList = [];
  List<bool> isMarked = [];

  List<GetPackingSlipTableClByItemIdAndPackingSlipIdModel> table1 = [];
  List<GetPackingSlipTableClByItemIdAndPackingSlipIdModel> table2 = [];

  // String dropdownValue = "";
  // List<String> dropdownList = [];

  @override
  void initState() {
    _transferIdController.text = widget.packingSlipId;

    super.initState();
    Future.delayed(Duration.zero, () {
      GetAllWmsTruckMasterController.getShipmentReceived(widget.packingSlipId)
          .then((value) {
        setState(() {
          _vehicleBarcodeSerialController.text = value == "null" ? "" : value;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _vehicleBarcodeSerialController.clear();
        });
      });
    });

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Constants.showLoadingDialog(context);
      GetPackingSlipTableClByItemIdAndPackingSlipIdController
              .getShipmentReceived(widget.salesId)
          .then((value) {
        setState(() {
          table1 = value;
        });
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setState(() {
          table1 = [];
        });
        Navigator.pop(context);
      });
    });
  }

  String _site = "By Serial";
  final FocusNode _serialNoFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
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
                          text: "Packing Route ID",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TextFormFieldWidget(
                          controller: _transferIdController,
                          readOnly: true,
                          hintText: "Packing Route ID",
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Item Name:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
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
                                  "Sales Id:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.salesId.toString(),
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
                                  "Packing Slip Id:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.packingSlipId.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
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
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: PaginatedDataTable(
                  rowsPerPage: 5,
                  columns: const [
                    DataColumn(
                        label: Text(
                      'DISPATCH',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'SALES ID',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'ITEM ID',
                      style: TextStyle(color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'NAME',
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
                      'ORDERED',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        label: Text(
                      'PACKING SLIP ID',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        label: Text(
                      'VEHICLE SHIP PLATE NUMBER',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        label: Text(
                      'DATE TIME CREATED',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        label: Text(
                      'ASSIGNED USER ID',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                    DataColumn(
                        label: Text(
                      'ITEM SERIAL NUMBER',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                  ],
                  source: StudentDataSource(table1, context),
                  showCheckboxColumn: false,
                  showFirstLastButtons: true,
                  arrowHeadColor: Colors.orange,
                ),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 10),
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
                          focusNode: _serialNoFocusNode,
                          readOnly: false,
                          hintText: "Enter/Scan Serial No",
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {
                            onSerial();
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
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'SALES ID',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'ITEM ID',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'NAME',
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
                          'ORDERED',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'PACKING SLIP ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'VEHICLE SHIP PLATE NUMBER',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'DATE TIME CREATED',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'ASSIGNED USER ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                          label: Text(
                            'ITEM SERIAL NUMBER',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                      rows: table2.map((e) {
                        return DataRow(onSelectChanged: (value) {}, cells: [
                          DataCell(GestureDetector(
                            onTap: () {
                              setState(() {
                                table1.add(e);
                                table2.remove(e);
                                total = (int.parse(total) - 1).toString();
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                          )),
                          DataCell(Text(e.sALESID ?? "")),
                          DataCell(Text(e.iTEMID ?? "")),
                          DataCell(Text(e.nAME ?? "")),
                          DataCell(Text(e.iNVENTLOCATIONID ?? "")),
                          DataCell(Text(e.cONFIGID ?? "")),
                          DataCell(Text(e.oRDERED.toString())),
                          DataCell(Text(e.pACKINGSLIPID ?? "")),
                          DataCell(Text(e.vEHICLESHIPPLATENUMBER ?? "")),
                          DataCell(Text(e.dATETIMECREATED ?? "")),
                          DataCell(Text(e.aSSIGNEDUSERID ?? "")),
                          DataCell(Text(e.iTEMSERIALNO ?? "")),
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
                  const TextWidget(text: "TOTAL", fontSize: 15),
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
                      child: TextWidget(text: total.toString()),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                width: MediaQuery.of(context).size.width * 1,
                child: const TextWidget(
                  text: "Vehicle Barcode Serial No.\n(Vehicle Plate No.)",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _vehicleBarcodeSerialController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter/Scan Serial No.",
                  readOnly: _vehicleBarcodeSerialController.text.isEmpty
                      ? false
                      : true,
                ),
              ),

              // Container(
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     color: Colors.white,
              //   ),
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   margin: const EdgeInsets.only(left: 20),
              //   child: DropdownSearch<String>(
              //     filterFn: (item, filter) {
              //       return item.toLowerCase().contains(filter.toLowerCase());
              //     },
              //     enabled: true,
              //     dropdownButtonProps: const DropdownButtonProps(
              //       icon: Icon(
              //         Icons.arrow_drop_down,
              //         color: Colors.black,
              //       ),
              //     ),
              //     items: dropdownList,
              //     onChanged: (value) {
              //       setState(() {
              //         dropdownValue = value!;
              //       });
              //     },
              //     selectedItem: dropdownValue,
              //   ),
              // ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButtonWidget(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Save",
                  onPressed: () {
                    if (table2.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please add item first"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (_vehicleBarcodeSerialController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please Enter Vehicle Barcode Serial No."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    var data = table2.map((e) {
                      return {
                        "SALESID": e.sALESID,
                        "ITEMID": e.iTEMID,
                        "NAME": e.nAME,
                        "INVENTLOCATIONID": e.iNVENTLOCATIONID,
                        "CONFIGID": e.cONFIGID,
                        "ORDERED": e.oRDERED,
                        "PACKINGSLIPID": e.pACKINGSLIPID,
                        "VEHICLESHIPPLATENUMBER": e.vEHICLESHIPPLATENUMBER,
                        "ITEMSERIALNO": e.iTEMSERIALNO
                      };
                    }).toList();
                    // unfocus from keyboard
                    FocusScope.of(context).unfocus();
                    Constants.showLoadingDialog(context);
                    InsertDispatchingController.insertData(
                      data,
                      _vehicleBarcodeSerialController.text.trim(),
                    ).then((value) {
                      InsertTblDispatchingDetailsDataCLController.insertData(
                        data,
                        _vehicleBarcodeSerialController.text.trim(),
                      ).then((value) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data inserted successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          table2.clear();
                          total = "0";
                        });
                      }).onError((error, stackTrace) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                error.toString().replaceAll("Exception:", "")),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    }).onError((error, stackTrace) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              error.toString().replaceAll("Exception:", "")),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  },
                  textColor: Colors.white,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void onSerial() async {
    if (_serialNoController.text.isEmpty) {
      FocusScope.of(context).unfocus();
      return;
    }

    // if dispach value is yes for the selected serial no then show msg
    // ignore: unrelated_type_equality_checks

    if (table1.where((element) {
      if (element.iTEMSERIALNO?.trim() == _serialNoController.text.trim()) {
        return element.dISPATCH?.toLowerCase() == "yes";
      } else {
        return false;
      }
    }).isNotEmpty) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text:
                "This item with ${_serialNoController.text.trim()} is already dispatched.",
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _serialNoController.clear();
      });
      return;
    }

    if (table1
        .where((element) =>
            element.iTEMSERIALNO.toString().trim() ==
            _serialNoController.text.trim())
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text:
                "This Serial No. is not found in the above Table, Please insert a Valid Serial No.",
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      table2.add(
        table1.firstWhere(
          (element) =>
              element.iTEMSERIALNO.toString().trim() ==
              _serialNoController.text.trim(),
        ),
      );
      table1.remove(
        table1.firstWhere(
          (element) =>
              element.iTEMSERIALNO.toString().trim() ==
              _serialNoController.text.trim(),
        ),
      );
      total = (int.parse(total) + 1).toString();
      _serialNoController.clear();

      FocusScope.of(context).requestFocus(_serialNoFocusNode);
    });
  }
}

class StudentDataSource extends DataTableSource {
  List<GetPackingSlipTableClByItemIdAndPackingSlipIdModel> students;
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
        DataCell(Text(student.dISPATCH ?? "")),
        DataCell(Text(student.sALESID ?? "")),
        DataCell(Text(student.iTEMID ?? "")),
        DataCell(Text(student.nAME ?? "")),
        DataCell(Text(student.iNVENTLOCATIONID ?? "")),
        DataCell(Text(student.cONFIGID ?? "")),
        DataCell(Text(student.oRDERED.toString())),
        DataCell(Text(student.pACKINGSLIPID ?? "")),
        DataCell(Text(student.vEHICLESHIPPLATENUMBER ?? "")),
        DataCell(Text(student.dATETIMECREATED ?? "")),
        DataCell(Text(student.aSSIGNEDUSERID ?? "")),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(student.iTEMSERIALNO ?? ""),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                // copy the serial no
                Clipboard.setData(
                  ClipboardData(text: student.iTEMSERIALNO ?? ""),
                );
              },
              child: const Icon(
                Icons.copy,
                color: Colors.blue,
                size: 20,
              ),
            ),
          ],
        )),
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
