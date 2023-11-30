import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ValidateZoneCodeModel.dart';
import '../../utils/Constants.dart';

class ValidateZoneCodeController {
  static Future<ValidateZoneCodeModel> validate(
    String palletCode,
    String zoneCode,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}validateZoneCode?ZONECODE=$zoneCode&PALLETCODE=$palletCode";

    final uri = Uri.parse(url);

    print("zoneCode: $zoneCode");
    print("palletCode: $palletCode");
    print(url);

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
        return ValidateZoneCodeModel.fromJson(data);
      } else {
        var data = json.decode(response.body);
        return ValidateZoneCodeModel.fromJson(data);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
