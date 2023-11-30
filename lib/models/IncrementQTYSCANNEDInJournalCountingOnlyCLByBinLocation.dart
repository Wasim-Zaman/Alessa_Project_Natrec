// ignore_for_file: file_names

class IncrementQTYSCANNEDInJournalCountingOnlyCLByBinLocationModel {
  String? message;
  Data? data;

  IncrementQTYSCANNEDInJournalCountingOnlyCLByBinLocationModel(
      {this.message, this.data});

  IncrementQTYSCANNEDInJournalCountingOnlyCLByBinLocationModel.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? iTEMID;
  String? iTEMNAME;
  String? iTEMGROUPID;
  String? gROUPNAME;
  String? iNVENTORYBY;
  String? tRXDATETIME;
  String? tRXUSERIDASSIGNED;
  String? tRXUSERIDASSIGNEDBY;
  num? qTYSCANNED;
  num? qTYDIFFERENCE;
  num? qTYONHAND;
  num? jOURNALID;
  String? bINLOCATION;
  num? cLASSFICATION;

  Data(
      {this.iTEMID,
      this.iTEMNAME,
      this.iTEMGROUPID,
      this.gROUPNAME,
      this.iNVENTORYBY,
      this.tRXDATETIME,
      this.tRXUSERIDASSIGNED,
      this.tRXUSERIDASSIGNEDBY,
      this.qTYSCANNED,
      this.qTYDIFFERENCE,
      this.qTYONHAND,
      this.jOURNALID,
      this.bINLOCATION,
      this.cLASSFICATION});

  Data.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    iTEMGROUPID = json['ITEMGROUPID'];
    gROUPNAME = json['GROUPNAME'];
    iNVENTORYBY = json['INVENTORYBY'];
    tRXDATETIME = json['TRXDATETIME'];
    tRXUSERIDASSIGNED = json['TRXUSERIDASSIGNED'];
    tRXUSERIDASSIGNEDBY = json['TRXUSERIDASSIGNEDBY'];
    qTYSCANNED = json['QTYSCANNED'];
    qTYDIFFERENCE = json['QTYDIFFERENCE'];
    qTYONHAND = json['QTYONHAND'];
    jOURNALID = json['JOURNALID'];
    bINLOCATION = json['BINLOCATION'];
    cLASSFICATION = json['CLASSFICATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['ITEMGROUPID'] = iTEMGROUPID;
    data['GROUPNAME'] = gROUPNAME;
    data['INVENTORYBY'] = iNVENTORYBY;
    data['TRXDATETIME'] = tRXDATETIME;
    data['TRXUSERIDASSIGNED'] = tRXUSERIDASSIGNED;
    data['TRXUSERIDASSIGNEDBY'] = tRXUSERIDASSIGNEDBY;
    data['QTYSCANNED'] = qTYSCANNED;
    data['QTYDIFFERENCE'] = qTYDIFFERENCE;
    data['QTYONHAND'] = qTYONHAND;
    data['JOURNALID'] = jOURNALID;
    data['BINLOCATION'] = bINLOCATION;
    data['CLASSFICATION'] = cLASSFICATION;
    return data;
  }
}
