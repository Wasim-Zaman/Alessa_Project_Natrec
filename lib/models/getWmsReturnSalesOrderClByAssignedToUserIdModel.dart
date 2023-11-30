// ignore_for_file: camel_case_types

class getWmsReturnSalesOrderClByAssignedToUserIdModel {
  String? iTEMID;
  String? nAME;
  num? eXPECTEDRETQTY;
  String? sALESID;
  String? rETURNITEMNUM;
  String? iNVENTSITEID;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  String? wMSLOCATIONID;
  String? tRXDATETIME;
  String? tRXUSERID;
  String? iTEMSERIALNO;
  String? aSSIGNEDTOUSERID;

  getWmsReturnSalesOrderClByAssignedToUserIdModel(
      {this.iTEMID,
      this.nAME,
      this.eXPECTEDRETQTY,
      this.sALESID,
      this.rETURNITEMNUM,
      this.iNVENTSITEID,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.wMSLOCATIONID,
      this.tRXDATETIME,
      this.tRXUSERID,
      this.iTEMSERIALNO,
      this.aSSIGNEDTOUSERID});

  getWmsReturnSalesOrderClByAssignedToUserIdModel.fromJson(
      Map<String, dynamic> json) {
    iTEMID = json['ITEMID'];
    nAME = json['NAME'];
    eXPECTEDRETQTY = json['EXPECTEDRETQTY'];
    sALESID = json['SALESID'];
    rETURNITEMNUM = json['RETURNITEMNUM'];
    iNVENTSITEID = json['INVENTSITEID'];
    iNVENTLOCATIONID = json['INVENTLOCATIONID'];
    cONFIGID = json['CONFIGID'];
    wMSLOCATIONID = json['WMSLOCATIONID'];
    tRXDATETIME = json['TRXDATETIME'];
    tRXUSERID = json['TRXUSERID'];
    iTEMSERIALNO = json['ITEMSERIALNO'];
    aSSIGNEDTOUSERID = json['ASSIGNEDTOUSERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEMID'] = iTEMID;
    data['NAME'] = nAME;
    data['EXPECTEDRETQTY'] = eXPECTEDRETQTY;
    data['SALESID'] = sALESID;
    data['RETURNITEMNUM'] = rETURNITEMNUM;
    data['INVENTSITEID'] = iNVENTSITEID;
    data['INVENTLOCATIONID'] = iNVENTLOCATIONID;
    data['CONFIGID'] = cONFIGID;
    data['WMSLOCATIONID'] = wMSLOCATIONID;
    data['TRXDATETIME'] = tRXDATETIME;
    data['TRXUSERID'] = tRXUSERID;
    data['ITEMSERIALNO'] = iTEMSERIALNO;
    data['ASSIGNEDTOUSERID'] = aSSIGNEDTOUSERID;
    return data;
  }
}
