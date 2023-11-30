// ignore_for_file: camel_case_types, avoid_print, depend_on_referenced_packages

import 'package:alessa_v2/models/getMappedBarcodedsByItemCodeAndBinLocationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class updateByPalletController {
  static Future<void> updateBin(
    List<getMappedBarcodedsByItemCodeAndBinLocationModel> oldBin,
    String newBin,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        '${Constants.baseUrl}updateMappedBarcodesBinLocationByPalletCode';

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Content-Type": "application/json",
    };

    var body = oldBin.map((element) {
      return {
        "oldBinLocation": element.binLocation,
        "newBinLocation": newBin,
        "palletCode": element.palletCode
      };
    });

    try {
      var response = await http.put(uri,
          headers: headers,
          body: jsonEncode({
            "records": [...body]
          }));

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
      } else {
        print("Status Code: ${response.statusCode}");
        throw Exception("Failded to update bin");
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
