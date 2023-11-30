// ignore_for_file: file_names

class GetTblStockMasterByItemIdModel {
  String? iTEMID;
  String? iTEMNAME;
  String? iTEMGROUPID;
  String? gROUPNAME;
  num? width;
  num? height;
  num? length;
  num? weight;

  GetTblStockMasterByItemIdModel(
      {this.iTEMID,
      this.iTEMNAME,
      this.iTEMGROUPID,
      this.gROUPNAME,
      this.width,
      this.height,
      this.length,
      this.weight});

  GetTblStockMasterByItemIdModel.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    iTEMGROUPID = json['ITEMGROUPID'];
    gROUPNAME = json['GROUPNAME'];
    width = json['Width'];
    height = json['Height'];
    length = json['Length'];
    weight = json['Weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['ITEMGROUPID'] = iTEMGROUPID;
    data['GROUPNAME'] = gROUPNAME;
    data['Width'] = width;
    data['Height'] = height;
    data['Length'] = length;
    data['Weight'] = weight;
    return data;
  }
}
