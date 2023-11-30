// ignore_for_file: file_names

class GetRolesAssignedToUserModel {
  int? roleId;
  String? roleName;
  String? userID;

  GetRolesAssignedToUserModel({this.roleId, this.roleName, this.userID});

  GetRolesAssignedToUserModel.fromJson(Map<String, dynamic> json) {
    roleId = json['RoleId'];
    roleName = json['RoleName'];
    userID = json['UserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RoleId'] = roleId;
    data['RoleName'] = roleName;
    data['UserID'] = userID;
    return data;
  }
}
