// ignore_for_file: depend_on_referenced_packages, file_names, avoid_print

import 'package:alessa_v2/models/GetRolesAssignedToUserModel.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/Constants.dart';

class GetRolesAssignedToUserController {
  static Future<List<GetRolesAssignedToUserModel>> getRoles(
      String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}getRolesAssignedToUser?userId=$userId";

    print("URL: $url");

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": "Bearer $token",
      "Host": Constants.host,
      "Content-Type": "application/json",
    };

    print("Headers: $headers");

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("****Status Code****: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<GetRolesAssignedToUserModel> loginModel =
            data.map((e) => GetRolesAssignedToUserModel.fromJson(e)).toList();
        return loginModel;
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
