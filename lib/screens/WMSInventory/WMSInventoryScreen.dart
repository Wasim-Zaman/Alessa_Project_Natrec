// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, unused_element, avoid_print

import 'package:alessa_v2/controllers/WMSInventory/GetDistinctMappedBarcodeItemIdsController.dart';
import 'package:alessa_v2/controllers/WMSInventory/GetmapBarcodeDataByBinLocationController.dart';
import 'package:alessa_v2/controllers/WMSInventory/GetDistinctMappedBarcodeBinLocationsController.dart';
import 'package:alessa_v2/controllers/WMSInventory/GetmapBarcodeDataByMultipleBinLocations.dart';
import 'package:alessa_v2/models/GetmapBarcodeDataByBinLocationModel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/WMSInventory/getAllTblUsersController.dart';
import '../../controllers/WMSInventory/insertIntoWmsJournalCountingOnlyCLController.dart';
import '../../models/getInventTableWMSDataByItemIdOrItemNameModel.dart';
import '../../utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/AppBarWidget.dart';
import '../../widgets/ElevatedButtonWidget.dart';

List<getInventTableWMSDataByItemIdOrItemNameModel> selectedRow = [];
RxList<dynamic> markedList = [].obs;

class WMSInventoryScreen extends StatefulWidget {
  @override
  State<WMSInventoryScreen> createState() => _WMSInventoryScreenState();
}

class _WMSInventoryScreenState extends State<WMSInventoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> binDropDownValue = [];
  List<String> binDropDownList = [];

  String? itemDropDownValue = "";
  List<String> itemDropDownList = [];

  List<String> binLocationDDValues = [];
  List<String> binLocationDDList = [];

  String classDropDownValue = "";
  List<String> classDropDownList = [];

  String? assignDropDownValue;
  List<String>? assignDropDownList = [];

  String containerIdValue = "";
  List<String> containerIdList = [];

  String itemNoAndDiscValue = "";
  List<String> itemNoAndDiscList = [];

  String total = "0";

  List<GetmapBarcodeDataByBinLocationModel> table = [];
  List<GetmapBarcodeDataByBinLocationModel> filterTable = [];

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
    Future.delayed(Duration.zero, () {
      Constants.showLoadingDialog(context);
      getAllTblUsersController.getData().then((val) {
        setState(
          () {
            assignDropDownList =
                val.map((e) => "${e.fullname!} - ${e.userID}").toList();

            assignDropDownValue = assignDropDownList!.first.toString();
          },
        );
        GetDistinctMappedBarcodeBinLocationsController.getData1().then((value) {
          setState(() {
            itemDropDownList = value.toSet().toList();
            itemDropDownList.removeWhere((element) => element == "");
            itemDropDownValue = itemDropDownList.first;
          });
        });
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString().replaceAll("Exception:", "")),
          ),
        );
      });
      GetDistinctMappedBarcodeBinLocationsController.getData().then((value) {
        // convert list to set and then back to list to remove duplicates
        // and remove empty value

        setState(() {
          binDropDownList = value.toSet().toList();
          binDropDownList.removeWhere((element) => element == "");
        });
        Navigator.pop(context);
      });
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll("Exception:", "")),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    markedList.clear();
    table.clear();
  }

  String? gender = "bin";

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
            title: "WMS Inventory".toUpperCase(),
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
        body: SizedBox(
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
                RadioListTile(
                  title: const Text("Filter By Item Code"),
                  value: "item",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      print(gender);
                      table.clear();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Filter by Bin Location"),
                  value: "bin",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      print(gender);
                      table.clear();
                    });
                  },
                ),
                const SizedBox(height: 10),
                gender == "bin"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: itemDropDownValue == null ? false : true,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Bin Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]!,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: MultiSelectDialogField(
                                items: binDropDownList
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                onConfirm: (values) {
                                  binDropDownValue = values;
                                  Constants.showLoadingDialog(context);
                                  GetmapBarcodeDataByMultipleBinLocations
                                          .postData(binDropDownValue)
                                      .then((value) {
                                    setState(() {
                                      table = value;
                                      filterTable = value;
                                      total = table.length.toString();

                                      for (var i = 0; i < value.length; i++) {
                                        containerIdList
                                            .add(value[i].classification ?? "");
                                      }
                                      // remove empty values
                                      containerIdList.removeWhere(
                                          (element) => element == "");
                                      containerIdList =
                                          containerIdList.toSet().toList();

                                      for (var i = 0; i < value.length; i++) {
                                        itemNoAndDiscList
                                            .add(value[i].itemCode ?? "");
                                      }
                                      // remove empty values
                                      itemNoAndDiscList.removeWhere(
                                          (element) => element == "");
                                      itemNoAndDiscList =
                                          itemNoAndDiscList.toSet().toList();
                                    });
                                    Navigator.pop(context);
                                  }).onError((error, stackTrace) {
                                    setState(() {
                                      table.clear();
                                      total = table.length.toString();
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: binDropDownValue.isEmpty ? false : true,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Filter by Classification",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]!,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: binDropDownValue.isEmpty ? false : true,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(left: 20),
                              child: DropdownSearch<String>(
                                items: containerIdList,
                                onChanged: (value) {
                                  setState(() {
                                    containerIdValue = value!;
                                    // filter the filterTable by containerIdValue
                                    filterTable = table
                                        .where((element) =>
                                            element.classification ==
                                            containerIdValue)
                                        .toList();
                                    total = filterTable.length.toString();
                                  });
                                },
                                selectedItem: containerIdValue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: binDropDownValue.isEmpty ? false : true,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Filter by Item Id",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]!,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: binDropDownValue.isEmpty ? false : true,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(left: 20),
                              child: DropdownSearch<String>(
                                items: itemNoAndDiscList,
                                onChanged: (value) {
                                  setState(() {
                                    itemNoAndDiscValue = value!;
                                    // filter the filterTable by itemNoAndDiscValue
                                    filterTable = table
                                        .where((element) =>
                                            element.itemCode ==
                                            itemNoAndDiscValue)
                                        .toList();
                                    total = filterTable.length.toString();
                                  });
                                },
                                selectedItem: itemNoAndDiscValue,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Item ID",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900]!,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.only(left: 20),
                            child: DropdownSearch<String>(
                              items: itemDropDownList,
                              onChanged: (value) {
                                setState(() {
                                  itemDropDownValue = value!;
                                });

                                Constants.showLoadingDialog(context);
                                dataToTable1(itemDropDownValue.toString());
                              },
                              selectedItem: itemDropDownValue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: itemDropDownValue == null ? false : true,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Bin Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]!,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Visibility(
                              visible: itemDropDownValue == null ? false : true,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: MultiSelectDialogField(
                                  items: binLocationDDList
                                      .map((e) => MultiSelectItem(e, e))
                                      .toList(),
                                  listType: MultiSelectListType.CHIP,
                                  onConfirm: (values) {
                                    binLocationDDValues = values;
                                    Constants.showLoadingDialog(context);
                                    GetmapBarcodeDataByMultipleBinLocations
                                            .postData(binLocationDDValues)
                                        .then((value) {
                                      setState(() {
                                        table = value;
                                        filterTable = value;
                                        total = table.length.toString();

                                        for (var i = 0; i < value.length; i++) {
                                          classDropDownList.add(
                                              value[i].classification ?? "");
                                        }
                                        // remove empty value
                                        classDropDownList.removeWhere(
                                            (element) => element == "");

                                        classDropDownList =
                                            classDropDownList.toSet().toList();
                                      });
                                      Navigator.pop(context);
                                    }).onError((error, stackTrace) {
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: itemDropDownValue == null ? false : true,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Filter by Classification",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]!,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: itemDropDownValue == null ? false : true,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(left: 20),
                              child: DropdownSearch<String>(
                                items: classDropDownList,
                                onChanged: (value) {
                                  setState(() {
                                    classDropDownValue = value!;
                                    // filter the filterTable by containerIdValue
                                    filterTable = table
                                        .where((element) =>
                                            element.classification ==
                                            containerIdValue)
                                        .toList();
                                    total = filterTable.length.toString();
                                  });
                                },
                                selectedItem: classDropDownValue,
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue[900]!,
                        width: 2,
                      ),
                    ),
                    child: PaginatedDataTable(
                      // header: Text(
                      //   "Total: $total",
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.blue[900]!,
                      //   ),
                      // ),

                      columnSpacing: 10,
                      horizontalMargin: 20,
                      showCheckboxColumn: false,
                      headingRowHeight: 30,
                      dataRowHeight: 60,
                      primary: true,
                      showFirstLastButtons: true,
                      source: StudentDataSource(filterTable, context),
                      rowsPerPage: 5,
                      checkboxHorizontalMargin: 10,
                      columns: const [
                        DataColumn(
                            label: Text(
                          'Item Code',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )),
                        DataColumn(
                          label: Text(
                            'Item Desc',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Classification',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Bin Location',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Item Serial No',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ], // Adjust the number of rows per page as needed
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Assign To:",
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
                    items: assignDropDownList!,
                    onChanged: (value) {
                      setState(() {
                        assignDropDownValue = value!;
                      });
                    },
                    selectedItem: assignDropDownValue,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButtonWidget(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    title: "Save",
                    onPressed: () {
                      if (table.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No data to save!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (assignDropDownValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a user!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      FocusScope.of(context).unfocus();
                      Constants.showLoadingDialog(context);
                      insertIntoWmsJournalCountingOnlyCLController
                          .postData(
                        table,
                        assignDropDownValue.toString(),
                        gender == "bin" ? "Bin Location" : "Item Id",
                      )
                          .then((value) {
                        setState(() {
                          table.clear();
                          selectedRow.clear();
                          markedList.value =
                              List.generate(table.length, (index) => false);
                          _searchController.clear();
                          binDropDownList.clear();
                          itemDropDownList.clear();
                          binLocationDDValues.clear();
                          binLocationDDList.clear();
                          containerIdList.clear();
                          itemNoAndDiscList.clear();
                          total = "0";
                        });
                        Get.back();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Assigned Successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }).onError((error, stackTrace) {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                error.toString().replaceAll("Exception:", "")),
                            backgroundColor: Colors.red,
                          ),
                        );
                        setState(() {
                          selectedRow.clear();
                          markedList.value =
                              List.generate(table.length, (index) => false);
                        });
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

  void dataToTable(val) {
    GetmapBarcodeDataByBinLocationController.getData(val).then((value) {
      setState(() {
        table = value;
        filterTable = value;

        total = table.length.toString();

        for (var i = 0; i < value.length; i++) {
          containerIdList.add(value[i].classification ?? "");
        }
        containerIdList = containerIdList.toSet().toList();
        containerIdList.removeWhere((element) => element == "");
        containerIdValue = containerIdList.first;

        for (var i = 0; i < value.length; i++) {
          itemNoAndDiscList.add(value[i].itemCode ?? "");
        }
        itemNoAndDiscList = itemNoAndDiscList.toSet().toList();
        itemNoAndDiscList.removeWhere((element) => element == "");
        itemNoAndDiscValue = itemNoAndDiscList.first;
      });
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      setState(() {
        table.clear();
        total = table.length.toString();
      });
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceAll("Exception:", ""),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void dataToTable1(val) {
    GetmapBarcodeDataByItemCodeController.getData(val).then((value) {
      setState(() {
        table = value;
        filterTable = value;

        total = table.length.toString();

        for (var i = 0; i < value.length; i++) {
          binLocationDDList.add(value[i].binLocation ?? "");
        }
        binLocationDDList = binLocationDDList.toSet().toList();
        binLocationDDList.removeWhere((element) => element == "");

        for (var i = 0; i < value.length; i++) {
          classDropDownList.add(value[i].classification ?? "");
        }
        // remove empty value
        classDropDownList.removeWhere((element) => element == "");

        classDropDownList = classDropDownList.toSet().toList();
      });
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      setState(() {
        table.clear();
        total = table.length.toString();
      });
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString().replaceAll("Exception:", ""),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
}

class StudentDataSource extends DataTableSource {
  List<GetmapBarcodeDataByBinLocationModel> students;
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
        DataCell(SelectableText(student.itemCode ?? "")),
        DataCell(SelectableText(student.itemDesc ?? "")),
        DataCell(SelectableText(student.classification ?? "")),
        DataCell(SelectableText(student.binLocation ?? "")),
        DataCell(SelectableText(student.itemSerialNo ?? "")),
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
