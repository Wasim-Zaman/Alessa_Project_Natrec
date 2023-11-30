// ignore_for_file: avoid_print, camel_case_types, depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class insertIntoMappedBarcodeOrUpdateBySerialNoController {
  static Future<void> insert(
    String itemId,
    String itemName,
    String reference,
    String gtin,
    String binlocation,
    String itemserialno,
    String cid,
    String qrCode,
    double length,
    double width,
    double height,
    double weight,
    String manufacturingDate,
    String mainLocation,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url =
        "${Constants.baseUrl}insertIntoMappedBarcodeOrUpdateBySerialNo";

    print("URL: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final body = {
      "itemcode": itemId,
      "itemdesc": itemName,
      "gtin": gtin,
      "binlocation": binlocation,
      "itemserialno": itemserialno,
      "reference": reference,
      "classification": cid,
      "qrcode": qrCode,
      "length": length,
      "width": width,
      "height": height,
      "weight": weight,
      "trxdate": manufacturingDate,
      "mainlocation": mainLocation
    };

    print("Body: ${jsonEncode(body)}");

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        print("Data: $data");
      } else {
        print("Status Code: ${response.statusCode}");
        throw Exception('Failed to insert data');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
