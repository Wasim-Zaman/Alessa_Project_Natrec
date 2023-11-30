// ignore_for_file: camel_case_types

class validateItemSerialNumberForJournalCountingOnlyCLDetsModel {
  String? message;
  List<Data>? allData;

  validateItemSerialNumberForJournalCountingOnlyCLDetsModel(
      {this.message, this.allData});

  validateItemSerialNumberForJournalCountingOnlyCLDetsModel.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      allData = <Data>[];
      json['data'].forEach((v) {
        allData!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (allData != null) {
      data['data'] = allData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  num? length;
  num? width;
  num? height;
  num? weight;
  String? qrCode;
  String? trxDate;

  Data({
    this.itemCode,
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
    this.trans,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.qrCode,
    this.trxDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    weight = json['Weight'];
    qrCode = json['QRCode'];
    trxDate = json['TrxDate'];
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
    data['Length'] = length;
    data['Width'] = width;
    data['Height'] = height;
    data['Weight'] = weight;
    data['QRCode'] = qrCode;
    data['TrxDate'] = trxDate;
    return data;
  }
}
