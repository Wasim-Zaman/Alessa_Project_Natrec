import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

import '../../controllers/BinToBinFromAXAPTA/getmapBarcodeDataByItemCodeController.dart';
import '../../controllers/PutAway/GetShipmentReceivedController.dart';
import '../../controllers/PutAway/UpdateShipmentController.dart';
import '../../models/GetShipmentReceivedModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/ElevatedButtonWidget.dart';
import '../../../../widgets/TextFormField.dart';
import '../../../../widgets/TextWidget.dart';

class PutAwayScreen extends StatefulWidget {
  const PutAwayScreen({super.key});

  @override
  State<PutAwayScreen> createState() => _PutAwayScreenState();
}

class _PutAwayScreenState extends State<PutAwayScreen> {
  final TextEditingController _listOfSerialNoController =
      TextEditingController();

  String dropdownValue = 'No Data';
  List<String> dropdownList = ['No Data'];

  String gtinValue = 'No Data';
  List<String> gtinList = ['No Data'];

  String result = "0";
  List<GetShipmentReceivedModel> table = [];
  List<bool> isMarked = [];

  int iteration = 0;

  final TextEditingController _searchController = TextEditingController();
  String? dropDownValue;
  List<String> dropDownList = [];
  List<String> filterList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Constants.showLoadingDialog(context);
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
          dropDownValue = "";
          filterList = [];
        });
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 10),
                              const TextWidget(
                                text: "Shipment Putaway",
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
                      const SizedBox(height: 10),
                      const FittedBox(
                        child: Text(
                          "All IN CAPS (LETTERS, DIGITS AND SIZE)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const TextWidget(
                              text: "Result",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: TextWidget(
                              text: result,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextFormFieldWidget(
                        hintText: "Enter/Scan Pallet Barcode",
                        controller: _listOfSerialNoController,
                        width: MediaQuery.of(context).size.width * 0.73,
                        onEditingComplete: () {
                          // unfocus the textfield
                          FocusScope.of(context).unfocus();
                          Constants.showLoadingDialog(context);
                          GetShipmentReceivedController.getShipmentReceived(
                                  _listOfSerialNoController.text)
                              .then((value) {
                            Navigator.pop(context);
                            dropdownList.clear();
                            gtinList.clear();

                            setState(() {
                              for (int i = 0; i < value.length; i++) {
                                dropdownList.add(value[i].sERIALNUM ?? '');
                                gtinList.add(value[i].gTIN ?? '');

                                isMarked.add(false);
                              }

                              table = value;

                              result = value.length.toString();

                              dropdownList.toSet().toList();
                              gtinList.toSet().toList();
                            });
                          }).onError((error, stackTrace) {
                            Navigator.pop(context);
                            dropdownList.clear();
                            setState(() {
                              dropdownList = ['No Data'];
                              gtinList = ['No Data'];
                            });
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
                          // unfocus the textfield
                          FocusScope.of(context).unfocus();
                          Constants.showLoadingDialog(context);
                          GetShipmentReceivedController.getShipmentReceived(
                                  _listOfSerialNoController.text)
                              .then((value) {
                            Navigator.pop(context);
                            dropdownList.clear();
                            gtinList.clear();

                            setState(() {
                              for (int i = 0; i < value.length; i++) {
                                dropdownList.add(value[i].sERIALNUM ?? '');
                                gtinList.add(value[i].gTIN ?? '');

                                isMarked.add(false);
                              }

                              table = value;

                              result = value.length.toString();

                              dropdownList.toSet().toList();
                              gtinList.toSet().toList();
                            });
                          }).onError((error, stackTrace) {
                            Navigator.pop(context);
                            dropdownList.clear();
                            setState(() {
                              dropdownList = ['No Data'];
                              gtinList = ['No Data'];
                            });
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
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Serial No.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "GTIN No.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  // remove above space between listview and container
                  padding: EdgeInsets.zero,

                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              dropdownList[index],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10), // add this line
                          Expanded(
                            flex: 1,
                            child: Text(
                              gtinList[index],
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: dropdownList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(left: 20),
              //   child: TextFormFieldWidget(
              //     hintText: "Enter/Scan Warehouse Zone",
              //     controller: _warehouseZoneController,
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     onEditingComplete: () {
              //       if (dropdownList.isEmpty ||
              //           _warehouseZoneController.text.isEmpty ||
              //           dropdownList.contains('No Data')) {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //             content: Text(
              //                 "Please try to fill the Pallet Serial No. & Warehouse Zone.")));
              //         return;
              //       }

              //       Constants.showLoadingDialog(context);

              //       UpdateShipmentController.updateShipment(
              //         dropdownList,
              //         _warehouseZoneController.text,
              //       ).then((value) {
              //         Navigator.of(context).pop();
              //         ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text(value.toString())));
              //         dropdownList.clear();
              //         gtinList.clear();
              //         setState(() {
              //           dropdownList = ['No Data'];
              //           gtinList = ['No Data'];
              //         });
              //         _warehouseZoneController.clear();
              //         _listOfSerialNoController.clear();
              //       }).onError(
              //         (error, stackTrace) {
              //           Navigator.of(context).pop();
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //                 content: Text(error
              //                     .toString()
              //                     .replaceAll("Exception:", ""))),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: const TextWidget(
                  text: "Scan Location To*",
                  fontSize: 16,
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
                  title: "Put-Away",
                  onPressed: () {
                    if (dropdownList.isEmpty ||
                        dropDownList.isEmpty ||
                        dropdownList.contains('No Data')) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please try to fill the Pallet Serial No. & Warehouse Zone.")));
                      return;
                    }

                    Constants.showLoadingDialog(context);

                    UpdateShipmentController.updateShipment(
                      dropdownList,
                      dropDownValue.toString(),
                    ).then((value) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.toString())));
                      dropdownList.clear();
                      gtinList.clear();
                      setState(() {
                        dropdownList = ['No Data'];
                        gtinList = ['No Data'];
                      });

                      _listOfSerialNoController.clear();
                    }).onError(
                      (error, stackTrace) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Something went wrong! Check your connection and try again.")),
                        );
                      },
                    );
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
}
