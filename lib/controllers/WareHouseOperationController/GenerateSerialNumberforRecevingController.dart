// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class GenerateSerialNumberforRecevingController {
  static Future<String> generateSerialNo(String itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}generateSerialNumberforReceving";

    final body = {
      "ITEMID": itemId,
    };

    print("URL: $url");
    print("Body: $body");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        var data = json.decode(response.body);
        var serialNo = data['SERIALNO'];
        return serialNo;
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
