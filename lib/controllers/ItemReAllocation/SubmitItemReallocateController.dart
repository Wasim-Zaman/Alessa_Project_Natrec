import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/GetItemInfoByPalletCodeModel.dart';
import '../../utils/Constants.dart';

class SubmitItemReallocateControllerimport {
  static Future<void> postData(
    List<GetItemInfoByPalletCodeModel> getItemInfoByPalletCodeModel,
    String availablePallet,
    String serialnum,
    String selectType,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}manageItemsReallocation";
    print("url: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    final data = getItemInfoByPalletCodeModel.map(
      (e) {
        return {
          ...e.toJson(),
          "serialNumber": serialnum,
          "selectionType": selectType,
        };
      },
    );

    print(jsonEncode([...data]));

    final body = {
      "availablePallet": availablePallet,
      "serialNumber": serialnum,
      "selectionType": selectType
    };

    try {
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(body));
      // await http.post(uri, headers: headers, body: jsonEncode([...data]));

      if (response.statusCode == 200) {
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
