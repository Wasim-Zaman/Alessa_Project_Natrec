import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/BinToBinInternalModel.dart';
import '../../utils/Constants.dart';

class GetItemNameByItemIdController {
  static Future<List<BinToBinInternalModel>> getName(String itemId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getOneMapBarcodeDataByItemCode";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "itemcode": itemId,
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body) as List;
        List<BinToBinInternalModel> allData =
            data.map((e) => BinToBinInternalModel.fromJson(e)).toList();
        return allData;
      } else {
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
