// ignore_for_file: depend_on_referenced_packages, avoid_print

import '../../models/LoginModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class LoginController {
  static Future<LoginModel> login(
    String userName,
    String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        "${Constants.baseUrl}login?UserID=$userName&UserPassword=$password";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Host": Constants.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var loginModel = LoginModel.fromJson(data);

        prefs.setString("token", loginModel.token.toString());
        prefs.setString("userId", loginModel.user!.userID.toString());
        prefs.setString("fullName", loginModel.user!.fullname.toString());
        prefs.setString("userLevel", loginModel.user!.userLevel.toString());
        prefs.setString("userLocation", loginModel.user!.loc.toString());

        return loginModel;
      } else {
        throw Exception("Bad Credentials");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
