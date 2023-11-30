// ignore_for_file: file_names

class GetAllTableZoneModel {
  num? tblRZONESID;
  String? rZONE;

  GetAllTableZoneModel({this.tblRZONESID, this.rZONE});

  GetAllTableZoneModel.fromJson(Map<String, dynamic> json) {
    tblRZONESID = json['tbl_RZONESID'];
    rZONE = json['RZONE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tbl_RZONESID'] = tblRZONESID;
    data['RZONE'] = rZONE;
    return data;
  }
}
