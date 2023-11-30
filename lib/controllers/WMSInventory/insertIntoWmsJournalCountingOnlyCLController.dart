// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:alessa_v2/models/GetmapBarcodeDataByBinLocationModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class insertIntoWmsJournalCountingOnlyCLController {
  static Future<void> postData(
    List<GetmapBarcodeDataByBinLocationModel> mapData,
    String TRXUSERIDASSIGNED,
    String INVENTORYBY,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertIntoWmsJournalCountingOnlyCL";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    final data = mapData.map(
      (e) {
        return {
          "TRXUSERIDASSIGNED": TRXUSERIDASSIGNED,
          "INVENTORYBY": INVENTORYBY,
          "BINLOCATION": e.binLocation,
          "ITEMID": e.itemCode,
          "ITEMNAME": e.itemDesc,
          "CLASSFICATION": e.classification
        };
      },
    );

    print(jsonEncode([...data]));

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode([...data]));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
      } else {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        var msg = data["message"];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
