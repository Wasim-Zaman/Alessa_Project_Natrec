import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class UpdateJournalController {
  static Future<void> updateJournal(
    String oldbinlocation,
    String newbinlocation,
    String selectiontype,
    String selectiontypevalue,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}updateTblMappedBarcodeBinLocationWithSelectionType";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "oldbinlocation": oldbinlocation,
      "newbinlocation": newbinlocation,
      "selectiontype": selectiontype,
      "selectiontypevalue": selectiontypevalue,
    };

    print("headers: $headers");

    try {
      var response = await http.put(uri, headers: headers);

      if (response.statusCode == 200) {
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
