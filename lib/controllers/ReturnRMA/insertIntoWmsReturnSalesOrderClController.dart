// ignore_for_file: avoid_print, camel_case_types, depend_on_referenced_packages

import 'package:alessa_v2/models/getWmsReturnSalesOrderByReturnItemNum2Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class insertIntoWmsReturnSalesOrderClController {
  static Future<void> getData(
    List<getWmsReturnSalesOrderByReturnItemNum2Model> table,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertIntoWmsReturnSalesOrderCl";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    var body = table.map((e) {
      return {
        ...e.toJson(),
        "ITEMSERIALNO": e.itemSerialNo,
      };
    }).toList();

    print("body: ${jsonEncode([body])}");

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

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
