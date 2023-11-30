// // ignore_for_file: avoid_print, non_constant_identifier_names

// import 'package:alessa_v2/models/validateItemSerialNumberForJournalCountingOnlyCLDetsModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../controllers/PhysicalInventory/getWmsJournalCountingOnlyCLByAssignedToUserIdController.dart';
// import '../../controllers/PhysicalInventory/incrementQTYSCANNEDInJournalCountingOnlyCLController.dart';
// import '../../controllers/PhysicalInventory/insertIntoWmsJournalCountingOnlyCLDetsController.dart';
// import '../../controllers/PhysicalInventory/validateItemSerialNumberForJournalCountingOnlyCLDetsController.dart';
// import '../../models/GetWmsJournalCountingOnlyCLByAssignedToUserIdModel.dart';
// import '../../utils/Constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../widgets/AppBarWidget.dart';
// import '../../../../widgets/TextWidget.dart';
// import '../../widgets/TextFormField.dart';

// class PhysicalInventoryScreen extends StatefulWidget {
//   const PhysicalInventoryScreen({super.key});

//   @override
//   State<PhysicalInventoryScreen> createState() =>
//       _PhysicalInventoryScreenState();
// }

// class _PhysicalInventoryScreenState extends State<PhysicalInventoryScreen> {
//   final TextEditingController _palletController = TextEditingController();
//   final TextEditingController _serialController = TextEditingController();
//   String total = "0";
//   String total2 = "0";

//   List<GetWmsJournalCountingOnlyCLByAssignedToUserIdModel> tbl1 = [];

//   List<validateItemSerialNumberForJournalCountingOnlyCLDetsModel> tbl2 = [];

//   List<bool> isMarked = [];

//   String _site = "By Serial";

//   String userName = "";
//   String userID = "";

//   void _showUserInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // final String? token = prefs.getString('token');
//     final String? userId = prefs.getString('userId');
//     final String? fullName = prefs.getString('fullName');
//     // final String? userLevel = prefs.getString('userLevel');
//     // final String? loc = prefs.getString('userLocation');

//     setState(() {
//       userName = fullName!;
//       userID = userId!;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _showUserInfo();
//     Future.delayed(Duration.zero, () {
//       Constants.showLoadingDialog(context);
//       getWmsJournalCountingOnlyCLByAssignedToUserIdController
//           .getData()
//           .then((value) {
//         setState(() {
//           tbl1 = value;

//           isMarked = List<bool>.generate(tbl1.length, (index) => false);
//           total = tbl1.length.toString();
//         });
//         Navigator.of(context).pop();
//       }).onError((error, stackTrace) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(error.toString().replaceAll("Exception:", "")),
//           ),
//         );
//         Navigator.of(context).pop();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: AppBarWidget(
//             autoImplyLeading: true,
//             onPressed: () {
//               Get.back();
//             },
//             title: "WMS Physical Inventory".toUpperCase(),
//             actions: [
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: Image.asset(
//                     "assets/delete.png",
//                     width: 30,
//                     height: 30,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.orange[100],
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Current Logged in User Id: ",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue[900]!,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         userID,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange[900]!,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.topCenter,
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1,
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         showCheckboxColumn: false,
//                         dataRowColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.grey.withOpacity(0.2)),
//                         headingRowColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.orange),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1,
//                           ),
//                         ),
//                         border: TableBorder.all(
//                           color: Colors.black,
//                           width: 1,
//                         ),
//                         columns: const [
//                           DataColumn(
//                               label: Text(
//                             'ID',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'ITEM ID',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'ITEM NAME',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'ITEM GROUP ID',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'GROUP NAME',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'INVENTORY BY',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'TRX DATE TIME',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'TRX USER ID ASSIGNED',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'TRX USER ID ASSIGNED BY',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'QTY SCANNED',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'QTY DIFFERENCE',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'QTY ON HAND',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'JOURNAL ID',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                           // DataColumn(
//                           //     label: Text(
//                           //   'BIN LOCATION',
//                           //   style: TextStyle(color: Colors.white),
//                           //   textAlign: TextAlign.center,
//                           // )),
//                         ],
//                         rows: tbl1.map((e) {
//                           return DataRow(onSelectChanged: (value) {}, cells: [
//                             DataCell(SelectableText(
//                                 (tbl1.indexOf(e) + 1).toString())),
//                             DataCell(SelectableText(e.iTEMID ?? "")),
//                             DataCell(SelectableText(e.iTEMNAME ?? "")),
//                             // DataCell(Text(e.iTEMGROUPID ?? "")),
//                             // DataCell(Text(e.gROUPNAME ?? "")),
//                             // // DataCell(Text(e.iNVENTORYBY ?? "")),
//                             // DataCell(Text(e.tRXDATETIME ?? "")),
//                             // DataCell(Text(e.tRXUSERIDASSIGNED ?? "")),
//                             // DataCell(Text(e.tRXUSERIDASSIGNEDBY ?? "")),
//                             // DataCell(Text(e.qTYSCANNED.toString() == "null"
//                             //     ? "0"
//                             //     : e.qTYSCANNED.toString())),
//                             // DataCell(Text(e.qTYDIFFERENCE.toString() == "null"
//                             //     ? "0"
//                             //     : e.qTYDIFFERENCE.toString())),
//                             // DataCell(Text(e.qTYONHAND.toString() == "null"
//                             //     ? "0"
//                             //     : e.qTYONHAND.toString())),
//                             // DataCell(Text(e.jOURNALID.toString() == "null"
//                             //     ? "0"
//                             //     : e.jOURNALID.toString())),
//                             // DataCell(Text(e.bINLOCATION ?? "")),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(right: 20, top: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const TextWidget(text: "TOTAL"),
//                       const SizedBox(width: 5),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.blue,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: TextWidget(text: total),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                     top: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Flexible(
//                         child: ListTile(
//                           title: const Text('By Pallet'),
//                           leading: Radio(
//                             value: "By Pallet",
//                             groupValue: _site,
//                             onChanged: (String? value) {
//                               // setState(() {
//                               //   _site = value!;
//                               //   print(_site);
//                               // });
//                             },
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         child: ListTile(
//                           title: const Text('By Serial'),
//                           leading: Radio(
//                             value: "By Serial",
//                             groupValue: _site,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _site = value!;
//                                 print(_site);
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Visibility(
//                   visible: _site != "" ? true : false,
//                   child: Container(
//                     margin: const EdgeInsets.only(left: 20, top: 10),
//                     child: TextWidget(
//                       text:
//                           _site == "By Pallet" ? "Scan Pallet" : "Scan Serial#",
//                       color: Colors.blue[900]!,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 _site == "By Pallet"
//                     ? Visibility(
//                         visible: _site != "" ? true : false,
//                         child: Container(
//                           margin: const EdgeInsets.only(left: 20),
//                           child: TextFormFieldWidget(
//                             controller: _palletController,
//                             readOnly: false,
//                             hintText: "Enter/Scan Pallet No",
//                             width: MediaQuery.of(context).size.width * 0.9,
//                             onEditingComplete: () {},
//                           ),
//                         ),
//                       )
//                     : Visibility(
//                         visible: _site != "" ? true : false,
//                         child: Container(
//                           margin: const EdgeInsets.only(left: 20),
//                           child: TextFormFieldWidget(
//                             controller: _serialController,
//                             readOnly: false,
//                             hintText: "Enter/Scan Serial No",
//                             width: MediaQuery.of(context).size.width * 0.9,
//                             onEditingComplete: () {
//                               FocusScope.of(context).requestFocus(FocusNode());
//                               Constants.showLoadingDialog(context);
//                               validateItemSerialNumberForJournalCountingOnlyCLDetsController
//                                   .getData(_serialController.text.trim())
//                                   .then((response) {
//                                 var table2 = response.allData![0];

//                                 for (var element in tbl1) {
//                                   if (element.iTEMID.toString().trim() !=
//                                           table2.itemCode.toString().trim() ||
//                                       tbl1.isEmpty) {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         backgroundColor: Colors.red,
//                                         content: Text(
//                                           "Mapped ITEMID not found in the list",
//                                         ),
//                                       ),
//                                     );
//                                     return;
//                                   }
//                                 }

//                                 setState(() {
//                                   tbl2.add(response);

//                                   // remove the selected pallet code row from the GetShipmentPalletizingList
//                                   // tbl1.removeAt(
//                                   //   tbl1.indexWhere(
//                                   //     (element) =>
//                                   //         element.iTEMID ==
//                                   //         table2.itemCode.toString(),
//                                   //   ),
//                                   // );

//                                   total2 = tbl2.length.toString();

//                                   // total = tbl1.length.toString();
//                                 });

//                                 incrementQTYSCANNEDInJournalCountingOnlyCLController
//                                     .getData(
//                                   tbl1.last.tRXUSERIDASSIGNED.toString(),
//                                   tbl1.last.tRXDATETIME.toString(),
//                                   tbl1.last.iTEMID.toString(),
//                                 )
//                                     .then((value) {
//                                   insertIntoWmsJournalCountingOnlyCLDetsController
//                                       .getData(
//                                     tbl1[0],
//                                     table2.classification.toString(),
//                                     table2.binLocation.toString(),
//                                     value.toString(),
//                                     table2.itemSerialNo.toString(),
//                                     table2.itemCode.toString(),
//                                     table2.itemDesc.toString(),
//                                     "physicalInventoryBinLocation",
//                                   )
//                                       .then((value) {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         backgroundColor: Colors.green,
//                                         content: Text(
//                                           "Item Added Successfully",
//                                         ),
//                                       ),
//                                     );
//                                     _serialController.clear();
//                                   }).onError((error, stackTrace) {
//                                     Navigator.of(context).pop();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         backgroundColor: Colors.red,
//                                         content: Text(
//                                           error
//                                               .toString()
//                                               .replaceAll("Exception:", ""),
//                                         ),
//                                       ),
//                                     );
//                                   });
//                                 }).onError((error, stackTrace) {
//                                   print("Hello");
//                                   Navigator.of(context).pop();
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text(
//                                         error
//                                             .toString()
//                                             .replaceAll("Exception:", ""),
//                                       ),
//                                     ),
//                                   );
//                                 });
//                               }).onError((error, stackTrace) {
//                                 // print("Hello");
//                                 Navigator.of(context).pop();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     backgroundColor: Colors.red,
//                                     content: Text(
//                                       error
//                                           .toString()
//                                           .replaceAll("Exception:", ''),
//                                     ),
//                                   ),
//                                 );
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                 const SizedBox(height: 10),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey,
//                       width: 1,
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         showCheckboxColumn: false,
//                         dataRowColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.grey.withOpacity(0.2)),
//                         headingRowColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.orange),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1,
//                           ),
//                         ),
//                         border: TableBorder.all(
//                           color: Colors.black,
//                           width: 1,
//                         ),
//                         columns: const [
//                           DataColumn(
//                               label: Text(
//                             'ID',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'ITEM ID',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'ITEM NAME',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'GTIN',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'TRANS',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'CLASSIFICATION',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'ITEM SERIAL NO.',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'MAIN LOCATION',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                           DataColumn(
//                               label: Text(
//                             'BIN LOCATION',
//                             style: TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           )),
//                         ],
//                         rows: tbl2.map((e) {
//                           return DataRow(onSelectChanged: (value) {}, cells: [
//                             DataCell(Text((tbl2.indexOf(e) + 1).toString())),
//                             DataCell(Text(e.allData![0].itemCode ?? "")),
//                             DataCell(Text(e.allData![0].itemDesc ?? "")),
//                             DataCell(Text(e.allData![0].gTIN ?? "")),
//                             DataCell(Text(
//                                 e.allData![0].trans.toString() == "null"
//                                     ? ""
//                                     : e.allData![0].trans.toString())),
//                             DataCell(Text(e.allData![0].classification ?? "")),
//                             DataCell(Text(e.allData![0].itemSerialNo ?? "")),
//                             DataCell(Text(e.allData![0].mainLocation ?? "")),
//                             DataCell(Text(e.allData![0].binLocation ?? "")),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(right: 20, top: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const TextWidget(text: "TOTAL"),
//                       const SizedBox(width: 5),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.blue,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: TextWidget(text: total2),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
