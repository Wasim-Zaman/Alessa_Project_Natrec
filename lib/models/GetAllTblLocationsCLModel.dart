// ignore_for_file: file_names

class GetAllTblLocationsCLModel {
  num? lOCATIONSHFID;
  String? mAIN;
  String? wAREHOUSE;
  String? zONE;
  String? bIN;
  String? zONECODE;
  String? zONENAME;

  GetAllTblLocationsCLModel(
      {this.lOCATIONSHFID,
      this.mAIN,
      this.wAREHOUSE,
      this.zONE,
      this.bIN,
      this.zONECODE,
      this.zONENAME});

  GetAllTblLocationsCLModel.fromJson(Map<String, dynamic> json) {
    lOCATIONSHFID = json['LOCATIONS_HFID'];
    mAIN = json['MAIN'];
    wAREHOUSE = json['WAREHOUSE'];
    zONE = json['ZONE'];
    bIN = json['BIN'];
    zONECODE = json['ZONE_CODE'];
    zONENAME = json['ZONE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LOCATIONS_HFID'] = lOCATIONSHFID;
    data['MAIN'] = mAIN;
    data['WAREHOUSE'] = wAREHOUSE;
    data['ZONE'] = zONE;
    data['BIN'] = bIN;
    data['ZONE_CODE'] = zONECODE;
    data['ZONE_NAME'] = zONENAME;
    return data;
  }
}
