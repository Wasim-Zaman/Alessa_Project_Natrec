import '../../models/GetAlltblBinLocationsModel.dart';
import '../../utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetAlltblBinLocationsController {
  static Future<List<GetAlltblBinLocationsModel>>
      getShipmentPalletizing() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getAlltblPalletMaster";

    print("url: $url");

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
        List<GetAlltblBinLocationsModel> shipmentPalletizing =
            data.map((e) => GetAlltblBinLocationsModel.fromJson(e)).toList();
        return shipmentPalletizing;
      } else {
        print("Status Code: ${response.statusCode}");
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
