// ignore_for_file: camel_case_types

class getMappedBarcodedsByItemCodeAndBinLocationModel {
  String? itemCode;
  String? itemDesc;
  String? gTIN;
  String? remarks;
  String? user;
  String? classification;
  String? mainLocation;
  String? binLocation;
  String? intCode;
  String? itemSerialNo;
  String? mapDate;
  String? palletCode;
  String? reference;
  String? sID;
  String? cID;
  String? pO;
  num? trans;

  getMappedBarcodedsByItemCodeAndBinLocationModel(
      {this.itemCode,
      this.itemDesc,
      this.gTIN,
      this.remarks,
      this.user,
      this.classification,
      this.mainLocation,
      this.binLocation,
      this.intCode,
      this.itemSerialNo,
      this.mapDate,
      this.palletCode,
      this.reference,
      this.sID,
      this.cID,
      this.pO,
      this.trans});

  getMappedBarcodedsByItemCodeAndBinLocationModel.fromJson(
      Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemDesc = json['ItemDesc'];
    gTIN = json['GTIN'];
    remarks = json['Remarks'];
    user = json['User'];
    classification = json['Classification'];
    mainLocation = json['MainLocation'];
    binLocation = json['BinLocation'];
    intCode = json['IntCode'];
    itemSerialNo = json['ItemSerialNo'];
    mapDate = json['MapDate'];
    palletCode = json['PalletCode'];
    reference = json['Reference'];
    sID = json['SID'];
    cID = json['CID'];
    pO = json['PO'];
    trans = json['Trans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ItemCode'] = itemCode;
    data['ItemDesc'] = itemDesc;
    data['GTIN'] = gTIN;
    data['Remarks'] = remarks;
    data['User'] = user;
    data['Classification'] = classification;
    data['MainLocation'] = mainLocation;
    data['BinLocation'] = binLocation;
    data['IntCode'] = intCode;
    data['ItemSerialNo'] = itemSerialNo;
    data['MapDate'] = mapDate;
    data['PalletCode'] = palletCode;
    data['Reference'] = reference;
    data['SID'] = sID;
    data['CID'] = cID;
    data['PO'] = pO;
    data['Trans'] = trans;
    return data;
  }
}
