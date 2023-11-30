import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/GetShipmentReceivedModel.dart';
import '../../utils/Constants.dart';

class GetShipmentReceivedController {
  static Future<List<GetShipmentReceivedModel>> getShipmentReceived(
      String palletCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getShipmentRecievedCLDataByPalletCode?PalletCode=$palletCode";

    print("URL: $url");
    print("palletCode: $palletCode");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<GetShipmentReceivedModel> getAllAssetByLocationList =
            data.map((e) => GetShipmentReceivedModel.fromJson(e)).toList();
        return getAllAssetByLocationList;
      } else {
        throw Exception("Failed to get data");
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
