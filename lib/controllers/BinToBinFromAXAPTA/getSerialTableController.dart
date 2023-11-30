// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/GetShipmentReceivedTableModel.dart';
import '../../utils/Constants.dart';

class GetSerialTableController {
  static Future<List<GetShipmentReceivedTableModel>> getAllTable(
    String serialNo,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getItemInfoByItemSerialNo";

    print("url: $url");

    final uri = Uri.parse(url);
    final encodeSerial = Uri.encodeComponent(serialNo);

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
        List<GetShipmentReceivedTableModel> shipmentData =
            data.map((e) => GetShipmentReceivedTableModel.fromJson(e)).toList();
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
