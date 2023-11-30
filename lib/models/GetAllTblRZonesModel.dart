// ignore_for_file: file_names

class GetAllTblRZonesModel {
  num? tblRZONESID;
  String? rZONE;

  GetAllTblRZonesModel({this.tblRZONESID, this.rZONE});

  GetAllTblRZonesModel.fromJson(Map<String, dynamic> json) {
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
