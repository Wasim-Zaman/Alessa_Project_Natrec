// ignore_for_file: camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class insertManyIntoMappedBarcodeNewController {
  static Future<void> getData(
    String itemCode,
    String itemDesc,
    String classification,
    String mainLocation,
    String itemSerialNo,
    String trxdate,
    String binLocation,
    String gtin,
    String remarks,
    String palletCode,
    String reference,
    String sid,
    String cid,
    String po,
    String length,
    String width,
    String height,
    String weight,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertManyIntoMappedBarcode";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    Map<String, dynamic> body = {
      "itemcode": itemCode,
      "itemdesc": itemDesc,
      "classification": classification,
      "mainlocation": mainLocation,
      "itemserialno": itemSerialNo,
      "trxdate": trxdate,
      "binlocation": binLocation,
      "gtin": gtin,
      "remarks": remarks,
      "palletcode": palletCode,
      "reference": reference,
      "sid": sid,
      "cid": cid,
      "po": po,
      "length": length,
      "width": width,
      "height": height,
      "weight": weight,
    };

    print("Body: ${jsonEncode({
          "records": [body]
        })}");

    try {
      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode({
            "records": [body]
          }));

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
