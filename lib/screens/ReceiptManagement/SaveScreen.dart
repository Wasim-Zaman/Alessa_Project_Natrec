// ignore_for_file: use_key_in_widget_constructors

import 'package:alessa_v2/controllers/Palletization/GenerateAndUpdatePalletIdController.dart';
import 'package:alessa_v2/controllers/WareHouseOperationController/InsetManyIntoMappedBarcodeNewController.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../controllers/WareHouseOperationController/GenerateSerialNumberforRecevingController.dart';
import '../../controllers/WareHouseOperationController/InsertShipmentReceivedData.dart';
import '../../controllers/WareHouseOperationController/UpdateStockMasterDataController.dart';
import '../../utils/Constants.dart';
import '../../widgets/ElevatedButtonWidget.dart';
import '../../widgets/TextFormField.dart';
import '../../widgets/TextWidget.dart';
import 'package:flutter/material.dart';

import 'ShipmentDispatchingScreen.dart';

// ignore: must_be_immutable
class SaveScreen extends StatefulWidget {
  String gtin;
  String rZone;
  String itemName;
  String createdDateTime;
  String purchId;
  String shipmentId;
  int shipmentStatus;
  String containerId;
  String itemId;
  int qty;
  double length;
  double width;
  double height;
  double weight;

  SaveScreen({
    required this.gtin,
    required this.itemName,
    required this.createdDateTime,
    required this.purchId,
    required this.shipmentId,
    required this.shipmentStatus,
    required this.containerId,
    required this.itemId,
    required this.qty,
    required this.rZone,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
  });

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final TextEditingController _jobOrderNoController = TextEditingController();
  final TextEditingController _containerNoController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _jobOrderNoController.text = widget.shipmentId;
    _containerNoController.text = widget.containerId;
    _itemNameController.text = widget.itemName;
  }

  @override
  void dispose() {
    firstFocusNode.removeListener(() {});
    secondFocusNode.removeListener(() {});
    super.dispose();
  }

  String dropdownValue = 'G';
  List<String> dropdownList = [
    'G',
    'D',
    'DC',
    'MCI',
    'S',
  ];

  List<String> serialNoList = [];
  List<String> configList = [];
  List<String> remarksList = [];

  int lengthOfSerialNo = 0;

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: "Item Code:",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          TextWidget(
                            text: widget.itemId,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ],
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
                                TextWidget(
                                  text: "PO QTY*\n${widget.qty}",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextWidget(
                                  text: "Received*\n$RCQTY",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextWidget(
                                  text: "Pallet*\n${serialNoList.length}",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                TextWidget(
                                  text: "CON",
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 10),
                                TextWidget(
                                  text: "1",
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
              const SizedBox(height: 10),
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
                  hintText: "Item Name/Description",
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Remarks",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _remarksController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter Remarks (User Input  )",
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "List of Item Config",
                  fontSize: 15,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(left: 20),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: dropdownList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Enter Serial Number",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  focusNode: secondFocusNode,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter/Scan Serial No.",
                  autofocus: false,
                  controller: _serialNoController,
                  onFieldSubmitted: (p0) {
                    if (RCQTY >= widget.qty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Sorry! The Remaining Quantity is Zero."),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (_serialNoController.text.isEmpty) {
                      FocusScope.of(context).unfocus();
                      return;
                    }

                    Constants.showLoadingDialog(context);
                    FocusScope.of(context).unfocus();
                    InsertShipmentReceivedDataController.insertShipmentData(
                      widget.shipmentId,
                      widget.containerId,
                      '',
                      widget.itemName,
                      widget.itemId,
                      widget.purchId,
                      dropdownValue.toString(),
                      _serialNoController.text,
                      dropdownValue.toString().toString(),
                      DateTime.now().toString(),
                      widget.gtin,
                      widget.rZone,
                      DateTime.now().toString(),
                      "",
                      "AZ-W01-Z001-A0001",
                      _remarksController.text,
                      int.parse(widget.qty.toString()),
                      widget.length,
                      widget.width,
                      widget.height,
                      widget.weight,
                    ).then((value) {
                      setState(() {
                        serialNoList.add(_serialNoController.text);
                        configList.add(dropdownValue.toString());
                        remarksList.add(_remarksController.text);

                        lengthOfSerialNo = serialNoList.length;

                        RCQTY = RCQTY + 1;

                        // focus back to serial no field
                      });
                      UpdateStockMasterDataController.insertShipmentData(
                              widget.itemId,
                              widget.length,
                              widget.width,
                              widget.height,
                              widget.weight)
                          .then((value) {
                        insertManyIntoMappedBarcodeNewController
                            .getData(
                          widget.itemId,
                          widget.itemName,
                          dropdownValue.toString(),
                          "AZ",
                          _serialNoController.text.trim(),
                          DateTime.now().toString(),
                          "AZ-W01-Z001-A0001",
                          widget.gtin,
                          _remarksController.text.trim(),
                          "",
                          widget.shipmentId,
                          widget.purchId,
                          widget.containerId,
                          widget.qty.toString(),
                          widget.length.toString(),
                          widget.width.toString(),
                          widget.height.toString(),
                          widget.weight.toString(),
                        )
                            .then((value) {
                          Navigator.pop(context);
                          _serialNoController.clear();
                          FocusScope.of(context).requestFocus(secondFocusNode);
                        }).onError((error, stackTrace) {
                          setState(() {
                            _serialNoController.clear();
                            serialNoList.clear();
                            configList.clear();
                            remarksList.clear();
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error
                                  .toString()
                                  .replaceAll("Exception:", "")),
                            ),
                          );
                        });
                      }).onError((error, stackTrace) {
                        setState(() {
                          _serialNoController.clear();
                          serialNoList.clear();
                          configList.clear();
                          remarksList.clear();
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                error.toString().replaceAll("Exception:", "")),
                          ),
                        );
                      });
                    }).onError(
                      (error, stackTrace) {
                        setState(() {
                          _serialNoController.clear();
                          serialNoList.clear();
                          configList.clear();
                          remarksList.clear();
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                error.toString().replaceAll("Exception:", "")),
                          ),
                        );
                      },
                    ).onError((error, stackTrace) {
                      setState(() {
                        _serialNoController.clear();
                        serialNoList.clear();
                        configList.clear();
                        remarksList.clear();
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              error.toString().replaceAll("Exception:", "")),
                        ),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // generate serial no button
                  Container(
                    child: ElevatedButtonWidget(
                      title: "Generate Serial No.",
                      fontSize: 13,
                      color: Colors.orange[100],
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      onPressed: () {
                        if (RCQTY >= widget.qty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Sorry! The Remaining Quantity is Zero."),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        GenerateSerialNumberforRecevingController
                            .generateSerialNo(
                          widget.itemId,
                        ).then(
                          (value) {
                            Constants.showLoadingDialog(context);
                            FocusScope.of(context).unfocus();
                            InsertShipmentReceivedDataController
                                .insertShipmentData(
                              widget.shipmentId,
                              widget.containerId,
                              '',
                              widget.itemName,
                              widget.itemId,
                              widget.purchId,
                              dropdownValue.toString(),
                              value,
                              dropdownValue.toString(),
                              DateTime.now().toString(),
                              widget.gtin,
                              widget.rZone,
                              DateTime.now().toString(),
                              "",
                              "AZ-W01-Z001-A0001",
                              _remarksController.text,
                              int.parse(widget.qty.toString()),
                              widget.length,
                              widget.width,
                              widget.height,
                              widget.weight,
                            ).then((val) {
                              setState(() {
                                serialNoList.add(value);
                                configList.add(dropdownValue);
                                remarksList.add(_remarksController.text);

                                RCQTY = RCQTY + 1;
                              });
                              UpdateStockMasterDataController
                                  .insertShipmentData(
                                widget.itemId,
                                widget.length,
                                widget.width,
                                widget.height,
                                widget.weight,
                              ).then((vl) {
                                insertManyIntoMappedBarcodeNewController
                                    .getData(
                                  widget.itemId,
                                  widget.itemName,
                                  dropdownValue.toString(),
                                  "AZ",
                                  value,
                                  DateTime.now().toString(),
                                  "AZ-W01-Z001-A0001",
                                  widget.gtin,
                                  _remarksController.text.trim(),
                                  "",
                                  widget.shipmentId,
                                  widget.purchId,
                                  widget.containerId,
                                  widget.qty.toString(),
                                  widget.length.toString(),
                                  widget.width.toString(),
                                  widget.height.toString(),
                                  widget.weight.toString(),
                                )
                                    .then((value) {
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    _serialNoController.clear();
                                    serialNoList.clear();
                                    configList.clear();
                                    remarksList.clear();
                                  });
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error
                                          .toString()
                                          .replaceAll("Exception:", "")),
                                    ),
                                  );
                                });
                              }).onError((error, stackTrace) {
                                setState(() {
                                  _serialNoController.clear();
                                  serialNoList.clear();
                                  configList.clear();
                                  remarksList.clear();
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error
                                        .toString()
                                        .replaceAll("Exception:", "")),
                                  ),
                                );
                              });
                            }).onError(
                              (error, stackTrace) {
                                setState(() {
                                  _serialNoController.clear();
                                  serialNoList.clear();
                                  configList.clear();
                                  remarksList.clear();
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error
                                        .toString()
                                        .replaceAll("Exception:", "")),
                                  ),
                                );
                              },
                            ).onError((error, stackTrace) {
                              setState(() {
                                _serialNoController.clear();
                                serialNoList.clear();
                                configList.clear();
                                remarksList.clear();
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error
                                      .toString()
                                      .replaceAll("Exception:", "")),
                                ),
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),
                  // generate pallet code button
                  Container(
                    child: ElevatedButtonWidget(
                      title: "Generate Pallet Code",
                      fontSize: 13,
                      color: Colors.orange[100],
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      onPressed: () {
                        // if (RCQTY >= widget.qty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content:
                        //           Text("Sorry! The Remaining Quantity is Zero."),
                        //       backgroundColor: Colors.red,
                        //       duration: Duration(seconds: 2),
                        //     ),
                        //   );
                        //   return;
                        // }

                        if (serialNoList.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Sorry! Please Generate Serial Number First."),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        Constants.showLoadingDialog(context);
                        GenerateAndUpdatePalletIdController
                            .generateAndUpdatePalletId(
                          serialNoList,
                          dropdownValue.toString(),
                        ).then(
                          (value) {
                            Navigator.pop(context);

                            showDiologMethod(context, value).show();

                            setState(() {
                              serialNoList.clear();
                              configList.clear();
                              remarksList.clear();

                              lengthOfSerialNo = 0;
                            });
                          },
                        ).onError((error, stackTrace) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error
                                  .toString()
                                  .replaceAll("Exception:", "")),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                            label: Expanded(
                          child: Text(
                            'SERIAL NO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'CONFIG',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                          label: Text(
                            'Remarks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        serialNoList.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                serialNoList[index],
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                dropdownValue,
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                remarksList[index],
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
}
