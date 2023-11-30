// ignore_for_file: file_names, avoid_print

import 'package:alessa_v2/constants/app_lotties.dart';
import 'package:alessa_v2/controllers/Authentication/GetRolesAssignedToUserController.dart';
import 'package:alessa_v2/controllers/Authentication/LoginController.dart';
import 'package:alessa_v2/models/GetRolesAssignedToUserModel.dart';
import 'package:alessa_v2/screens/HomeScreen.dart';
import 'package:alessa_v2/utils/Constants.dart';
import 'package:alessa_v2/utils/app_dialog.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Animation/Fade_Animation.dart';

enum FormData {
  email,
  password,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    clearAllData();
  }

  List<GetRolesAssignedToUserModel> roles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeAnimation(
                  delay: 3,
                  child: Image.asset(
                    "assets/alessa.png",
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  child: Card(
                    elevation: 0,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              delay: 3,
                              child: const Text(
                                "  Username",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FadeAnimation(
                              delay: 3,
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: emailController,
                                  onTap: () {
                                    setState(() {
                                      selected = FormData.email;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeAnimation(
                              delay: 3,
                              child: const Text(
                                "  Your Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 5),
                            FadeAnimation(
                              delay: 3,
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: passwordController,
                                  onTap: () {
                                    setState(() {
                                      selected = FormData.password;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(
                                      Icons.lock_open_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: ispasswordev
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                      onPressed: () => setState(
                                          () => ispasswordev = !ispasswordev),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  obscureText: ispasswordev,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                              delay: 3,
                              child: Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 3,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    loginMethod();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 80),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0))),
                                  child: const Text(
                                    "Log-in",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessMethod() async {
    showDialog(
      context: context,
      builder: (context) {
        return Lottie.asset(
          'assets/animations/successfully.json',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        );
      },
    );
  }

  void loginMethod() {
    Constants.showLoadingDialog(context);
    LoginController.login(
            emailController.text.trim(), passwordController.text.trim())
        .then((value) {
      GetRolesAssignedToUserController.getRoles(emailController.text.trim())
          .then((vl) {
        setState(() {
          roles = vl;
        });
        print(roles[0].roleName);
        Navigator.of(context).pop();
        Get.offAll(() => HomeScreen(roles: vl));
        AppDialog.showLottie(context, AppLotties.loading);
        Future.delayed(const Duration(milliseconds: 2500), () {
          AppDialog.closeDialog();
        });
      }).onError((error, stackTrace) {
        roles = [];
        Navigator.of(context).pop();
      });
    }).onError(
      (error, stackTrace) {
        Navigator.of(context).pop();
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
