// ignore_for_file: camel_case_types

class getAllTblShipmentReceivedCLModel {
  String? sHIPMENTID;
  String? cONTAINERID;
  String? aRRIVALWAREHOUSE;
  String? iTEMNAME;
  String? iTEMID;
  String? pURCHID;
  num? cLASSIFICATION;
  String? sERIALNUM;
  String? rCVDCONFIGID;
  String? rCVDDATE;
  String? gTIN;
  String? rZONE;
  String? pALLETDATE;
  String? pALLETCODE;
  String? bIN;
  String? rEMARKS;
  num? pOQTY;
  num? rCVQTY;
  num? rEMAININGQTY;
  String? uSERID;
  String? tRXDATETIME;

  getAllTblShipmentReceivedCLModel(
      {this.sHIPMENTID,
      this.cONTAINERID,
      this.aRRIVALWAREHOUSE,
      this.iTEMNAME,
      this.iTEMID,
      this.pURCHID,
      this.cLASSIFICATION,
      this.sERIALNUM,
      this.rCVDCONFIGID,
      this.rCVDDATE,
      this.gTIN,
      this.rZONE,
      this.pALLETDATE,
      this.pALLETCODE,
      this.bIN,
      this.rEMARKS,
      this.pOQTY,
      this.rCVQTY,
      this.rEMAININGQTY,
      this.uSERID,
      this.tRXDATETIME});

  getAllTblShipmentReceivedCLModel.fromJson(Map<String, dynamic> json) {
    sHIPMENTID = json['SHIPMENTID'];
    cONTAINERID = json['CONTAINERID'];
    aRRIVALWAREHOUSE = json['ARRIVALWAREHOUSE'];
    iTEMNAME = json['ITEMNAME'];
    iTEMID = json['ITEMID'];
    pURCHID = json['PURCHID'];
    cLASSIFICATION = json['CLASSIFICATION'];
    sERIALNUM = json['SERIALNUM'];
    rCVDCONFIGID = json['RCVDCONFIGID'];
    rCVDDATE = json['RCVD_DATE'];
    gTIN = json['GTIN'];
    rZONE = json['RZONE'];
    pALLETDATE = json['PALLET_DATE'];
    pALLETCODE = json['PALLETCODE'];
    bIN = json['BIN'];
    rEMARKS = json['REMARKS'];
    pOQTY = json['POQTY'];
    rCVQTY = json['RCVQTY'];
    rEMAININGQTY = json['REMAININGQTY'];
    uSERID = json['USERID'];
    tRXDATETIME = json['TRXDATETIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SHIPMENTID'] = sHIPMENTID;
    data['CONTAINERID'] = cONTAINERID;
    data['ARRIVALWAREHOUSE'] = aRRIVALWAREHOUSE;
    data['ITEMNAME'] = iTEMNAME;
    data['ITEMID'] = iTEMID;
    data['PURCHID'] = pURCHID;
    data['CLASSIFICATION'] = cLASSIFICATION;
    data['SERIALNUM'] = sERIALNUM;
    data['RCVDCONFIGID'] = rCVDCONFIGID;
    data['RCVD_DATE'] = rCVDDATE;
    data['GTIN'] = gTIN;
    data['RZONE'] = rZONE;
    data['PALLET_DATE'] = pALLETDATE;
    data['PALLETCODE'] = pALLETCODE;
    data['BIN'] = bIN;
    data['REMARKS'] = rEMARKS;
    data['POQTY'] = pOQTY;
    data['RCVQTY'] = rCVQTY;
    data['REMAININGQTY'] = rEMAININGQTY;
    data['USERID'] = uSERID;
    data['TRXDATETIME'] = tRXDATETIME;
    return data;
  }
}
