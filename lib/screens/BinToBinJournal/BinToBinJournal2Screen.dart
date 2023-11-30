import '../../controllers/BinToBinJournal/GetTableByPalletController.dart';
import '../../controllers/BinToBinJournal/GetTableBySerialController.dart';
import '../../controllers/BinToBinJournal/updateJournalController.dart';
import '../../models/BinToBinJournalTableModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

// ignore: must_be_immutable
class BinToBinJournal2Screen extends StatefulWidget {
  String TRANSFERID;
  int TRANSFERSTATUS;
  String INVENTLOCATIONIDFROM;
  String INVENTLOCATIONIDTO;
  String ITEMID;
  int QTYTRANSFER;
  int QTYRECEIVED;
  String CREATEDDATETIME;
  String JournalID;
  String BinLocation;
  String DateTimeTransaction;
  String CONFIG;
  String USERID;

  BinToBinJournal2Screen({
    super.key,
    required this.TRANSFERID,
    required this.TRANSFERSTATUS,
    required this.INVENTLOCATIONIDFROM,
    required this.INVENTLOCATIONIDTO,
    required this.ITEMID,
    required this.QTYTRANSFER,
    required this.QTYRECEIVED,
    required this.CREATEDDATETIME,
    required this.JournalID,
    required this.BinLocation,
    required this.DateTimeTransaction,
    required this.CONFIG,
    required this.USERID,
  });

  @override
  State<BinToBinJournal2Screen> createState() => _BinToBinJournal2ScreenState();
}

class _BinToBinJournal2ScreenState extends State<BinToBinJournal2Screen> {
  final TextEditingController _transferIdController = TextEditingController();
  final TextEditingController _locationReferenceController =
      TextEditingController();
  final TextEditingController _scanLocationController = TextEditingController();
  final TextEditingController _palletTypeController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();

  String result = "0";
  List<String> serialNoList = [];
  List<bool> isMarked = [];

  List<BinToBinJournalTableModel> GetShipmentPalletizingList = [];

  @override
  void initState() {
    super.initState();
    _transferIdController.text = widget.TRANSFERID;
    _locationReferenceController.text = widget.BinLocation;
  }

  String _site = "";

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
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: TextFormFieldWidget(
                              controller: _locationReferenceController,
                              readOnly: true,
                              hintText: "Location Reference",
                              width: MediaQuery.of(context).size.width * 0.68,
                              onEditingComplete: () {},
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
                            widget.ITEMID,
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
                              children: [
                                const Text(
                                  "Qty Received",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.QTYRECEIVED.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Qty Transfer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.QTYTRANSFER.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "transfer Status",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.TRANSFERSTATUS.toString(),
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
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                    setState(() {
                                      _site = value!;
                                      print(_site);
                                    });
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
                    ],
                  ),
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
                  ? Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormFieldWidget(
                        controller: _palletTypeController,
                        readOnly: false,
                        hintText: "Enter/Scan Pallet No",
                        width: MediaQuery.of(context).size.width * 0.9,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Constants.showLoadingDialog(context);
                          GetTableByPalletController.getAllTable(
                                  _palletTypeController.text.trim(),
                                  widget.BinLocation)
                              .then((value) {
                            Navigator.of(context).pop();
                            setState(() {
                              GetShipmentPalletizingList.clear();
                              GetShipmentPalletizingList = value;
                            });
                          }).onError((error, stackTrace) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error
                                    .toString()
                                    .replaceAll("Exception:", "")),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        },
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormFieldWidget(
                        controller: _serialNoController,
                        readOnly: true,
                        hintText: "Enter/Scan Serial No",
                        width: MediaQuery.of(context).size.width * 0.9,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Constants.showLoadingDialog(context);
                          GetTableBySerialController.getAllTable(
                            _serialNoController.text.trim(),
                            widget.BinLocation,
                          ).then((value) {
                            Navigator.of(context).pop();
                            setState(() {
                              GetShipmentPalletizingList.clear();
                              GetShipmentPalletizingList = value;
                            });
                          }).onError((error, stackTrace) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error
                                    .toString()
                                    .replaceAll("Exception:", "")),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        },
                        onFieldSubmitted: (p0) {
                          Constants.showLoadingDialog(context);
                          GetTableBySerialController.getAllTable(
                            _serialNoController.text.trim(),
                            widget.BinLocation,
                          ).then((value) {
                            Navigator.of(context).pop();
                            setState(() {
                              GetShipmentPalletizingList.clear();
                              GetShipmentPalletizingList = value;
                            });
                          }).onError((error, stackTrace) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error
                                    .toString()
                                    .replaceAll("Exception:", "")),
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
                      rows: GetShipmentPalletizingList.map((e) {
                        return DataRow(onSelectChanged: (value) {}, cells: [
                          DataCell(Text(
                              (GetShipmentPalletizingList.indexOf(e) + 1)
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
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: TextWidget(
                  text: "Scan Location To:",
                  color: Colors.blue[900]!,
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _scanLocationController,
                  readOnly: false,
                  hintText: "Enter/Scan Location",
                  width: MediaQuery.of(context).size.width * 0.9,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButtonWidget(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Save",
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Constants.showLoadingDialog(context);
                    UpdateJournalController.updateJournal(
                      widget.BinLocation,
                      _scanLocationController.text.trim(),
                      _site,
                      _site == "By Pallet"
                          ? _palletTypeController.text.trim()
                          : _serialNoController.text.trim(),
                    ).then((value) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Successfully Updated"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      setState(() {
                        GetShipmentPalletizingList.clear();
                        _scanLocationController.clear();
                        _palletTypeController.clear();
                        _serialNoController.clear();
                      });
                    }).onError((error, stackTrace) {
                      Navigator.pop(context);
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
}
