// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages, avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class incrementQTYSCANNEDInJournalCountingOnlyCLController {
  static Future<int> getData(
    String TRXUSERIDASSIGNED,
    String TRXDATETIME,
    String ITEMID,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}incrementQTYSCANNEDInJournalCountingOnlyCL";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    final body = {
      "TRXUSERIDASSIGNED": TRXUSERIDASSIGNED,
      "ITEMID": ITEMID,
      "TRXDATETIME": TRXDATETIME
    };

    print(jsonEncode(body));

    try {
      var response =
          await http.put(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
        var data = jsonDecode(response.body);
        var msg = data['data']["QTYSCANNED"];
        return msg;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print("Hello");
      print(e);
      throw Exception(e);
    }
  }
}
