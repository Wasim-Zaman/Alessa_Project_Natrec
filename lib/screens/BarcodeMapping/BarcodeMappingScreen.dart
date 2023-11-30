// ignore_for_file: sized_box_for_whitespace, avoid_print, unrelated_type_equality_checks

import 'package:alessa_v2/controllers/BarcodeMapping/GetItemInfoByItemSerialNoController.dart';
import 'package:alessa_v2/models/GetItemInfoByItemSerialNoModel.dart';
import 'package:alessa_v2/models/getInventTableWMSDataByItemIdOrItemNameModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/BarcodeMapping/GetTblStockMasterByItemIdController.dart';
import '../../controllers/BarcodeMapping/getAllTblMappedBarcodesController.dart';
import '../../controllers/BarcodeMapping/insertIntoMappedBarcodeOrUpdateBySerialNoController.dart';
import '../../controllers/WareHouseOperationController/UpdateStockMasterDataController.dart';
import '../../models/GetShipmentReceivedTableModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../widgets/ElevatedButtonWidget.dart';
import '../../widgets/TextFormField.dart';

Map<String, dynamic> selectedRow = {};
RxList<dynamic> markedList = [].obs;

class BarcodeMappingScreen extends StatefulWidget {
  const BarcodeMappingScreen({super.key});

  @override
  State<BarcodeMappingScreen> createState() => _BarcodeMappingScreenState();
}

class _BarcodeMappingScreenState extends State<BarcodeMappingScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();
  final TextEditingController _gtinController = TextEditingController();
  final TextEditingController _manufacturingController =
      TextEditingController();
  final TextEditingController _qrCodeController = TextEditingController();
  final TextEditingController _binLocationController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  FocusNode focusNode = FocusNode();
  FocusNode serialFocusNode = FocusNode();
  FocusNode gtinFocusNode = FocusNode();

  String? dropDownValue = "Select Config";
  List<String> dropDownList = [
    "Select Config",
    "G",
    "D",
    "S",
    "WG",
    "WD",
    "WS",
    "V",
    "U",
  ];

  String total = "0";

  String userName = "";
  String userID = "";
  String currentDate = "";

  void _showUserInfo() async {
    DateTime now = DateTime.now();
    var formatter = DateFormat.yMd().format(now);

    _manufacturingController.text = formatter;
    currentDate = formatter;

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

  // a method for showing the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _manufacturingController.text =
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  @override
  void initState() {
    _binLocationController.text = "AZ-W01-Z001-A0001";
    super.initState();
    _showUserInfo();
    _weightController.text = "0";

    print("current date: $currentDate");
  }

  String itemName = '';
  String itemID = '';

  List<getInventTableWMSDataByItemIdOrItemNameModel> itemList = [];
  String dValue = '';
  List<String> dList = [];

  List<GetItemInfoByItemSerialNoModel> itemInfoList = [];

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
            title: "Barcode Mapping".toUpperCase(),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/delete.png",
                  width: 30,
                  height: 30,
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
                    "Search Item Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
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
                          hintText: "Search Item No. Or Description",
                          controller: _searchController,
                          width: MediaQuery.of(context).size.width * 0.73,
                          onEditingComplete: () {
                            _onSearchItem();
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
                            _onSearchItem();
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
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonFormField(
                      value: dValue,
                      alignment: Alignment.centerLeft,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      padding: const EdgeInsets.only(top: 7),
                      onChanged: (String? newValue) {
                        setState(() {
                          dValue = newValue!;
                          itemID = itemList
                              .where((element) =>
                                  dValue.contains(element.iTEMID.toString()))
                              .first
                              .iTEMID
                              .toString();
                          itemName = itemList
                              .where((element) =>
                                  dValue.contains(element.iTEMID.toString()))
                              .first
                              .iTEMNAME
                              .toString();
                        });
                      },
                      isExpanded: true,
                      items:
                          dList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textScaleFactor: 0.7,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              background: null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      dValue.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Scan Serial No",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan Serial No",
                    controller: _serialNoController,
                    width: MediaQuery.of(context).size.width * 0.9,
                    focusNode: focusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                      GetItemInfoByItemSerialNoController.getData(
                              _serialNoController.text.trim())
                          .then((value) {
                        itemInfoList = value;

                        showDiologMethod(
                          context,
                          "Item Serial No. Already Exists",
                          () {
                            _gtinController.text =
                                itemInfoList[0].gTIN.toString();
                            dropDownValue =
                                itemInfoList[0].classification.toString();
                            _manufacturingController.text =
                                itemInfoList[0].mapDate.toString();
                            _qrCodeController.text =
                                itemInfoList[0].qrCode.toString();
                            _binLocationController.text =
                                itemInfoList[0].binLocation.toString();
                            _referenceController.text =
                                itemInfoList[0].reference.toString();
                            _lengthController.text =
                                itemInfoList[0].length.toString() == "null"
                                    ? "0"
                                    : itemInfoList[0].length.toString();
                            _widthController.text =
                                itemInfoList[0].width == "null"
                                    ? "0"
                                    : itemInfoList[0].width.toString();
                            _heightController.text =
                                itemInfoList[0].height == "null"
                                    ? "0"
                                    : itemInfoList[0].height.toString();
                            _weightController.text =
                                itemInfoList[0].weight == "null"
                                    ? "0"
                                    : itemInfoList[0].weight.toString();
                            _searchController.text =
                                itemInfoList[0].itemCode.toString();
                            FocusScope.of(context).requestFocus(gtinFocusNode);
                            getAllTblMappedBarcodesController
                                .getData(itemInfoList[0].itemCode.toString())
                                .then((val) {
                              setState(() {
                                itemList = val;
                                for (var element in itemList) {
                                  String temp =
                                      "${element.iTEMID} - ${element.iTEMNAME}";
                                  dList.add(temp);
                                }
                              });
                            });
                            setState(() {
                              itemID = itemInfoList[0].itemCode.toString();
                              itemName = itemInfoList[0].itemDesc.toString();
                              dList = [
                                "${itemInfoList[0].itemCode ?? ""} - ${itemInfoList[0].itemDesc ?? ""}"
                              ];
                              dValue = dList[0].toString();
                            });
                          },
                          () {
                            _serialNoController.clear();
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                        ).show();
                      }).onError((error, stackTrace) {
                        FocusScope.of(context).requestFocus(gtinFocusNode);
                        return;
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //       "Error: $error".replaceAll("Exception:", ""),
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //     backgroundColor: Colors.white,
                        //     duration: const Duration(seconds: 3),
                        //   ),
                        // );
                        // return;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Scan GTIN",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan GTIN",
                    controller: _gtinController,
                    focusNode: gtinFocusNode,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Select Config",
                    style: TextStyle(
                      fontSize: 16,
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
                    items: dropDownList,
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                    selectedItem: dropDownValue,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Select Manufacture Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "dd/mm/yyyy",
                    controller: _manufacturingController,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        size: 30,
                        color: Colors.blue[900]!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan QR Code",
                    controller: _qrCodeController,
                    width: MediaQuery.of(context).size.width * 0.9,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Scan Bin Location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan Bin Location",
                    controller: _binLocationController,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter Reference",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter/Scan Reference",
                    controller: _referenceController,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter Length",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter Length",
                    controller: _lengthController,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter Width",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter Width",
                    controller: _widthController,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter Height",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter Height",
                    controller: _heightController,
                    textInputAction: TextInputAction.next,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Enter Weight",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]!,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextFormFieldWidget(
                    hintText: "Enter Weight",
                    controller: _weightController,
                    textInputAction: TextInputAction.done,
                    width: MediaQuery.of(context).size.width * 0.9,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).unfocus();
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
                      if (_serialNoController.text.trim() == "" ||
                          _gtinController.text.trim() == "" ||
                          dropDownValue == "Select Config" ||
                          _binLocationController.text.trim() == "" ||
                          _lengthController.text.trim() == "" ||
                          _widthController.text.trim() == "" ||
                          _heightController.text.trim() == "" ||
                          dValue.toString() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill the above fields"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      Constants.showLoadingDialog(context);
                      insertIntoMappedBarcodeOrUpdateBySerialNoController
                          .insert(
                        itemID,
                        itemName,
                        _referenceController.text.trim(),
                        _gtinController.text.trim(),
                        _binLocationController.text.trim(),
                        _serialNoController.text.trim(),
                        dropDownValue.toString(),
                        _qrCodeController.text.trim(),
                        double.parse(_lengthController.text.trim()),
                        double.parse(_widthController.text.trim()),
                        double.parse(_heightController.text.trim()),
                        double.parse(_weightController.text.trim()),
                        _manufacturingController.text.trim(),
                        _binLocationController.text.trim().substring(0, 2),
                      )
                          .then((value) {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data saved successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          _serialNoController.clear();
                        });
                        UpdateStockMasterDataController.insertShipmentData(
                          itemID,
                          double.parse(_lengthController.text.trim()),
                          double.parse(_widthController.text.trim()),
                          double.parse(_heightController.text.trim()),
                          double.parse(_weightController.text.trim()),
                        );
                        FocusScope.of(context).requestFocus(focusNode);
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
      ),
    );
  }

  void _onSearchItem() async {
    FocusScope.of(context).unfocus();
    Constants.showLoadingDialog(context);
    getAllTblMappedBarcodesController
        .getData(_searchController.text.trim())
        .then((value) {
      setState(() {
        itemList = value;
        dList.clear();
        for (var element in itemList) {
          String temp = "${element.iTEMID} - ${element.iTEMNAME}";
          dList.add(temp);
        }
        dValue = dList[0];
      });

      GetTblStockMasterByItemIdController.getData(itemID).then((value) {
        setState(() {
          _widthController.text = value[0].width.toString();
          _heightController.text = value[0].height.toString();
          _lengthController.text = value[0].length.toString();
          _weightController.text = value[0].weight.toString();
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        setState(() {
          _widthController.text = "";
          _heightController.text = "";
          _lengthController.text = "";
          _weightController.text = "";
        });
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll("Exception:", "")),
        ),
      );
      Navigator.of(context).pop();
    });
  }

  AwesomeDialog showDiologMethod(
    BuildContext context,
    String title,
    VoidCallback btnOkOnPress,
    VoidCallback btnCancelOnPress,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: title,
      desc: "Do you want to update the data?",
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
      reverseBtnOrder: true,
      // change button text
      btnCancelText: "Cancel",
      btnOkText: "Yes, Update it!",
    );
  }
}

class StudentDataSource extends DataTableSource {
  List<GetShipmentReceivedTableModel> students;
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
        DataCell(
          Obx(
            () => Checkbox(
              value: markedList[index],
              onChanged: (value) {
                // user can check only one checkbox
                for (int i = 0; i < markedList.length; i++) {
                  markedList[i] = false;
                }
                markedList[index] = value!;
                selectedRow = student.toJson();
              },
            ),
          ),
        ),
        DataCell(SelectableText(student.itemCode ?? "")),
        DataCell(SelectableText(student.itemDesc ?? "")),
        DataCell(SelectableText(student.gTIN ?? "")),
        DataCell(SelectableText(student.remarks ?? "")),
        DataCell(SelectableText(student.user ?? "")),
        DataCell(SelectableText(student.classification ?? "")),
        DataCell(SelectableText(student.mainLocation ?? "")),
        DataCell(SelectableText(student.binLocation ?? "")),
        DataCell(SelectableText(student.intCode ?? "")),
        DataCell(SelectableText(student.itemSerialNo ?? "")),
        DataCell(SelectableText(student.mapDate ?? "")),
        DataCell(SelectableText(student.palletCode ?? "")),
        DataCell(SelectableText(student.reference ?? "")),
        DataCell(SelectableText(student.sID ?? "")),
        DataCell(SelectableText(student.cID ?? "")),
        DataCell(SelectableText(student.pO ?? "")),
        DataCell(SelectableText(student.trans.toString())),
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
