// ignore_for_file: file_names

class GetAxaptaTableDataModel {
  String? tRANSFERID;
  num? tRANSFERSTATUS;
  String? iNVENTLOCATIONIDFROM;
  String? iNVENTLOCATIONIDTO;
  String? iTEMID;
  num? qTYTRANSFER;
  num? qTYRECEIVED;
  String? cREATEDDATETIME;
  String? gROUPID;

  GetAxaptaTableDataModel({
    this.tRANSFERID,
    this.tRANSFERSTATUS,
    this.iNVENTLOCATIONIDFROM,
    this.iNVENTLOCATIONIDTO,
    this.iTEMID,
    this.qTYTRANSFER,
    this.qTYRECEIVED,
    this.cREATEDDATETIME,
    this.gROUPID,
  });

  GetAxaptaTableDataModel.fromJson(Map<String, dynamic> json) {
    tRANSFERID = json['TRANSFERID'];
    tRANSFERSTATUS = json['TRANSFERSTATUS'];
    iNVENTLOCATIONIDFROM = json['INVENTLOCATIONIDFROM'];
    iNVENTLOCATIONIDTO = json['INVENTLOCATIONIDTO'];
    iTEMID = json['ITEMID'];
    qTYTRANSFER = json['QTYTRANSFER'];
    qTYRECEIVED = json['QTYRECEIVED'];
    cREATEDDATETIME = json['CREATEDDATETIME'];
    gROUPID = json['GROUPID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TRANSFERID'] = tRANSFERID;
    data['TRANSFERSTATUS'] = tRANSFERSTATUS;
    data['INVENTLOCATIONIDFROM'] = iNVENTLOCATIONIDFROM;
    data['INVENTLOCATIONIDTO'] = iNVENTLOCATIONIDTO;
    data['ITEMID'] = iTEMID;
    data['QTYTRANSFER'] = qTYTRANSFER;
    data['QTYRECEIVED'] = qTYRECEIVED;
    data['CREATEDDATETIME'] = cREATEDDATETIME;
    data['GROUPID'] = gROUPID;
    return data;
  }
}
