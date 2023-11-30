// ignore_for_file: avoid_print, depend_on_referenced_packages

import '../../models/GetItemInfoByItemSerialNoModel.dart';
import '../../utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PalletIdInquiryController {
  static Future<List<GetItemInfoByItemSerialNoModel>> getShipmentPalletizing(
      String serialNo) async {
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
        List<GetItemInfoByItemSerialNoModel> shipmentPalletizing = data
            .map((e) => GetItemInfoByItemSerialNoModel.fromJson(e))
            .toList();
        return shipmentPalletizing;
      } else {
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
