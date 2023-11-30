// ignore_for_file: file_names, depend_on_referenced_packages, avoid_print

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class InsertManyIntoMappedBarcodeController {
  static Future<void> getData(
    String itemCode,
    String name,
    String newBarcodeValue,
    String selectedValue,
    String mainLocation,
    String config,
    String user,
    String gtin,
    String remarks,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertManyIntoMappedBarcode";
    print("url: $url");
    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    try {
      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode({
            "records": [
              {
                "mainlocation": mainLocation,
                "classification": config,
                "itemdesc": name,
                // "itemcode": itemCode,
                "itemcode": "",
                "itemserialno": newBarcodeValue,
                "mapdate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                "palletcode": "",
                "binlocation": selectedValue,
                "user": user,
                "gtin": gtin,
                "remarks": remarks,
                "reference": "",
                "sid": "",
                "cid": "",
                "po": ""
              }
            ]
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
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
