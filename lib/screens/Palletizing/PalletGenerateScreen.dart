// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:alessa_v2/controllers/BinToBinFromAXAPTA/getmapBarcodeDataByItemCodeController.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../controllers/Palletization/GenerateAndUpdatePalletIdController.dart';
import '../../controllers/Palletization/GetAlltblBinLocationsController.dart';
import '../../controllers/Palletization/ValidateShipmentPalettizingSerialNo.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';
import '../../models/GetAlltblBinLocationsModel.dart';
import '../../utils/Constants.dart';

// ignore: must_be_immutable
class PalletGenerateScreen extends StatefulWidget {
  String ALS_PACKINGSLIPREF;
  num ALS_TRANSFERORDERTYPE;
  String tRANSFERID;
  String iNVENTLOCATIONIDFROM;
  String iNVENTLOCATIONIDTO;
  num QTYTRANSFER;
  String iTEMID;
  String ITEMNAME;
  String CONFIGID;
  String WMSLOCATIONID;
  String shipmentId;

  PalletGenerateScreen({
    required this.ALS_PACKINGSLIPREF,
    required this.ALS_TRANSFERORDERTYPE,
    required this.tRANSFERID,
    required this.iNVENTLOCATIONIDFROM,
    required this.iNVENTLOCATIONIDTO,
    required this.QTYTRANSFER,
    required this.iTEMID,
    required this.ITEMNAME,
    required this.CONFIGID,
    required this.WMSLOCATIONID,
    required this.shipmentId,
  });

  @override
  State<PalletGenerateScreen> createState() => _PalletGenerateScreenState();
}

class _PalletGenerateScreenState extends State<PalletGenerateScreen> {
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _palletTypeController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationReferenceController =
      TextEditingController();

  String? dropdownValue;
  List<String> dropdownList = [];

  String result = "0";
  List<String> serialNoList = [];
  List<bool> isMarked = [];

  List<GetAlltblBinLocationsModel> getAlltblBinLocationsModelList = [];

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      Constants.showLoadingDialog(context);
      GetAlltblBinLocationsController.getShipmentPalletizing().then((value) {
        setState(() {
          dropdownList = value.map((e) {
            return "${e.palletTotalSize.toString()} X ${e.palletType.toString()}";
          }).toList();
          dropdownValue = dropdownList[0];
          _widthController.text = value[0].palletWidth.toString();
          _heightController.text = value[0].palletHeight.toString();
          _lengthController.text = value[0].palletLength.toString();
          _rowController.text = value[0].palletRow.toString();
          getAlltblBinLocationsModelList = value;
        });
        GetMapBarcodeDataByItemCodeController.getData().then((value) {
          for (int i = 0; i < value.length; i++) {
            setState(() {
              dropDownList.add(value[i].bIN ?? "");
              Set<String> set = dropDownList.toSet();
              dropDownList = set.toList();
            });
          }

          setState(() {
            dropDownValue = dropDownList[0];
            filterList = dropDownList;
          });
          Navigator.pop(context);
        }).onError((error, stackTrace) {
          Navigator.pop(context);
          setState(() {
            _locationReferenceController.text = "Location Reference";
          });
        });
      }).onError((error, stackTrace) {
        Navigator.pop(context);
      });
    });
  }

  String? dropDownValue;
  List<String> dropDownList = [];
  List<String> filterList = [];

  @override
  void dispose() {
    super.dispose();
    _serialNoController.dispose();
    _palletTypeController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _lengthController.dispose();
    _rowController.dispose();
    _searchController.dispose();
    _locationReferenceController.dispose();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const TextWidget(
                                text: "Shipment Palletizing",
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                "assets/delete.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                const Text(
                                  "Transfer Id",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.tRANSFERID,
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
                                  "QTY Transfer",
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
                                  "Shipment Id",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.shipmentId,
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
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Select the Type of Pallet",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: dropdownList,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    baseStyle: TextStyle(fontSize: 15),
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Select Pallet Type",
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  enabled: true,
                  onChanged: (value) {
                    setState(() {
                      _palletTypeController.text = value!;
                      dropdownValue = value;

                      // select it from the index no of the dropdown list
                      _widthController.text = getAlltblBinLocationsModelList[
                              dropdownList.indexOf(value)]
                          .palletWidth
                          .toString();
                      _heightController.text = getAlltblBinLocationsModelList[
                              dropdownList.indexOf(value)]
                          .palletHeight
                          .toString();
                      _rowController.text = getAlltblBinLocationsModelList[
                              dropdownList.indexOf(value)]
                          .palletLength
                          .toString();
                      _lengthController.text = getAlltblBinLocationsModelList[
                              dropdownList.indexOf(value)]
                          .palletRow
                          .toString();
                    });
                  },
                  selectedItem: dropdownValue,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWidget(
                    text: "Width",
                    fontSize: 15,
                  ),
                  TextWidget(
                    text: "Height",
                    fontSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldWidget(
                    controller: _widthController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Width",
                  ),
                  TextFormFieldWidget(
                    controller: _heightController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Height",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWidget(
                    text: "Length",
                    fontSize: 15,
                  ),
                  TextWidget(
                    text: "Row",
                    fontSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldWidget(
                    controller: _lengthController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Length",
                  ),
                  TextFormFieldWidget(
                    controller: _rowController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Row",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: " Serial No*",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  hintText: "Enter/Scan Serial No",
                  controller: _serialNoController,
                  focusNode: focusNode,
                  width: MediaQuery.of(context).size.width * 0.9,
                  onEditingComplete: () {
                    onSerial();
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: 10,
                  bottom: 10,
                ),
                child: const Text(
                  "Serial No:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: serialNoList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.orange[200]!,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Colors.orange[200]!),
                              child: Text(
                                serialNoList[index].toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // delete icon for delete this item from list
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                serialNoList.removeAt(index);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
              Center(
                child: ElevatedButtonWidget(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Generate",
                  onPressed: () {
                    if (serialNoList.isEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      return;
                    }
                    if (dropDownValue.toString().isEmpty ||
                        dropDownValue.toString() == "null") {
                      const ScaffoldMessenger(
                        child: SnackBar(
                          content: Text("Please select a location"),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Constants.showLoadingDialog(context);
                    GenerateAndUpdatePalletIdController
                        .generateAndUpdatePalletId(
                      serialNoList,
                      dropDownValue.toString(),
                    ).then(
                      (value) {
                        Navigator.pop(context);

                        showDiologMethod(context, value).show();

                        setState(() {
                          serialNoList.clear();
                          _serialNoController.clear();
                        });
                      },
                    ).onError((error, stackTrace) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              error.toString().replaceAll("Exception:", "")),
                          duration: const Duration(seconds: 2),
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

  AwesomeDialog showDiologMethod(BuildContext context, List<dynamic> value) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: value[1].toString(),
      desc: value[0].toString(),
      btnOkOnPress: () {},
    );
  }

  void onSerial() async {
    if (_serialNoController.text.trim().isEmpty) {
      // hide keyboard
      FocusScope.of(context).requestFocus(FocusNode());
      return;
    }
    Constants.showLoadingDialog(context);
    ValidateShipmentPalettizingSerialNoController.palletizeSerialNo(
      _serialNoController.text,
      widget.shipmentId,
    ).then((value) {
      if (serialNoList.contains(_serialNoController.text.toString())) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Serial No already exists"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (_serialNoController.text.toString().isEmpty) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter Serial No"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      setState(() {
        serialNoList.add(_serialNoController.text.toString());
        _serialNoController.clear();
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);

      setState(() {
        serialNoList.add(_serialNoController.text.toString());
        _serialNoController.clear();
      });
      FocusScope.of(context).requestFocus(focusNode);
    });
  }
}
