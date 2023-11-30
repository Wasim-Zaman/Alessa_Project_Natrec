// ignore_for_file: camel_case_types

class getWmsJournalMovementClByAssignedToUserIdModel {
  String? iTEMID;
  String? iTEMNAME;
  num? qTY;
  String? lEDGERACCOUNTIDOFFSET;
  String? jOURNALID;
  String? tRANSDATE;
  String? iNVENTSITEID;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  String? wMSLOCATIONID;
  String? tRXDATETIME;
  String? tRXUSERIDASSIGNED;
  String? tRXUSERIDASSIGNEDBY;
  num? iTEMSERIALNO;
  num? qTYSCANNED;
  num? qTYDIFFERENCE;

  getWmsJournalMovementClByAssignedToUserIdModel(
      {this.iTEMID,
      this.iTEMNAME,
      this.qTY,
      this.lEDGERACCOUNTIDOFFSET,
      this.jOURNALID,
      this.tRANSDATE,
      this.iNVENTSITEID,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.wMSLOCATIONID,
      this.tRXDATETIME,
      this.tRXUSERIDASSIGNED,
      this.tRXUSERIDASSIGNEDBY,
      this.iTEMSERIALNO,
      this.qTYSCANNED,
      this.qTYDIFFERENCE});

  getWmsJournalMovementClByAssignedToUserIdModel.fromJson(
      Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    qTY = json['QTY'];
    lEDGERACCOUNTIDOFFSET = json['LEDGERACCOUNTIDOFFSET'];
    jOURNALID = json['JOURNALID'];
    tRANSDATE = json['TRANSDATE'];
    iNVENTSITEID = json['INVENTSITEID'];
    iNVENTLOCATIONID = json['INVENTLOCATIONID'];
    cONFIGID = json['CONFIGID'];
    wMSLOCATIONID = json['WMSLOCATIONID'];
    tRXDATETIME = json['TRXDATETIME'];
    tRXUSERIDASSIGNED = json['TRXUSERIDASSIGNED'];
    tRXUSERIDASSIGNEDBY = json['TRXUSERIDASSIGNEDBY'];
    iTEMSERIALNO = json['ITEMSERIALNO'];
    qTYSCANNED = json['QTYSCANNED'];
    qTYDIFFERENCE = json['QTYDIFFERENCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMID'] = this.iTEMID;
    data['ITEMNAME'] = this.iTEMNAME;
    data['QTY'] = this.qTY;
    data['LEDGERACCOUNTIDOFFSET'] = this.lEDGERACCOUNTIDOFFSET;
    data['JOURNALID'] = this.jOURNALID;
    data['TRANSDATE'] = this.tRANSDATE;
    data['INVENTSITEID'] = this.iNVENTSITEID;
    data['INVENTLOCATIONID'] = this.iNVENTLOCATIONID;
    data['CONFIGID'] = this.cONFIGID;
    data['WMSLOCATIONID'] = this.wMSLOCATIONID;
    data['TRXDATETIME'] = this.tRXDATETIME;
    data['TRXUSERIDASSIGNED'] = this.tRXUSERIDASSIGNED;
    data['TRXUSERIDASSIGNEDBY'] = this.tRXUSERIDASSIGNEDBY;
    data['ITEMSERIALNO'] = this.iTEMSERIALNO;
    data['QTYSCANNED'] = this.qTYSCANNED;
    data['QTYDIFFERENCE'] = this.qTYDIFFERENCE;
    return data;
  }
}
