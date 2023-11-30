// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:alessa_v2/models/GetItemInfoByItemSerialNoModel.dart';
import 'package:alessa_v2/screens/PalletIdInquiry/PalletIdInquiryScreen2.dart';
import 'package:alessa_v2/widgets/ElevatedButtonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/PalletIdInquiry/PalletIdInquiryController.dart';

import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/TextFormField.dart';
import '../../../widgets/TextWidget.dart';

class PalletIdInquiryScreen1 extends StatefulWidget {
  const PalletIdInquiryScreen1({super.key});

  @override
  State<PalletIdInquiryScreen1> createState() => _PalletIdInquiryScreen1State();
}

class _PalletIdInquiryScreen1State extends State<PalletIdInquiryScreen1> {
  TextEditingController serialNoController = TextEditingController();
  FocusNode serialNoFocusNode = FocusNode();

  String total = "0";
  List<GetItemInfoByItemSerialNoModel> table = [];
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
  }

  @override
  void dispose() {
    super.dispose();
    serialNoController.dispose();
  }

  // scaffoldkey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            autoImplyLeading: true,
            onPressed: () {
              Get.back();
            },
            title: "Pallet Id inquiry".toUpperCase(),
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
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: const TextWidget(
                    text: "Serial No.",
                    fontSize: 16,
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
                          focusNode: serialNoFocusNode,
                          hintText: "Enter/Scan Serial No.",
                          controller: serialNoController,
                          width: MediaQuery.of(context).size.width * 0.73,
                          onEditingComplete: () {
                            onClick();
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
                            onClick();
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
                const SizedBox(height: 20),
                Container(
                  // decoration: BoxDecoration(
                  //   // border: Border.all(
                  //   //   color: Colors.grey,
                  //   //   width: 1,
                  //   // ),
                  // ),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataTextStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
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
                            'GTIN',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Pallet Code',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Item Code',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Serial No.',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'Bin Location',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                        ],
                        rows: table.map((e) {
                          return DataRow(onSelectChanged: (value) {}, cells: [
                            DataCell(SelectableText(e.gTIN ?? "")),
                            DataCell(SelectableText(e.palletCode ?? "")),
                            DataCell(SelectableText(e.itemCode ?? "")),
                            DataCell(SelectableText(e.itemSerialNo ?? "")),
                            DataCell(SelectableText(e.binLocation ?? "")),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      title: "Scan Again",
                      fontSize: 16,
                      textColor: Colors.white,
                      color: Colors.grey,
                      onPressed: () {
                        // clear data and focus back to serial no
                        setState(() {
                          serialNoController.clear();
                          table = [];
                          total = "0";
                          FocusScope.of(context)
                              .requestFocus(serialNoFocusNode);
                        });
                      },
                    ),
                    ElevatedButtonWidget(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50,
                      title: "Transfer Location",
                      fontSize: 16,
                      textColor: Colors.white,
                      color: Colors.orange,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (table.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "No Data Found, not allowed to Transfer"),
                              backgroundColor: Colors.grey,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }
                        if (table[0].palletCode.toString().isEmpty ||
                            table[0].palletCode.toString() == "null") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "PalletID/Code is EMPTY, not allowed to Transfer"),
                              backgroundColor: Colors.grey,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          return;
                        }

                        Get.to(
                          () => PalletIdInquiryScreen2(
                            grin: table[0].gTIN ?? "",
                            palletCode: table[0].palletCode ?? "",
                            serialNo: table[0].itemSerialNo ?? "",
                            binLocation: table[0].binLocation ?? "",
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onClick() async {
    if (serialNoController.text.trim().isEmpty) {
      // hide keyboard
      FocusScope.of(context).requestFocus(FocusNode());
      return;
    }

    // print("Old Serial No: ${serialNoController.text.trim()}");
    // var serialNo = serialNoController.text.trim().replaceAll("", "");
    // serialNo.replaceAll("char(29)", "");
    // serialNo.replaceAll("Char(29)", "");
    // serialNo.replaceAll("CHAR(29)", "");
    // print("New Serial No: $serialNo");

    Constants.showLoadingDialog(context);
    PalletIdInquiryController.getShipmentPalletizing(
            serialNoController.text.trim())
        .then((value) {
      setState(() {
        table = value;
        FocusScope.of(context).requestFocus(serialNoFocusNode);
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setState(() {
        serialNoController.clear();
        FocusScope.of(context).requestFocus(serialNoFocusNode);
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString().replaceAll("Exception:", ""))));
    });
  }
}
