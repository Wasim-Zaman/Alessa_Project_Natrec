// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class GetAllTblShipmentReceivedCLController {
  static Future<int> getAllTableZone(
    String cONTAINERID,
    String sHIPMENTID,
    String iTEMID,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    print("CONTAINERID: $cONTAINERID");
    print("SHIPMENTID: $sHIPMENTID");
    print("ITEMID: $iTEMID");

    String url =
        "${Constants.baseUrl}getRemainingQtyFromShipmentCounter?CONTAINERID=$cONTAINERID&SHIPMENTID=$sHIPMENTID&ITEMID=$iTEMID";

    print("URL: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        var itemCount = data['itemCount'];
        return itemCount;
      } else {
        print("Status Code: ${response.statusCode}");
        var itemCount = 0;
        return itemCount;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
