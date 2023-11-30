// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:alessa_v2/models/GetmapBarcodeDataByBinLocationModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class GetmapBarcodeDataByMultipleBinLocations {
  static Future<List<GetmapBarcodeDataByBinLocationModel>> postData(
      List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getmapBarcodeDataByMultipleBinLocations";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode({
            "binLocations": [...list]
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body) as List;
        List<GetmapBarcodeDataByBinLocationModel> allData = data
            .map((e) => GetmapBarcodeDataByBinLocationModel.fromJson(e))
            .toList();
        return allData;
      } else {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        var msg = data["message"];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
