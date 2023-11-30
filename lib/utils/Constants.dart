// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constants {
  // static String baseUrl = 'http://gs1ksa.org:3005/api/';
  // static String host = 'gs1ksa.org';

  static String baseUrl = 'http://37.224.47.116:7474/api/';
  static String host = '37.224.47.116:7474';

  static Future<dynamic> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SpinKitFadingCircle(
            duration: Duration(milliseconds: 1200),
            color: Colors.orange,
            size: 50.0,
          ),
        );
      },
    );
  }
}
