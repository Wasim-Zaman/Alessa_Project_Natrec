// ignore_for_file: camel_case_types, depend_on_referenced_packages, non_constant_identifier_names, avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class insertIntoWmsJournalCountingOnlyCLDetsController {
  static Future<void> getData(
    Map<String, dynamic> ITEM,
    String CONFIGID,
    String BINLOCATION,
    String QTYSCANNED,
    String ITEMSERIALNO,
    String ITEMID,
    String ITEMNAME,
    String eventName,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertIntoWmsJournalCountingOnlyCLDets";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    final data = {
      ...ITEM,
      "CONFIGID": CONFIGID,
      "BINLOCATION": BINLOCATION,
      "QTYSCANNED": QTYSCANNED,
      "ITEMSERIALNO": ITEMSERIALNO,
      "ITEMID": ITEMID,
      "ITEMNAME": ITEMNAME,
      "eventName": eventName,
    };

    // final data = ITEM.map(
    //   (e) {
    //     return {
    //       ...e.toJson(),
    //       "CONFIGID": CONFIGID,
    //       "BINLOCATION": BINLOCATION,
    //       "QTYSCANNED": QTYSCANNED,
    //       "ITEMSERIALNO": ITEMSERIALNO,
    //       "ITEMID": ITEMID,
    //       "ITEMNAME": ITEMNAME,
    //       "eventName": eventName,
    //     };
    //   },
    // );

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode([data]));

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
