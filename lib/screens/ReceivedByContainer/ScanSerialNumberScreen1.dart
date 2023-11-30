import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/BarcodeMapping/GetTblStockMasterByItemIdController.dart';
import '../../controllers/ReceivedByContainer/getAllTblContainerReceivedCLController.dart';
import '../../controllers/WareHouseOperationController/GetAllTableZoneController.dart';
import '../../controllers/WareHouseOperationController/GetItemNameByItemId.dart';
import '../../utils/Constants.dart';
import '../../widgets/ElevatedButtonWidget.dart';
import '../../widgets/TextFormField.dart';
import '../../widgets/TextWidget.dart';
import 'ReceivedByContainer.dart';
import 'SaveScreen1.dart';

// ignore: must_be_immutable
class ScanSerialNumberScreen1 extends StatefulWidget {
  String createdDateTime;
  String purchId;
  String shipmentId;
  int shipmentStatus;
  String containerId;
  String itemId;
  int qty;

  ScanSerialNumberScreen1({
    required this.createdDateTime,
    required this.purchId,
    required this.shipmentId,
    required this.shipmentStatus,
    required this.containerId,
    required this.itemId,
    required this.qty,
  });

  @override
  State<ScanSerialNumberScreen1> createState() =>
      _ScanSerialNumberScreen1State();
}

class _ScanSerialNumberScreen1State extends State<ScanSerialNumberScreen1> {
  final TextEditingController _jobOrderNoController = TextEditingController();
  final TextEditingController _containerNoController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _gtinNoController = TextEditingController();
  final TextEditingController _receivingZoneController =
      TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String dropdownValue = 'Select Zone';
  List<String> dropdownList = ['Select Zone'];

  String itemName = '';
  String cond = '';

  @override
  void initState() {
    super.initState();

    _jobOrderNoController.text = widget.shipmentId;
    _containerNoController.text = widget.containerId;
    _itemNameController.text = itemName;
    _weightController.text = "0";

    Future.delayed(Duration.zero, () {
      Constants.showLoadingDialog(context);
      GetAllTableZoneController.getAllTableZone().then((value) {
        dropdownValue = dropdownList[0];
        for (int i = 0; i < value.length; i++) {
          dropdownList.add(value[i].rZONE.toString());
          // convert the dropdownList to a list of strings
          dropdownList = dropdownList.toSet().toList();
        }
        getAllTblContainerReceivedCLController
            .getAllTableZone(
          widget.qty.toString(),
          widget.containerId,
          widget.itemId,
        )
            .then((value) {
          setState(() {
            RCQTY1 = value;
          });
        }).onError((error, stackTrace) {
          setState(() {
            RCQTY1 = 0;
          });
          Navigator.pop(context);
        });
        GetItemNameByItemIdController.getName(widget.itemId).then((value) {
          setState(() {
            itemName = value[0].itemDesc ?? "";
            _itemNameController.text = value[0].itemDesc ?? "";
            cond = value[0].classification ?? "";
          });
          GetTblStockMasterByItemIdController.getData(widget.itemId)
              .then((value) {
            setState(() {
              _widthController.text =
                  double.parse(value[0].width.toString()).toString();
              _heightController.text =
                  double.parse(value[0].height.toString()).toString();
              _lengthController.text =
                  double.parse(value[0].length.toString()).toString();
              _weightController.text =
                  double.parse(value[0].weight.toString()).toString();
            });
            print("width: ${value[0].width}");
            print("height: ${value[0].height}");
            print("length: ${value[0].length}");
            Navigator.of(context).pop();
          }).onError((error, stackTrace) {
            Navigator.of(context).pop();
            setState(() {
              _widthController.text = "";
              _heightController.text = "";
              _lengthController.text = "";
            });
          });
        }).onError((error, stackTrace) {
          setState(() {
            itemName = "";
            _itemNameController.text = "";
            cond = "";
          });
          GetTblStockMasterByItemIdController.getData(widget.itemId)
              .then((value) {
            setState(() {
              _widthController.text =
                  double.parse(value[0].width.toString()).toString();
              _heightController.text =
                  double.parse(value[0].height.toString()).toString();
              _lengthController.text =
                  double.parse(value[0].length.toString()).toString();
              _weightController.text =
                  double.parse(value[0].weight.toString()).toString();
            });
            print("width: ${value[0].width}");
            print("height: ${value[0].height}");
            print("length: ${value[0].length}");
            Navigator.of(context).pop();
          }).onError((error, stackTrace) {
            Navigator.of(context).pop();
            setState(() {
              _widthController.text = "";
              _heightController.text = "";
              _lengthController.text = "";
            });
          });
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceAll("Exception:", "")),
          ),
        );
        Navigator.pop(context);
      });
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
            children: <Widget>[
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
                  margin: const EdgeInsets.only(left: 20, top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/delete.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      const TextWidget(
                        text: "JOB ORDER NO*",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _jobOrderNoController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        hintText: "Job Order No",
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      const TextWidget(
                        text: "CONTAINER NO*",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _containerNoController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        hintText: "Container No",
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const TextWidget(
                                  text: "Item Code:",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                TextWidget(
                                  text: "PO QTY*\n${widget.qty.toString()}",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextWidget(
                                  text: widget.itemId,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                TextWidget(
                                  text: "Received*\n$RCQTY1",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const TextWidget(
                                  text: "CON",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                TextWidget(
                                  text: cond,
                                  fontSize: 15,
                                  color: Colors.white,
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
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Item Name",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _itemNameController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Item Name",
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "GTIN",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _gtinNoController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter/Scan GTIN No",
                ),
              ),
              const SizedBox(height: 20),
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
                  selectedItem: "Select Receiving Zone",
                ),
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
                    text: "Width",
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
                    controller: _widthController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Width",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWidget(
                    text: "Height",
                    fontSize: 15,
                  ),
                  TextWidget(
                    text: "Weight",
                    fontSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldWidget(
                    controller: _heightController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Length",
                  ),
                  TextFormFieldWidget(
                    controller: _weightController,
                    width: MediaQuery.of(context).size.width * 0.4,
                    hintText: "Enter Weight",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButtonWidget(
                  title: "Scan Serial Number",
                  onPressed: () {
                    if (_gtinNoController.text.trim().isEmpty ||
                        _lengthController.text.trim().isEmpty ||
                        _weightController.text.trim().isEmpty ||
                        _heightController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter all the required fields"),
                        ),
                      );
                      return;
                    }
                    Get.to(() => SaveScreen1(
                          gtin: _gtinNoController.text.trim(),
                          rZone: dropdownValue,
                          containerId: widget.containerId,
                          itemId: widget.itemId,
                          createdDateTime: widget.createdDateTime,
                          itemName: itemName,
                          purchId: widget.purchId,
                          qty: widget.qty,
                          shipmentId: widget.shipmentId,
                          shipmentStatus: widget.shipmentStatus,
                          length: double.parse(_lengthController.text.trim()),
                          width: double.parse(_widthController.text.trim()),
                          height: double.parse(_heightController.text.trim()),
                          weight: double.parse(_weightController.text.trim()),
                        ));
                  },
                  textColor: Colors.white,
                  fontSize: 18,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
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
}
