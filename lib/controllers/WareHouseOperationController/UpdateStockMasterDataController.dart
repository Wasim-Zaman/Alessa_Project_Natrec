// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class UpdateStockMasterDataController {
  static Future<void> insertShipmentData(
    String ITEMID,
    double Length,
    double Width,
    double Height,
    double Weight,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}updateStockMasterData";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var body = {
      "ITEMID": ITEMID,
      "Length": Length,
      "Width": Width,
      "Height": Height,
      "Weight": Weight,
    };

    print(jsonEncode(body));
    print("url: $url");

    try {
      var response =
          await http.put(uri, headers: headers, body: jsonEncode(body));

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
