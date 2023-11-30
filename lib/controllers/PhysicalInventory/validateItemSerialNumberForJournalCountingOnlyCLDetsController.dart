// ignore_for_file: camel_case_types, avoid_print, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/validateItemSerialNumberForJournalCountingOnlyCLDetsModel.dart';
import '../../utils/Constants.dart';

class validateItemSerialNumberForJournalCountingOnlyCLDetsController {
  static Future<validateItemSerialNumberForJournalCountingOnlyCLDetsModel>
      getData(String itemSerialNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}validateItemSerialNumberForJournalCountingOnlyCLDets";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    final body = {"itemSerialNo": itemSerialNo};

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
        var data = jsonDecode(response.body);
        validateItemSerialNumberForJournalCountingOnlyCLDetsModel model =
            validateItemSerialNumberForJournalCountingOnlyCLDetsModel
                .fromJson(data);
        return model;
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
