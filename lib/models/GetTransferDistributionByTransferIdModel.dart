// ignore_for_file: file_names

class GetTransferDistributionByTransferIdModel {
  String? aLSPACKINGSLIPREF;
  num? aLSTRANSFERORDERTYPE;
  String? tRANSFERID;
  String? iNVENTLOCATIONIDFROM;
  String? iNVENTLOCATIONIDTO;
  num? qTYTRANSFER;
  String? iTEMID;
  String? iTEMNAME;
  String? cONFIGID;
  String? wMSLOCATIONID;
  String? sHIPMENTID;

  GetTransferDistributionByTransferIdModel(
      {this.aLSPACKINGSLIPREF,
      this.aLSTRANSFERORDERTYPE,
      this.tRANSFERID,
      this.iNVENTLOCATIONIDFROM,
      this.iNVENTLOCATIONIDTO,
      this.qTYTRANSFER,
      this.iTEMID,
      this.iTEMNAME,
      this.cONFIGID,
      this.wMSLOCATIONID,
      this.sHIPMENTID});

  GetTransferDistributionByTransferIdModel.fromJson(Map<String, dynamic> json) {
    aLSPACKINGSLIPREF = json['ALS_PACKINGSLIPREF'];
    aLSTRANSFERORDERTYPE = json['ALS_TRANSFERORDERTYPE'];
    tRANSFERID = json['TRANSFERID'];
    iNVENTLOCATIONIDFROM = json['INVENTLOCATIONIDFROM'];
    iNVENTLOCATIONIDTO = json['INVENTLOCATIONIDTO'];
    qTYTRANSFER = json['QTYTRANSFER'];
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    cONFIGID = json['CONFIGID'];
    wMSLOCATIONID = json['WMSLOCATIONID'];
    sHIPMENTID = json['SHIPMENTID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ALS_PACKINGSLIPREF'] = aLSPACKINGSLIPREF;
    data['ALS_TRANSFERORDERTYPE'] = aLSTRANSFERORDERTYPE;
    data['TRANSFERID'] = tRANSFERID;
    data['INVENTLOCATIONIDFROM'] = iNVENTLOCATIONIDFROM;
    data['INVENTLOCATIONIDTO'] = iNVENTLOCATIONIDTO;
    data['QTYTRANSFER'] = qTYTRANSFER;
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['CONFIGID'] = cONFIGID;
    data['WMSLOCATIONID'] = wMSLOCATIONID;
    data['SHIPMENTID'] = sHIPMENTID;
    return data;
  }
}
