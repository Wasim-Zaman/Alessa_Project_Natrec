// ignore_for_file: non_constant_identifier_names

import '../../screens/Palletizing/PalletGenerateScreen.dart';
import '../../utils/Constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextWidget.dart';
import '../../controllers/WareHouseOperationController/GetAllTableZoneController.dart';

// ignore: must_be_immutable
class PalletProceedScreen extends StatefulWidget {
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

  PalletProceedScreen({
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
  State<PalletProceedScreen> createState() => _PalletProceedScreenState();
}

class _PalletProceedScreenState extends State<PalletProceedScreen> {
  final TextEditingController _receivingZoneController =
      TextEditingController();

  String dropdownValue = 'Select Zone';
  List<String> dropdownList = ['Select Zone'];

  String result = "0";
  List<bool> isMarked = [];

  @override
  void initState() {
    print("widget.shipmentId: ${widget.shipmentId}");
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      Constants.showLoadingDialog(context);
      GetAllTableZoneController.getAllTableZone().then((value) {
        dropdownValue = dropdownList[0];
        for (int i = 0; i < value.length; i++) {
          dropdownList.add(value[i].rZONE.toString());
        }
        setState(() {});
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      });
    });
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
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 18,
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
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Transfer Id:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tRANSFERID,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Item ID:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.iTEMID,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Receiving Zone",
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
                      hintText: "Enter/Scan Receiving Zone",
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  enabled: true,
                  onChanged: (value) {
                    setState(() {
                      _receivingZoneController.text = value!;
                      dropdownValue = value;
                    });
                  },
                  selectedItem: dropdownValue,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButtonWidget(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  title: "Proceed",
                  onPressed: () {
                    if (dropdownValue == "Select Zone" || dropdownValue == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select receiving zone"),
                        ),
                      );
                      return;
                    }
                    Get.to(
                      () => PalletGenerateScreen(
                        iNVENTLOCATIONIDFROM: widget.iNVENTLOCATIONIDFROM,
                        iNVENTLOCATIONIDTO: widget.iNVENTLOCATIONIDTO,
                        iTEMID: widget.iTEMID,
                        tRANSFERID: widget.tRANSFERID.toString(),
                        shipmentId: widget.shipmentId,
                        ALS_PACKINGSLIPREF: widget.ALS_PACKINGSLIPREF,
                        ALS_TRANSFERORDERTYPE:
                            int.parse(widget.ALS_TRANSFERORDERTYPE.toString()),
                        QTYTRANSFER: int.parse(widget.QTYTRANSFER.toString()),
                        ITEMNAME: widget.ITEMNAME,
                        CONFIGID: widget.CONFIGID,
                        WMSLOCATIONID: widget.WMSLOCATIONID,
                      ),
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
