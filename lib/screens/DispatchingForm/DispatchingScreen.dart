import '../../controllers/Dispatching/GetDispatchingTableController.dart';
import '../../models/getDispatchingTableModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';
import 'DispatchingScreen2.dart';

class DispatchingScreen extends StatefulWidget {
  const DispatchingScreen({super.key});

  @override
  State<DispatchingScreen> createState() => _DispatchingScreenState();
}

class _DispatchingScreenState extends State<DispatchingScreen> {
  final TextEditingController _pickingSlipIdController =
      TextEditingController();

  String total = "0";

  List<getDispatchingTableModel> table = [];
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          autoImplyLeading: true,
          onPressed: () {
            Get.back();
          },
          title: "Dispatching Form".toUpperCase(),
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
                child: const TextWidget(
                  text: "Packing Slip ID*",
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
                        controller: _pickingSlipIdController,
                        hintText: "Enter/Scan Packing Slip ID",
                        width: MediaQuery.of(context).size.width * 0.73,
                        onEditingComplete: () {
                          packingSlipTable();
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
                          packingSlipTable();
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
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: const TextWidget(
                  text: "Items*",
                  fontSize: 16,
                ),
              ),
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
                  ],
                  source: StudentDataSource(table, context),
                  showCheckboxColumn: false,
                  showFirstLastButtons: true,
                  arrowHeadColor: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void packingSlipTable() {
    FocusScope.of(context).requestFocus(FocusNode());
    Constants.showLoadingDialog(context);
    GetDispatchingTableController.getShipmentReceived(
            _pickingSlipIdController.text.trim())
        .then((value) {
      Navigator.of(context).pop();
      setState(() {
        table = value;
        isMarked = List<bool>.filled(
          table.length,
          false,
        );
        total = table.length.toString();
      });
    }).onError((error, stackTrace) {
      setState(() {
        table = [];
        isMarked = List<bool>.filled(
          table.length,
          false,
        );
        total = "0";
      });
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No data found."),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}

class StudentDataSource extends DataTableSource {
  List<getDispatchingTableModel> students;
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
        if (value!) {
          Navigator.of(ctx).push(
            MaterialPageRoute(
              builder: (context) => DispatchingScreen2(
                config: student.cONFIGID ?? "",
                inventLocationId: student.iNVENTLOCATIONID ?? "",
                itemId: student.iTEMID ?? "",
                name: student.nAME ?? "",
                ordered: student.oRDERED == null ? 0 : student.oRDERED!,
                packingSlipId: student.pACKINGSLIPID ?? "",
                salesId: student.sALESID ?? "",
                vehicleShipPlateNumber: student.vEHICLESHIPPLATENUMBER ?? "",
              ),
            ),
          );
        }
      },
      cells: [
        DataCell(Text(student.sALESID ?? "")),
        DataCell(Text(student.iTEMID ?? "")),
        DataCell(Text(student.nAME ?? "")),
        DataCell(Text(student.iNVENTLOCATIONID ?? "")),
        DataCell(Text(student.cONFIGID ?? "")),
        DataCell(Text(student.oRDERED.toString())),
        DataCell(Text(student.pACKINGSLIPID ?? "")),
        DataCell(Text(student.vEHICLESHIPPLATENUMBER ?? "")),
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
