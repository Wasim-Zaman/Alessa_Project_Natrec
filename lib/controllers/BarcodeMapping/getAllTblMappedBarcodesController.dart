// ignore_for_file: camel_case_types, avoid_print, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/getInventTableWMSDataByItemIdOrItemNameModel.dart';
import '../../utils/Constants.dart';

class getAllTblMappedBarcodesController {
  static Future<List<getInventTableWMSDataByItemIdOrItemNameModel>> getData(
      String searchText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getInventTableWMSDataByItemIdOrItemName";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "serachtext": searchText,
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<getInventTableWMSDataByItemIdOrItemNameModel> shipmentData = data
            .map(
                (e) => getInventTableWMSDataByItemIdOrItemNameModel.fromJson(e))
            .toList();
        return shipmentData;
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
