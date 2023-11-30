// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/DummyModel.dart';
import '../../utils/Constants.dart';

class GetShipmentDataController {
  static Future<List<DummyModel>> getShipmentData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getShipmentDataFromtShipmentReceiving?SHIPMENTID=$id";

    print("URL: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<DummyModel> shipmentData =
            data.map((e) => DummyModel.fromJson(e)).toList();
        return shipmentData;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var message = data['message'];
        throw Exception(message);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
