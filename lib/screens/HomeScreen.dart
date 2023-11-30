// ignore_for_file: avoid_print, must_be_immutable, unrelated_type_equality_checks

import 'package:alessa_v2/models/GetRolesAssignedToUserModel.dart';
import 'package:alessa_v2/screens/BarcodeMapping/BarcodeMappingScreen.dart';
import 'package:alessa_v2/screens/CycleCounting/CycleCountingScreen1.dart';
import 'package:alessa_v2/screens/PalletIdInquiry/PalletIdInquiryScreen.dart';
import 'package:alessa_v2/screens/PhysicalInverntoryByBinLocation/PhysicalInventoryByBinLocationScreen.dart';
import 'package:alessa_v2/screens/UnAllocatedItem/UnAllocatedItemsScreen1.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';

import '../../screens/Authentication/LoginScreen.dart';
import 'DispatchingForm/DispatchingScreen.dart';
import '../../screens/JournalMovement/JournalMovementScreen1.dart';
import '../../screens/ProfitAndLoss/ProfitAndLossScreen1.dart';
import '../../screens/ReturnRMA/ReturnRMAScreen1.dart';

import '../../Core/Animation/Fade_Animation.dart';
import '../../screens/BinToBinAXAPTA/BinToBinAxaptaScreen.dart';
import '../../screens/BinToBinInternal/BinToBinInternalScreen.dart';
import '../../screens/BinToBinJournal/BinToBinJournalScreen.dart';
import '../../screens/ItemReAllocation/ItemReAllocationScreen.dart';
import '../../screens/Palletizing/ShipmentPalletizingScreen.dart';
import '../../screens/PutAway/PutAwayScreen.dart';
import 'ReceiptManagement/ShipmentDispatchingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PickListAssigned/PickListAssignedScreen.dart';
import 'RMAputaway/RMAPutawayScreen.dart';

class HomeScreen extends StatefulWidget {
  List<GetRolesAssignedToUserModel> roles;
  HomeScreen({Key? key, required this.roles}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "images": [
      "assets/barcode.png",
      "assets/container.png",
      "assets/gtin_tracking.png",
      "assets/stock_management.png",
      "assets/picking.png",
      "assets/work_in_progress.png",
      "assets/physical_invention.png",
      "assets/log-in.png",
      "assets/journal.png",
      "assets/product-return.png",
      "assets/put-away.png",
      "assets/inventory.png",
      "assets/picking.png",
      "assets/movement.png",
      "assets/cycle-counting.png",
      "assets/profit-and-loss.png",
      "assets/allocation.png",
      "assets/receipt_management.png",
      "assets/logout.jpg",
    ],
    "titles": [
      "Barcode Mapping",
      "Receiving",
      "Palletization",
      "Shipment Put-Away",
      "Picking Slip",
      "Dispatching",
      "Bin To Bin (AXAPTA)",
      "Bin To Bin (Internal)",
      "Bin To Bin (Journal)",
      "Return RMA",
      "RMA Put-Away",
      "WMS Inventory",
      "Journal Movement Counting",
      "Profit and Loss",
      "Cycle Counting Process",
      "Items Re-Allocation",
      "Un-Allocated Items",
      "Pallet ID Inquiry",
      "Logout",
    ],
    "functions": [
      () {},
      () {},
      () {
        Get.to(() => const ShipmentPalletizingScreen());
      },
      () {
        Get.to(() => const PutAwayScreen());
      },
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {
        Get.to(() => const PhysicalInventoryByBinLocationScreen());
      },
      () {},
      () {},
      () {
        Get.to(() => const CycleCountingScreen1());
      },
      () {},
      () {
        Get.to(() => const UnAllocatedItemsScreen1());
      },
      () {
        Get.to(() => const PalletIdInquiryScreen1());
      },
      () {
        Get.offAll(() => const LoginScreen());
      },
    ],
  };

  void _showUserInfo() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    // String? userId = prefs.getString('userId');
    // String? fullName = prefs.getString('fullName');
    // String? userLevel = prefs.getString('userLevel');
    // String? loc = prefs.getString('userLocation');

    // print('token: $token');
    // print('userId: $userId');
    // print('fullName: $fullName');
    // print('userLevel: $userLevel');
    // print('loc: $loc');
  }

  @override
  void initState() {
    super.initState();
    data['functions'][0] = () {
      if (widget.roles
              .where((element) =>
                  element.roleName == "WMS Product Barcode Mapping")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => BarcodeMappingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][1] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Goods Receiving")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ShipmentDispatchingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][4] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Picking Slip")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => PickListAssignedScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][5] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Dispatching")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const DispatchingScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][6] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Bin to Bin(Axapta)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinAxaptaScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][7] = () {
      if (widget.roles
              .where(
                  (element) => element.roleName == "WMS Bin to Bin(Internal)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinInternalScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][8] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Bin to Bin(Journal)")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const BinToBinJournalScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][9] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Return RMA")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ReturnRMAScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][10] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS RMA Put-Away")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const RMAPutawayScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][12] = () {
      if (widget.roles
              .where((element) =>
                  element.roleName == "WMS Journal Movement Counting")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const JournalMovementScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'You are not authorized to access this feature.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][13] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Profit and Loss")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ProfitAndLossScreen1());
      } else {
        Get.snackbar(
          'Access Denied',
          'This feature is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };
    data['functions'][15] = () {
      if (widget.roles
              .where((element) => element.roleName == "WMS Item Re Allocation")
              .isNotEmpty ||
          widget.roles
              .where((element) => element.roleName == "Admin")
              .isNotEmpty) {
        Get.to(() => const ItemReAllocationScreen());
      } else {
        Get.snackbar(
          'Access Denied',
          'This feature is not available yet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    };

    Future.delayed(
      Duration.zero,
      () {
        _showUserInfo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // show a dialog when the back button is pressed
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeAnimation(
                          delay: 2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              'assets/alessa.png',
                              width: 150,
                              height: 80,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            return await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content:
                                    const Text('Do you want to exit an App'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, top: 10),
                            child: Image.asset(
                              "assets/back_button.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        child: Image.asset(
                          data["images"][0],
                          width: 50,
                          height: 50,
                        ),
                      ),
                      title: AutoSizeText(data["titles"][0]),
                      onTap: data["functions"][0],
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),

                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/shipmentTitle.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("SHIPMENTS"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][1],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][1]),
                                onTap: data["functions"][1],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][2],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][2]),
                                onTap: data["functions"][2],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][3],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][3]),
                                onTap: data["functions"][3],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/delivery.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("DELIVERY"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][4],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][4]),
                                onTap: data["functions"][4],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][5],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][5]),
                                onTap: data["functions"][5],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/bintobinMain.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("TRANSFER"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][6],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][6]),
                                onTap: data["functions"][6],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][7],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][7]),
                                onTap: data["functions"][7],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][8],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][8]),
                                onTap: data["functions"][8],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/rmaMain.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("RETURNS"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][9],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][9]),
                                onTap: data["functions"][9],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][10],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][10]),
                                onTap: data["functions"][10],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/inventoryMain.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("INVENTORY"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][11],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][11]),
                                onTap: data["functions"][11],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][12],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][12]),
                                onTap: data["functions"][12],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][13],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][13]),
                                onTap: data["functions"][13],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][14],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][14]),
                                onTap: data["functions"][14],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ExpandablePanel(
                      header: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Image.asset(
                            "assets/utility.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const AutoSizeText("UTILITY"),
                      ),
                      collapsed: Container(),
                      expanded: Column(
                        children: <Widget>[
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][15],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][15]),
                                onTap: data["functions"][15],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][16],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][16]),
                                onTap: data["functions"][16],
                              ),
                            ),
                          ),
                          FadeAnimation(
                            delay: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Image.asset(
                                    data["images"][17],
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                title: AutoSizeText(data["titles"][17]),
                                onTap: data["functions"][17],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                  FadeAnimation(
                    delay: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        child: Image.asset(
                          data["images"][18],
                          width: 50,
                          height: 50,
                        ),
                      ),
                      title: AutoSizeText(data["titles"][18]),
                      onTap: data["functions"][18],
                    ),
                  ),
                  // FadeAnimation(
                  //   delay: 1,
                  //   child: ListView.separated(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.grey[400],
                  //           child: Image.asset(
                  //             data["images"][index],
                  //             width: 50,
                  //             height: 50,
                  //           ),
                  //         ),
                  //         title: AutoSizeText(data["titles"][index]),
                  //         onTap: data["functions"][index],
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) {
                  //       return const Divider(color: Colors.black, thickness: 1);
                  //     },
                  //     itemCount: data["images"].length,
                  //   ),
                  // ),
                  FadeAnimation(
                      delay: 5,
                      child: const Divider(color: Colors.black, thickness: 1)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPanelItem {
  MyPanelItem({
    required this.headerValue,
    required this.bodyValue,
    this.isExpanded = false,
  });

  Widget headerValue;
  Widget bodyValue;
  bool isExpanded;
}
