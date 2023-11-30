// ignore_for_file: camel_case_types, depend_on_referenced_packages, avoid_print

import 'package:alessa_v2/models/getWmsReturnSalesOrderByReturnItemNum2Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class insertManyIntoMappedBarcodeController2 {
  static Future<void> getData(
    String binLocation,
    List<getWmsReturnSalesOrderByReturnItemNum2Model> data,
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

    List<Map<String, dynamic>> body = data.map(
      (e) {
        return {
          "itemcode": e.iTEMID ?? '',
          "itemdesc": e.nAME ?? '',
          "classification": e.cONFIGID ?? '',
          "mainlocation": binLocation.substring(0, 2),
          "intcode": '',
          "itemserialno": e.itemSerialNo ?? '',
          "user": '',
          "binlocation": binLocation,
          "gtin": "",
          "remarks": e.rETURNITEMNUM,
          "palletcode": "",
          "reference": "",
          "sid": "",
          "cid": "",
          "po": ""
        };
      },
    ).toList();

    print("body: ${jsonEncode({"records": body})}");

    try {
      var response = await http.post(uri,
          headers: headers, body: jsonEncode({"records": body}));

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
