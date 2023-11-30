import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/BinToBinJournalTableModel.dart';
import '../../utils/Constants.dart';

class GetTableByPalletController {
  static Future<List<BinToBinJournalTableModel>> getAllTable(
    String palletId,
    String binLocation,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}getMappedBarcodedsByPalletCodeAndBinLocation";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "palletcode": palletId,
      "binlocation": binLocation,
    };

    print("headers: $headers");

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<BinToBinJournalTableModel> shipmentData =
            data.map((e) => BinToBinJournalTableModel.fromJson(e)).toList();
        return shipmentData;
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
