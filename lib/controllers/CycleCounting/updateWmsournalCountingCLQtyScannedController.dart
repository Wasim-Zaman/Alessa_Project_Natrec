// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/updateWmsJournalMovementClQtyScannedModel.dart';
import '../../utils/Constants.dart';

class updateWmsournalCountingCLQtyScannedController {
  static Future<updateWmsJournalMovementClQtyScannedModel> getData(
    String ITEMID,
    String JOURNALID,
    String TRXUSERIDASSIGNED,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}updateWmsJournalCountingCLQtyScanned";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    final body = {
      "ITEMID": ITEMID,
      "JOURNALID": JOURNALID,
      "TRXUSERIDASSIGNED": TRXUSERIDASSIGNED
    };

    try {
      var response =
          await http.put(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        updateWmsJournalMovementClQtyScannedModel shipmentData =
            updateWmsJournalMovementClQtyScannedModel.fromJson(data);
        return shipmentData;
      } else {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        print("body: $data");
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
