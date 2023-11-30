// ignore_for_file: file_names, avoid_print

import 'package:alessa_v2/controllers/BinToBinFromAXAPTA/getmapBarcodeDataByItemCodeController.dart';
import 'package:alessa_v2/controllers/ReturnRMA/GetWmsReturnSalesOrderClCountByItemIdAndReturnItemNumAndSalesIdController.dart';
import 'package:alessa_v2/controllers/ReturnRMA/inset.dart';
import 'package:alessa_v2/widgets/ElevatedButtonWidget.dart';

import '../../controllers/ReturnRMA/ReturnDZones.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../controllers/ReturnRMA/generateBarcodeForRmaController.dart';
import '../../controllers/ReturnRMA/insertIntoWmsReturnSalesOrderClController.dart';
import '../../models/getWmsReturnSalesOrderByReturnItemNum2Model.dart';
import '../../models/getWmsReturnSalesOrderByReturnItemNumModel.dart';
import '../../models/updateWmsJournalMovementClQtyScannedModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

// ignore: must_be_immutable
class ReturnRMAScreen2 extends StatefulWidget {
  String iTEMID;
  String nAME;
  int eXPECTEDRETQTY;
  String sALESID;
  String rETURNITEMNUM;
  String iNVENTSITEID;
  String iNVENTLOCATIONID;
  String cONFIGID;
  String wMSLOCATIONID;
  getWmsReturnSalesOrderByReturnItemNumModel tble;

  ReturnRMAScreen2({
    super.key,
    required this.iTEMID,
    required this.nAME,
    required this.eXPECTEDRETQTY,
    required this.sALESID,
    required this.rETURNITEMNUM,
    required this.iNVENTSITEID,
    required this.iNVENTLOCATIONID,
    required this.cONFIGID,
    required this.wMSLOCATIONID,
    required this.tble,
  });

  @override
  State<ReturnRMAScreen2> createState() => _ReturnRMAScreen2State();
}

class _ReturnRMAScreen2State extends State<ReturnRMAScreen2> {
  final TextEditingController _returnItemNumController =
      TextEditingController();
  final TextEditingController _palletTypeController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _modelNoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _srchController = TextEditingController();
  String? dDownValue;
  List<String> dDownList = [];
  List<String> fltrList = [];

  String result = "0";
  List<String> serialNoList = [];
  List<bool> isMarked = [];

  var recQty;

  List<getWmsReturnSalesOrderByReturnItemNum2Model> table = [];

  updateWmsJournalMovementClQtyScannedModel
      updateWmsJournalMovementClQtyScannedList =
      updateWmsJournalMovementClQtyScannedModel();

  // focus node for text fields
  final FocusNode _serialNoFocusNode = FocusNode();

  String _site = "By Serial";
  String _barCode = 'No Barcode';

  String? dropDownValue;
  List<String> dropDownList = [];
  List<String> filterList = [];

  @override
  void initState() {
    super.initState();
    _returnItemNumController.text = widget.rETURNITEMNUM;

    Future.delayed(
      Duration.zero,
      () async {
        try {
          Constants.showLoadingDialog(context);
          var value = await ReturnDZones.getData();

          for (int i = 0; i < value.length; i++) {
            setState(() {
              dropDownList.add(value[i].rZONE ?? "");
              Set<String> set = dropDownList.toSet();
              dropDownList = set.toList();
            });
          }
          setState(() {
            dropDownValue = dropDownList[0];
            filterList = dropDownList;
          });

          GetMapBarcodeDataByItemCodeController.getData().then((value) {
            for (int i = 0; i < value.length; i++) {
              setState(() {
                dDownList.add(value[i].bIN ?? "");
                Set<String> set = dDownList.toSet();
                dDownList = set.toList();
              });
            }
            setState(() {
              dDownValue = dDownList[0];
              fltrList = dDownList;
            });
            GetWmsReturnSalesOrderClCountByItemIdAndReturnItemNumAndSalesIdController
                .getData(
              widget.iTEMID,
              widget.rETURNITEMNUM,
              widget.sALESID,
            ).then((returnItemsCount) {
              setState(() {
                recQty = returnItemsCount;
              });
              Navigator.pop(context);
            }).onError((error, stackTrace) {
              setState(() {
                recQty = 0;
              });
              Navigator.pop(context);
            });
          }).onError((error, stackTrace) {
            setState(() {
              dDownValue = "";
              fltrList = [];
            });
          });

          // GetPickListTableDataController.getData(
          //   widget.iTEMID,
          //   dropDownValue.toString(),
          // ).then((value) {
          //   setState(() {
          //     GetShipmentPalletizingList = value;
          //     result = value.length.toString();
          //   });
          //   Navigator.pop(context);
          // }).onError((error, stackTrace) {
          //   setState(() {
          //     GetShipmentPalletizingList = [];
          //     result = "0";
          //   });
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text(error.toString().replaceAll("Exception:", "")),
          //     backgroundColor: Colors.red,
          //   ));
          // });
        } catch (e) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString().replaceAll("Exception:", "")),
            backgroundColor: Colors.red,
          ));
        }
      },
    );
  }

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
                          text: "Return Item Number:",
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TextFormFieldWidget(
                          controller: _returnItemNumController,
                          readOnly: true,
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: "From:",
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.iNVENTSITEID,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Item ID:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.iTEMID,
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
                                "Sales ID: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.sALESID.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
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
                                  "Ret QTY: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.eXPECTEDRETQTY.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Received Qty: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  recQty.toString() == "null"
                                      ? "0"
                                      : recQty.toString(),
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
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: TextWidget(
                  text: "Receiving Zones",
                  color: Colors.blue[900]!,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.73,
                    margin: const EdgeInsets.only(left: 20),
                    child: DropdownSearch<String>(
                      filterFn: (item, filter) {
                        return item
                            .toLowerCase()
                            .contains(filter.toLowerCase());
                      },
                      enabled: true,
                      dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                      items: filterList,
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value!;
                        });
                      },
                      selectedItem: dropDownValue,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        // show dialog box for search
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: TextWidget(
                                text: "Search",
                                color: Colors.blue[900]!,
                                fontSize: 15,
                              ),
                              content: TextFormFieldWidget(
                                controller: _searchController,
                                readOnly: false,
                                hintText: "Enter/Scan Location",
                                width: MediaQuery.of(context).size.width * 0.9,
                                onEditingComplete: () {
                                  setState(() {
                                    dropDownList = dropDownList
                                        .where((element) => element
                                            .toLowerCase()
                                            .contains(_searchController.text
                                                .toLowerCase()))
                                        .toList();
                                    dropDownValue = dropDownList[0];
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: TextWidget(
                                    text: "Cancel",
                                    color: Colors.blue[900]!,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // filter list based on search
                                    setState(() {
                                      filterList = dropDownList
                                          .where((element) => element
                                              .toLowerCase()
                                              .contains(_searchController.text
                                                  .toLowerCase()))
                                          .toList();
                                      dropDownValue = filterList[0];
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: TextWidget(
                                    text: "Search",
                                    color: Colors.blue[900]!,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
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
                        title: const Text('Barcode'),
                        leading: Radio(
                          value: "Barcode",
                          groupValue: _barCode,
                          onChanged: (String? value) {
                            setState(() {
                              _barCode = value!;
                              print(_barCode);
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: const Text('No Barcode'),
                        leading: Radio(
                          value: "No Barcode",
                          groupValue: _barCode,
                          onChanged: (String? value) {
                            setState(
                              () {
                                _barCode = value!;
                                print(_barCode);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _barCode == "No Barcode" ? true : false,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: TextWidget(
                    text: "Model No#",
                    color: Colors.blue[900]!,
                    fontSize: 15,
                  ),
                ),
              ),
              Visibility(
                visible: _barCode == "No Barcode" ? true : false,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    controller: _modelNoController,
                    readOnly: false,
                    hintText: "Enter/Scan Model No#",
                    width: MediaQuery.of(context).size.width * 0.9,
                    onEditingComplete: () {
                      // hide keyboard
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _barCode == "No Barcode" ? true : false,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: ElevatedButtonWidget(
                    title: "Generate Barcode",
                    color: Colors.orange[100],
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    onPressed: () {
                      onGenerateBarcode();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _barCode == "Barcode" ? true : false,
                child: Container(
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
              ),
              Visibility(
                visible: _barCode == "Barcode" ? true : false,
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
                      visible: _barCode == "Barcode" ? true : false,
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
                      visible: _barCode == "Barcode" ? true : false,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: TextFormFieldWidget(
                          focusNode: _serialNoFocusNode,
                          controller: _serialNoController,
                          readOnly: false,
                          hintText: "Enter/Scan Serial No",
                          width: MediaQuery.of(context).size.width * 0.9,
                          onEditingComplete: () {
                            onSerialNo();
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
                        DataColumn(
                            label: Text(
                          'ITEM SERIAL NO.',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ],
                      rows: table.map((e) {
                        return DataRow(onSelectChanged: (value) {}, cells: [
                          DataCell(Text((table.indexOf(e) + 1).toString())),
                          DataCell(Text(e.iTEMID ?? "")),
                          DataCell(Text(e.nAME ?? "")),
                          DataCell(Text(e.eXPECTEDRETQTY.toString())),
                          DataCell(Text(e.sALESID ?? "")),
                          DataCell(Text(e.rETURNITEMNUM ?? "")),
                          DataCell(Text(e.iNVENTSITEID ?? "")),
                          DataCell(Text(e.iNVENTLOCATIONID ?? "")),
                          DataCell(Text(e.cONFIGID ?? "")),
                          DataCell(Text(e.wMSLOCATIONID ?? "")),
                          DataCell(Text(e.itemSerialNo ?? "")),
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
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                child: const TextWidget(
                  text: "Bin Location",
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.73,
                    margin: const EdgeInsets.only(left: 20),
                    child: DropdownSearch<String>(
                      filterFn: (item, filter) {
                        return item
                            .toLowerCase()
                            .contains(filter.toLowerCase());
                      },
                      enabled: true,
                      dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                      items: fltrList,
                      onChanged: (value) {
                        setState(() {
                          dDownValue = value!;
                        });
                      },
                      selectedItem: dDownValue,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        // show dialog box for search
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: TextWidget(
                                text: "Search",
                                color: Colors.blue[900]!,
                                fontSize: 15,
                              ),
                              content: TextFormFieldWidget(
                                controller: _srchController,
                                readOnly: false,
                                hintText: "Enter/Scan Location",
                                width: MediaQuery.of(context).size.width * 0.9,
                                onEditingComplete: () {
                                  setState(() {
                                    dDownList = dDownList
                                        .where((element) => element
                                            .toLowerCase()
                                            .contains(_srchController.text
                                                .toLowerCase()))
                                        .toList();
                                    dDownValue = dDownList[0];
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: TextWidget(
                                    text: "Cancel",
                                    color: Colors.blue[900]!,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // filter list based on search
                                    setState(() {
                                      fltrList = dDownList
                                          .where((element) => element
                                              .toLowerCase()
                                              .contains(_srchController.text
                                                  .toLowerCase()))
                                          .toList();
                                      dDownValue = fltrList[0];
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: TextWidget(
                                    text: "Search",
                                    color: Colors.blue[900]!,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: ElevatedButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  title: "Save",
                  textColor: Colors.white,
                  color: Colors.orange,
                  onPressed: () {
                    if (dDownValue == null || dDownValue == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please Select Bin Location"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (table.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Please Select At least One Item from table"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    FocusScope.of(context).requestFocus();
                    Constants.showLoadingDialog(context);
                    insertManyIntoMappedBarcodeController2
                        .getData(
                      dDownValue.toString(),
                      table,
                    )
                        .then((value) {
                      insertIntoWmsReturnSalesOrderClController
                          .getData(table)
                          .then((value) {
                        setState(() {
                          table.removeWhere(
                              (element) => table.contains(element));
                          table = [];
                          isMarked = List<bool>.generate(
                              table.length, (index) => false);
                          result = table.length.toString();
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Data Inserted Successfully"),
                          backgroundColor: Colors.green,
                        ));
                      }).onError(
                        (error, stackTrace) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: TextWidget(
                                text: error
                                    .toString()
                                    .replaceAll("Exception:", ""),
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                      // DeleteMultipleRecordsFromWmsReturnSalesOrderClController
                      //     .getData(
                      //   table.map((e) => e.itemSerialNo.toString()).toList(),
                      // ).then((value) {
                      //   // delete the selected rows from table
                      //   setState(() {
                      //     table.removeWhere(
                      //         (element) => table.contains(element));
                      //     table = [];
                      //     isMarked = List<bool>.generate(
                      //         table.length, (index) => false);
                      //     result = table.length.toString();
                      //   });
                      //   Navigator.of(context).pop();
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(const SnackBar(
                      //     content: Text("Data Inserted Successfully"),
                      //     backgroundColor: Colors.green,
                      //   ));
                      // }).onError((error, stackTrace) {
                      //   Navigator.of(context).pop();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //           error.toString().replaceAll("Exception:", "")),
                      //       backgroundColor: Colors.red,
                      //     ),
                      //   );
                      // });
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
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void onSerialNo() async {
    var expectedQty = widget.eXPECTEDRETQTY * -1;

    if (recQty >= expectedQty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Received Qty has been completed.\nYou can't insert more records.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (dropDownValue == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Select a Location.",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_serialNoController.text.trim() == "") {
      FocusScope.of(context).unfocus();
      return;
    }

    // check if the serial no. is already exists in the table

    if (table
        .where((element) =>
            element.itemSerialNo.toString().trim() ==
            _serialNoController.text.trim())
        .toList()
        .isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "This Serial No. is already exists in the table.",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(
      () {
        // append the selected pallet code row to the GetShipmentPalletizingList2
        table.add(
          getWmsReturnSalesOrderByReturnItemNum2Model(
            iTEMID: widget.iTEMID,
            nAME: widget.nAME,
            eXPECTEDRETQTY: widget.eXPECTEDRETQTY,
            sALESID: widget.sALESID,
            rETURNITEMNUM: widget.rETURNITEMNUM,
            iNVENTSITEID: widget.iNVENTSITEID,
            iNVENTLOCATIONID: widget.iNVENTLOCATIONID,
            cONFIGID: widget.cONFIGID,
            wMSLOCATIONID: widget.wMSLOCATIONID,
            itemSerialNo: _serialNoController.text.trim(),
          ),
        );
        result = table.length.toString();
        _serialNoController.clear();

        recQty = recQty + 1;
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Record inserted Successfully.",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  /////////////////////////////// 2nd Method ///////////////////////////////

  void onGenerateBarcode() async {
    var expectedQty = widget.eXPECTEDRETQTY * -1;

    if (recQty >= expectedQty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Received Qty has been completed.\nYou can't insert more records.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_modelNoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Enter a Unique Model No.",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (dropDownValue == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please Select a Location.",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    FocusScope.of(context).requestFocus();
    Constants.showLoadingDialog(context);
    GenerateBarcodeForRmaController.getData(
      widget.rETURNITEMNUM,
      widget.iTEMID,
      _modelNoController.text.trim(),
    ).then((value) {
      setState(
        () {
          // append the selected pallet code row to the GetShipmentPalletizingList2
          table.add(
            getWmsReturnSalesOrderByReturnItemNum2Model(
              iTEMID: widget.iTEMID,
              nAME: widget.nAME,
              eXPECTEDRETQTY: widget.eXPECTEDRETQTY,
              sALESID: widget.sALESID,
              rETURNITEMNUM: widget.rETURNITEMNUM,
              iNVENTSITEID: widget.iNVENTSITEID,
              iNVENTLOCATIONID: widget.iNVENTLOCATIONID,
              cONFIGID: widget.cONFIGID,
              wMSLOCATIONID: widget.wMSLOCATIONID,
              itemSerialNo: value,
            ),
          );
          result = table.length.toString();

          _modelNoController.clear();

          recQty = recQty + 1;
        },
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Record inserted Successfully.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceAll("Exception:", ""),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  // void createPdf(String value) async {
  //   final doc = pw.Document();

  //   final image = await imageFromAssetBundle("assets/alessa.png");

  //   doc.addPage(
  //     pw.Page(
  //         pageFormat: const PdfPageFormat(300, 250),
  //         orientation: pw.PageOrientation.landscape,
  //         clip: true,
  //         build: (pw.Context context) {
  //           return buildPdf(value, image);
  //         }),
  //   );

  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => doc.save());
  // }

  // buildPdf(String uniqId, image) {
  //   return pw.Center(
  //     child: pw.Column(
  //       mainAxisAlignment: pw.MainAxisAlignment.center,
  //       crossAxisAlignment: pw.CrossAxisAlignment.center,
  //       children: [
  //         pw.SizedBox(
  //           height: 50,
  //           width: double.infinity,
  //           child: pw.Image(
  //             image,
  //             width: double.infinity,
  //           ),
  //         ),
  //         pw.Container(
  //           margin: const pw.EdgeInsets.symmetric(horizontal: 20),
  //           alignment: pw.Alignment.topCenter,
  //           child: pw.BarcodeWidget(
  //             barcode: Barcode.code39(),
  //             drawText: true,
  //             width: 300,
  //             height: 100,
  //             data: uniqId,
  //             textStyle: const pw.TextStyle(fontSize: 10),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
