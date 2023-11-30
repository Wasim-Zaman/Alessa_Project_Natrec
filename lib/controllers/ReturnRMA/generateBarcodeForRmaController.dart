// generateBarcodeForRma

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class GenerateBarcodeForRmaController {
  static Future<String> getData(
    String RETURNITEMNUM,
    String ITEMID,
    String MODELNO,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}generateBarcodeForRma";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    var body = {
      "RETURNITEMNUM": RETURNITEMNUM,
      "ITEMID": ITEMID,
      "MODELNO": MODELNO
    };

    print("Body: $body");

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['RMASERIALNO'];
        return msg;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['RMASERIALNO'];
        return msg;
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
