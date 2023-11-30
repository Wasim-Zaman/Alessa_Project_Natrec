// ignore_for_file: camel_case_types, avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class GetWmsReturnSalesOrderClCountByItemIdAndReturnItemNumAndSalesIdController {
  static Future<int> getData(
    String itemId,
    String returnItemNum,
    String salesId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getWmsReturnSalesOrderClCountByItemIdAndReturnItemNumAndSalesId";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var body = {
      "ITEMID": itemId,
      "RETURNITEMNUM": returnItemNum,
      "SALESID": salesId,
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var returnItemsCount = data["returnItemsCount"];
        return returnItemsCount;
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
