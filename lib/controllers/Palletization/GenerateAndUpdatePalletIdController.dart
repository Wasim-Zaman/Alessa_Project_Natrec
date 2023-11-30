import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class GenerateAndUpdatePalletIdController {
  static Future<List<dynamic>> generateAndUpdatePalletId(
    List<String> serialNoList,
    String dropdownValue,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    // convert list to one string
    String serialNoListString = serialNoList.join("&serialNumberList[]=");

    print(serialNoListString);

    String url =
        "${Constants.baseUrl}generateAndUpdatePalletIds?serialNumberList[]=$serialNoListString&binLocation=$dropdownValue";

    print(url);

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);

        print("Data: $data");
        String message = data["message"];
        var PalletCode = data["PalletCode"];
        return [message, PalletCode];
      } else {
        var data = json.decode(response.body);
        print("Data: $data");
        String message = data["message"];

        throw Exception(message);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
