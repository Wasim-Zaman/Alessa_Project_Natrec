import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class UpdateShipmentController {
  static Future<String> updateShipment(
    List<String> SERIALNUM,
    String BIN,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    final records = SERIALNUM.map((serialNumber) {
      return {
        'SERIALNUM': serialNumber,
        'BIN': BIN,
      };
    }).toList();

    String url = '${Constants.baseUrl}updateShipmentRecievedDataCL';
    print("url : $url");

    print("Body: ${jsonEncode({"records": records})}");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Content-Type": "application/json"
    };

    try {
      var response = await http.put(uri,
          headers: headers, body: jsonEncode({"records": records}));

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        print("Response: ${response.body}");
        var data = json.decode(response.body);
        return data['message'];
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response: ${response.body}");

        var data = json.decode(response.body);
        return data['message'];
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
