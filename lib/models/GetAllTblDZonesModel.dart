// ignore_for_file: file_names

class GetAllTblDZonesModel {
  num? tblDZONESID;
  String? dZONE;

  GetAllTblDZonesModel({this.tblDZONESID, this.dZONE});

  GetAllTblDZonesModel.fromJson(Map<String, dynamic> json) {
    tblDZONESID = json['tbl_DZONESID'];
    dZONE = json['DZONE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tbl_DZONESID'] = tblDZONESID;
    data['DZONE'] = dZONE;
    return data;
  }
}
