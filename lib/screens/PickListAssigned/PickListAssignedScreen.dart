import '../../controllers/PickListAssigned/GetPickingListController.dart';
import '../../models/GetPickingListModel.dart';
import '../../screens/PickListAssigned/PickListAssignedScreen2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';
import '../HomeScreen.dart';

// ignore: must_be_immutable
class PickListAssignedScreen extends StatefulWidget {
  String? pickedQty;

  PickListAssignedScreen({this.pickedQty});

  @override
  State<PickListAssignedScreen> createState() => _PickListAssignedScreenState();
}

class _PickListAssignedScreenState extends State<PickListAssignedScreen> {
  final TextEditingController _routeIdController = TextEditingController();
  String total = "0";
  List<GetPickingListModel> BinToBinJournalTableList = [];
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
    if (widget.pickedQty != null && widget.pickedQty != "") {
      Future.delayed(Duration.zero, () {
        Constants.showLoadingDialog(context);
        GetPickingListController.getAllTable(widget.pickedQty!).then((value) {
          setState(() {
            BinToBinJournalTableList = value;
            total = value.length.toString();
            isMarked = List<bool>.filled(value.length, false);
          });
          Navigator.pop(context);
        }).onError(
          (error, stackTrace) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.toString().replaceAll("Exception:", ""),
                ),
              ),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => HomeScreen(roles: const []));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            autoImplyLeading: true,
            onPressed: () {
              Get.back();
            },
            title: "Pick List Form".toUpperCase(),
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
                    text: "Route ID*",
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
                          controller: _routeIdController,
                          hintText: "Enter/Scan Journal ID",
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: const TextWidget(
                        text: "Items*",
                        fontSize: 16,
                      ),
                    ),
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
                            child: TextWidget(text: total),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
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
                              label: Text('PICKING ROUTE ID',
                                  style: TextStyle(color: Colors.white))),
                          DataColumn(
                              label: Text('INVENT LOCATION ID',
                                  style: TextStyle(color: Colors.white))),
                          DataColumn(
                              label: Text(
                            'CONFIG ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'ITEM NAME',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'QTY',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'CUSTOMER',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'DLV DATE',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'TRANSREF ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'EXP EDITION STATUS',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'DATE TIME ASSIGNED',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'ASSIGNED TOUSER ID',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'PICK STATUS',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          DataColumn(
                              label: Text(
                            'QTY PICKED',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                        ],
                        rows: BinToBinJournalTableList.map((e) {
                          return DataRow(
                              onSelectChanged: (value) {
                                if (e.qTY == 0 ||
                                    e.qTY == null ||
                                    e.pICKSTATUS == "Picked") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Item already picked & ready for dispatch!'),
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                                Get.to(
                                  () => PickListAssingedScreen2(
                                    PICKINGROUTEID: e.pICKINGROUTEID.toString(),
                                    INVENTLOCATIONID:
                                        e.iNVENTLOCATIONID.toString(),
                                    CONFIGID: e.cONFIGID.toString(),
                                    ITEMID: e.iTEMID.toString(),
                                    ITEMNAME: e.iTEMNAME.toString(),
                                    QTY: e.qTY.toString(),
                                    CUSTOMER: e.cUSTOMER.toString(),
                                    DLVDATE: e.dLVDATE.toString(),
                                    TRANSREFID: e.tRANSREFID.toString(),
                                    EXPEDITIONSTATUS:
                                        e.eXPEDITIONSTATUS.toString(),
                                    DATETIMEASSIGNED:
                                        e.dATETIMEASSIGNED.toString(),
                                    ASSIGNEDTOUSERID:
                                        e.aSSIGNEDTOUSERID.toString(),
                                    PICKSTATUS: e.pICKSTATUS.toString(),
                                    QTYPICKED: e.qTYPICKED == null ? "0" : "0",
                                  ),
                                );
                              },
                              cells: [
                                DataCell(Text(
                                    (BinToBinJournalTableList.indexOf(e) + 1)
                                        .toString())),
                                DataCell(Text(e.pICKINGROUTEID ?? "")),
                                DataCell(Text(e.iNVENTLOCATIONID ?? "")),
                                DataCell(Text(e.cONFIGID ?? "")),
                                DataCell(Text(e.iTEMID ?? "")),
                                DataCell(Text(e.iTEMNAME ?? "")),
                                DataCell(Text(e.qTY.toString())),
                                DataCell(Text(e.cUSTOMER ?? "")),
                                DataCell(Text(e.dLVDATE ?? "")),
                                DataCell(Text(e.tRANSREFID ?? "")),
                                DataCell(Text(e.eXPEDITIONSTATUS.toString())),
                                DataCell(Text(e.dATETIMEASSIGNED ?? "")),
                                DataCell(Text(e.aSSIGNEDTOUSERID ?? "")),
                                DataCell(Text(e.pICKSTATUS ?? "")),
                                DataCell(Text(e.qTYPICKED == null
                                    ? "0"
                                    : e.qTYPICKED.toString())),
                              ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onClick() async {
    // unfocus from keyboard
    FocusScope.of(context).unfocus();
    Constants.showLoadingDialog(context);
    GetPickingListController.getAllTable(_routeIdController.text.trim())
        .then((value) {
      setState(() {
        BinToBinJournalTableList = value;
        total = value.length.toString();
        isMarked = List<bool>.filled(value.length, false);
      });
      Navigator.pop(context);
    }).onError(
      (error, stackTrace) {
        setState(() {
          BinToBinJournalTableList = [];
          total = "0";
          isMarked = [];
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString().replaceAll("Exception:", ""),
            ),
          ),
        );
      },
    );
  }
}
