// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:alessa_v2/models/GetmapBarcodeDataByBinLocationModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class ValidateItemSerialNumberForJournalMovementCLDetsController {
  static Future<GetmapBarcodeDataByBinLocationModel> getData(
    String itemSerialNo,
    String endPoint,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = Constants.baseUrl + endPoint;
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    final body = {"itemSerialNo": itemSerialNo};

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        var msg = data['data'][0];
        return GetmapBarcodeDataByBinLocationModel.fromJson(msg);
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
