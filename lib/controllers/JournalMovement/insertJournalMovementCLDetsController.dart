import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/updateWmsJournalMovementClQtyScannedModel.dart';
import '../../utils/Constants.dart';

class InsertJournalMovementCLDetsController {
  static Future<void> getData(
    updateWmsJournalMovementClQtyScannedModel
        updateWmsJournalMovementClQtyScannedList,
    String serialNo,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertJournalMovementCLDets";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
    };

    var body = updateWmsJournalMovementClQtyScannedList;
    body.updatedRow!.iTEMSERIALNO = serialNo;

    var newBody = body.updatedRow;

    print("Body: ${newBody!.iTEMSERIALNO.toString()}");

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode([newBody]));

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
