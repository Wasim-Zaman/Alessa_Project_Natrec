// ignore_for_file: avoid_print, depend_on_referenced_packages

import '../../models/getDispatchingTableModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class GetDispatchingTableController {
  static Future<List<getDispatchingTableModel>> getShipmentReceived(
      String packingSlipId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getPackingSlipTableByPackingSlipId?packingSlipId=$packingSlipId";

    print("URL: $url");
    print("palletCode: $packingSlipId");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<getDispatchingTableModel> getAllAssetByLocationList =
            data.map((e) => getDispatchingTableModel.fromJson(e)).toList();
        return getAllAssetByLocationList;
      } else {
        var data = json.decode(response.body);
        String msg = data['message'].toString().replaceAll("Exception", "");
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
