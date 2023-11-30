// ignore_for_file: camel_case_types

class getAllTblUsersModel {
  String? userID;
  String? userPassword;
  String? fullname;
  String? userLevel;
  String? loc;
  String? email;
  bool? isAdmin;

  getAllTblUsersModel(
      {this.userID,
      this.userPassword,
      this.fullname,
      this.userLevel,
      this.loc,
      this.email,
      this.isAdmin});

  getAllTblUsersModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    userPassword = json['UserPassword'];
    fullname = json['Fullname'];
    userLevel = json['UserLevel'];
    loc = json['Loc'];
    email = json['Email'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['UserPassword'] = userPassword;
    data['Fullname'] = fullname;
    data['UserLevel'] = userLevel;
    data['Loc'] = loc;
    data['Email'] = email;
    data['isAdmin'] = isAdmin;
    return data;
  }
}
