// ignore_for_file: camel_case_types

class getInventTableWMSDataByItemIdOrItemNameModel {
  String? iTEMID;
  String? iTEMNAME;
  String? iTEMGROUPID;
  String? gROUPNAME;

  getInventTableWMSDataByItemIdOrItemNameModel(
      {this.iTEMID, this.iTEMNAME, this.iTEMGROUPID, this.gROUPNAME});

  getInventTableWMSDataByItemIdOrItemNameModel.fromJson(
      Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    iTEMGROUPID = json['ITEMGROUPID'];
    gROUPNAME = json['GROUPNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['ITEMGROUPID'] = iTEMGROUPID;
    data['GROUPNAME'] = gROUPNAME;
    return data;
  }
}
