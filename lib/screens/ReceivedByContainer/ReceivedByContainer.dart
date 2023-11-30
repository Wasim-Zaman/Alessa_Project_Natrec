import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/Constants.dart';
import '../../../widgets/AppBarWidget.dart';
import '../../../widgets/TextFormField.dart';
import '../../../widgets/TextWidget.dart';
import '../../controllers/ReceivedByContainer/ReceivedDataByContainerController.dart';
import '../../models/DummyModel.dart';
import 'ScanSerialNumberScreen1.dart';

int RCQTY1 = 0;

class ReceivedByContainer extends StatefulWidget {
  const ReceivedByContainer({super.key});

  @override
  State<ReceivedByContainer> createState() => _ReceivedByContainerState();
}

class _ReceivedByContainerState extends State<ReceivedByContainer> {
  TextEditingController _shipmentIdController = TextEditingController();
  TextEditingController _filterController = TextEditingController();
  String total = "0";
  List<DummyModel> getAllAssetByLocationList = [];
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
          title: "Shipment Receiving".toUpperCase(),
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
                  text: "Container ID*",
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
                        controller: _shipmentIdController,
                        width: MediaQuery.of(context).size.width * 0.73,
                        onEditingComplete: () {
                          // hide keyboard
                          FocusScope.of(context).unfocus();
                          Constants.showLoadingDialog(context);
                          ReceivedDataByContainerController.getShipmentData(
                                  _shipmentIdController.text.trim())
                              .then((value) {
                            setState(() {
                              getAllAssetByLocationList = value;
                              total =
                                  getAllAssetByLocationList.length.toString();
                              isMarked = List<bool>.filled(
                                  getAllAssetByLocationList.length, false);
                            });
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(error
                                    .toString()
                                    .replaceAll("Exception:", ""))));
                          });
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
                          FocusScope.of(context).unfocus();
                          Constants.showLoadingDialog(context);
                          ReceivedDataByContainerController.getShipmentData(
                                  _shipmentIdController.text.trim())
                              .then((value) {
                            setState(() {
                              getAllAssetByLocationList = value;
                              total =
                                  getAllAssetByLocationList.length.toString();
                              isMarked = List<bool>.filled(
                                  getAllAssetByLocationList.length, false);
                            });
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(error
                                    .toString()
                                    .replaceAll("Exception:", ""))));
                          });
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
              total != "0"
                  ? Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: const TextWidget(
                        text: " Filter By Container ID*",
                        fontSize: 16,
                      ),
                    )
                  : Container(),
              total != "0"
                  ? Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormFieldWidget(
                        controller: _filterController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          // Filter by Container Id
                          setState(() {
                            getAllAssetByLocationList =
                                getAllAssetByLocationList
                                    .where((element) =>
                                        element.cONTAINERID!.contains(
                                            _filterController.text.trim()))
                                    .toList();
                            total = getAllAssetByLocationList.length.toString();
                            isMarked = List<bool>.filled(
                                getAllAssetByLocationList.length, false);
                          });
                        },
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: const TextWidget(
                      text: "Container Details*",
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const TextWidget(
                        text: "TOTAL",
                        fontSize: 16,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 50,
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
                      const SizedBox(width: 20),
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
                            label: Text(
                          'PURCH ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'CREATED DATE TIME',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'SHIPMENT ID',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'SHIPMENT STATUS',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                            label: Text(
                          'CONTAINER ID',
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
                          'QTY',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ],
                      rows: getAllAssetByLocationList.map((e) {
                        return DataRow(
                            onSelectChanged: (value) {
                              // keybord hide
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ScanSerialNumberScreen1(
                                  containerId: e.cONTAINERID ?? "",
                                  itemId: e.iTEMID ?? "",
                                  qty: int.parse(e.qTY.toString() == "null"
                                      ? "0"
                                      : e.qTY.toString()),
                                  shipmentId: e.sHIPMENTID ?? "",
                                  shipmentStatus:
                                      int.parse(e.sHIPMENTSTATUS.toString()),
                                  purchId: e.pURCHID ?? "",
                                  createdDateTime: e.cREATEDDATETIME ?? "",
                                );
                              }));
                            },
                            cells: [
                              DataCell(Text(
                                  (getAllAssetByLocationList.indexOf(e) + 1)
                                      .toString())),
                              DataCell(Text(e.pURCHID ?? "")),
                              DataCell(Text(e.cREATEDDATETIME ?? "")),
                              DataCell(Text(e.sHIPMENTID ?? "")),
                              DataCell(Text(e.sHIPMENTSTATUS.toString())),
                              DataCell(Text(e.cONTAINERID ?? "")),
                              DataCell(Text(e.iTEMID ?? "")),
                              DataCell(Text(e.qTY.toString())),
                            ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
