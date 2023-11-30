// ignore_for_file: file_names

class LoginModel {
  String? message;
  User? user;
  String? token;

  LoginModel({this.message, this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? userID;
  String? fullname;
  String? userLevel;
  String? loc;

  User({this.userID, this.fullname, this.userLevel, this.loc});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    fullname = json['Fullname'];
    userLevel = json['UserLevel'];
    loc = json['Loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['Fullname'] = fullname;
    data['UserLevel'] = userLevel;
    data['Loc'] = loc;
    return data;
  }
}
