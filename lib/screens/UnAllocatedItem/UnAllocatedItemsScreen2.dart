// ignore_for_file: must_be_immutable, use_build_context_synchronously

import '../../controllers/ReturnRMA/InsertManyIntoMappedBarcodeController.dart';
import '../../controllers/UnAllocatedItem/DeleteItemsReAllocationPickedByItemSerialNoController.dart';
import '../../controllers/UnAllocatedItem/GetAllTblLocationsCLController.dart';
import '../../controllers/UnAllocatedItem/GetItemInfoByPalletCodeController.dart';
import '../../models/GetAllTblLocationsCLModel.dart';
import '../../utils/Constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

class UnAllocatedItemsScreen2 extends StatefulWidget {
  String itemCode;
  String itemDesc;
  String gtin;
  String remarks;
  String user;
  String classification;
  String mainLocation;
  String binLocation;
  String intCode;
  String itemSerialNo;
  String mapDate;
  String palletCode;
  String reference;
  String sID;
  String cID;
  String po;
  int trans;

  UnAllocatedItemsScreen2({
    required this.itemCode,
    required this.itemDesc,
    required this.gtin,
    required this.remarks,
    required this.user,
    required this.classification,
    required this.mainLocation,
    required this.binLocation,
    required this.intCode,
    required this.itemSerialNo,
    required this.mapDate,
    required this.palletCode,
    required this.reference,
    required this.cID,
    required this.po,
    required this.sID,
    required this.trans,
  });

  @override
  State<UnAllocatedItemsScreen2> createState() =>
      _UnAllocatedItemsScreen2State();
}

class _UnAllocatedItemsScreen2State extends State<UnAllocatedItemsScreen2> {
  final TextEditingController _scanPalletController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<String> serialNoList = [];

  String _site = "By Bin";

  String? dropDownValue;

  List<String> dropDownList = [];
  List<String> filterList = [];

  // make focus node
  FocusNode focusNode = FocusNode();

  List<GetAllTblLocationsCLModel> table = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        Constants.showLoadingDialog(context);
        var value = await GetAllTblLocationsCLController.getData();
        setState(() {
          table = value;
          for (var i = 0; i < table.length; i++) {
            dropDownList.add(table[i].bIN.toString());
          }
          // convert the list to set to remove duplicate values
          Set<String> set = dropDownList.toSet();
          // convert the set to the list
          dropDownList = set.toList();
          filterList = dropDownList;
          dropDownValue = dropDownList[0];
        });
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: TextWidget(
              text: e.toString(),
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
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
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Item Desc:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.itemDesc,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Serial No:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.itemSerialNo,
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
                                "GTIN:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.gtin,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Pallet Id:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.palletCode,
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
                                "BIN:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.binLocation,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                                title: const Text('By Bin'),
                                leading: Radio(
                                  value: "By Bin",
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
              _site == "By Pallet"
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: TextWidget(
                        text:
                            _site == 'By Pallet' ? "Scan Pallet#" : "Scan Bin#",
                        color: Colors.blue[900]!,
                        fontSize: 15,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: TextWidget(
                        text: "Select Bin Location#",
                        color: Colors.blue[900]!,
                        fontSize: 15,
                      ),
                    ),
              _site == "By Pallet"
                  ? Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormFieldWidget(
                            controller: _scanPalletController,
                            readOnly: false,
                            focusNode: focusNode,
                            hintText: "Enter/Scan Pallet No",
                            width: MediaQuery.of(context).size.width * 0.73,
                            onEditingComplete: () {
                              onPalletSearch();
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
                              onPalletSearch();
                            },
                            child: Image.asset('assets/finder.png',
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 60,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    )
                  : Row(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      onEditingComplete: () {
                                        setState(() {});
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
                                          // assign the value of search controller
                                          // to the filter list to filter the list

                                          setState(() {
                                            filterList = dropDownList
                                                .where((element) => element
                                                    .toLowerCase()
                                                    .contains(_searchController
                                                        .text
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
              const SizedBox(height: 10),
              Center(
                child: ElevatedButtonWidget(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Save",
                  onPressed: () {
                    if (_site == "By Pallet") {
                      onSaveByPallet();
                    }
                    if (_site == "By Bin") {
                      onSaveByBin();
                    }
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

  void onSaveByBin() async {
    if (dropDownValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text: "Select Bin Location",
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      Constants.showLoadingDialog(context);
      await InsertManyIntoMappedBarcodeController.getData(
        widget.itemCode,
        widget.itemDesc,
        _site == "By Pallet"
            ? _scanPalletController.text.trim()
            : dropDownValue.toString(),
        widget.binLocation,
        "",
        "",
        "",
        "",
        "",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text: "Inserted Successfully",
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      );
      await DeleteItemsReAllocationPickedByItemSerialNoController.getData(
          widget.itemSerialNo);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: e.toString().replaceAll("Exception:", ""),
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onSaveByPallet() async {
    if (_scanPalletController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text: "Please Enter Pallet No.",
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      Constants.showLoadingDialog(context);
      await InsertManyIntoMappedBarcodeController.getData(
        widget.itemCode,
        widget.itemDesc,
        _site == "By Pallet"
            ? _scanPalletController.text.trim()
            : dropDownValue.toString(),
        widget.binLocation,
        "",
        "",
        "",
        "",
        "",
      );
      _scanPalletController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text: "Inserted Successfully",
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      );
      await DeleteItemsReAllocationPickedByItemSerialNoController.getData(
          widget.itemSerialNo);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: e.toString().replaceAll("Exception:", ""),
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onPalletSearch() async {
    try {
      Constants.showLoadingDialog(context);
      await GetItemInfoByPalletCodeController.getData(
          _scanPalletController.text);
      Navigator.pop(context);
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            text: "Pallet Not Found",
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
