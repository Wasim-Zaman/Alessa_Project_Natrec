// ignore_for_file: non_constant_identifier_names, camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:alessa_v2/models/GetItemInfoByItemSerialNoModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/updateWmsJournalMovementClQtyScannedModel.dart';
import '../../utils/Constants.dart';

class UpdateMappedBarcodesByPalletCodeController {
  static Future<updateWmsJournalMovementClQtyScannedModel> getData(
    List<GetItemInfoByItemSerialNoModel> data,
    String binLocation,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}updateMappedBarcodesByPalletCode";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    var rec = data.map((e) {
      return {"newBinLocation": binLocation, "palletCode": e.palletCode};
    }).toList();

    final body = jsonEncode({"records": rec});

    print("body: $body");

    try {
      var response = await http.put(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body);
        updateWmsJournalMovementClQtyScannedModel shipmentData =
            updateWmsJournalMovementClQtyScannedModel.fromJson(data);
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
