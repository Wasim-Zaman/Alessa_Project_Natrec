// ignore_for_file: file_names

class DummyModel {
  String? pURCHID;
  String? cREATEDDATETIME;
  String? sHIPMENTID;
  num? sHIPMENTSTATUS;
  String? cONTAINERID;
  String? iTEMID;
  num? qTY;

  DummyModel(
      {this.pURCHID,
      this.cREATEDDATETIME,
      this.sHIPMENTID,
      this.sHIPMENTSTATUS,
      this.cONTAINERID,
      this.iTEMID,
      this.qTY});

  DummyModel.fromJson(Map<String, dynamic> json) {
    pURCHID = json['PURCHID'];
    cREATEDDATETIME = json['CREATEDDATETIME'];
    sHIPMENTID = json['SHIPMENTID'];
    sHIPMENTSTATUS = json['SHIPMENTSTATUS'];
    cONTAINERID = json['CONTAINERID'];
    iTEMID = json['ITEMID'];
    qTY = json['QTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PURCHID'] = pURCHID;
    data['CREATEDDATETIME'] = cREATEDDATETIME;
    data['SHIPMENTID'] = sHIPMENTID;
    data['SHIPMENTSTATUS'] = sHIPMENTSTATUS;
    data['CONTAINERID'] = cONTAINERID;
    data['ITEMID'] = iTEMID;
    data['QTY'] = qTY;
    return data;
  }
}
