// ignore_for_file: camel_case_types

class updateWmsJournalMovementClQtyScannedModel {
  String? message;
  UpdatedRow? updatedRow;

  updateWmsJournalMovementClQtyScannedModel({this.message, this.updatedRow});

  updateWmsJournalMovementClQtyScannedModel.fromJson(
      Map<String, dynamic> json) {
    message = json['message'];
    updatedRow = json['updatedRow'] != null
        ? UpdatedRow.fromJson(json['updatedRow'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (updatedRow != null) {
      data['updatedRow'] = updatedRow!.toJson();
    }
    return data;
  }
}

class UpdatedRow {
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
  String? iTEMSERIALNO;
  num? qTYSCANNED;
  num? qTYDIFFERENCE;

  UpdatedRow(
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

  UpdatedRow.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['QTY'] = qTY;
    data['LEDGERACCOUNTIDOFFSET'] = lEDGERACCOUNTIDOFFSET;
    data['JOURNALID'] = jOURNALID;
    data['TRANSDATE'] = tRANSDATE;
    data['INVENTSITEID'] = iNVENTSITEID;
    data['INVENTLOCATIONID'] = iNVENTLOCATIONID;
    data['CONFIGID'] = cONFIGID;
    data['WMSLOCATIONID'] = wMSLOCATIONID;
    data['TRXDATETIME'] = tRXDATETIME;
    data['TRXUSERIDASSIGNED'] = tRXUSERIDASSIGNED;
    data['TRXUSERIDASSIGNEDBY'] = tRXUSERIDASSIGNEDBY;
    data['ITEMSERIALNO'] = iTEMSERIALNO;
    data['QTYSCANNED'] = qTYSCANNED;
    data['QTYDIFFERENCE'] = qTYDIFFERENCE;
    return data;
  }
}
