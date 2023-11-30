import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppDialog {
  static BuildContext? dialogueContext;
  static Future<dynamic> showLottie(BuildContext context, String lottie) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        return Lottie.asset(
          lottie,
          width: 20,
          height: 20,
        );
      },
    );
  }

  static void closeDialog() {
    Navigator.pop(dialogueContext!);
  }
}
