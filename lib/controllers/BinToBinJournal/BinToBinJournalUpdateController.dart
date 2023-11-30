import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class BinToBinJournalUpdateController {
  static Future<void> updateBin(
    String oldBin,
    String newBin,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = '${Constants.baseUrl}updateTblMappedBarcodeBinLocation';

    print("url : $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "oldbinlocation": oldBin,
      "newbinlocation": newBin,
    };

    try {
      var response = await http.put(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
      } else {
        print("Status Code: ${response.statusCode}");
        throw Exception("Failded to update bin");
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
