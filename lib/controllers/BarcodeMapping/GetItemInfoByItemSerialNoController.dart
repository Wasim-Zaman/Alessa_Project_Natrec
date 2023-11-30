// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:alessa_v2/models/GetItemInfoByItemSerialNoModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class GetItemInfoByItemSerialNoController {
  static Future<List<GetItemInfoByItemSerialNoModel>> getData(
      String itemserialno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getItemInfoByItemSerialNo";
    print("url: $url");

    final uri = Uri.parse(url);
    final encodeSerial = Uri.encodeComponent(itemserialno);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "itemserialno": encodeSerial,
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body) as List;
        List<GetItemInfoByItemSerialNoModel> list = data
            .map((e) => GetItemInfoByItemSerialNoModel.fromJson(e))
            .toList();
        return list;
      } else if (response.statusCode == 404) {
        throw Exception(response.body);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
