// ignore_for_file: file_names

class ValidateZoneCodeModel {
  String? message;
  List<Locations>? locations;
  List<Shipments>? shipments;

  ValidateZoneCodeModel({this.message, this.locations, this.shipments});

  ValidateZoneCodeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    if (json['shipments'] != null) {
      shipments = <Shipments>[];
      json['shipments'].forEach((v) {
        shipments!.add(Shipments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    if (shipments != null) {
      data['shipments'] = shipments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  int? lOCATIONSHFID;
  String? mAIN;
  String? wAREHOUSE;
  String? zONE;
  String? bIN;
  String? zONECODE;
  String? zONENAME;

  Locations(
      {this.lOCATIONSHFID,
      this.mAIN,
      this.wAREHOUSE,
      this.zONE,
      this.bIN,
      this.zONECODE,
      this.zONENAME});

  Locations.fromJson(Map<String, dynamic> json) {
    lOCATIONSHFID = json['LOCATIONS_HFID'];
    mAIN = json['MAIN'];
    wAREHOUSE = json['WAREHOUSE'];
    zONE = json['ZONE'];
    bIN = json['BIN'];
    zONECODE = json['ZONE_CODE'];
    zONENAME = json['ZONE_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['LOCATIONS_HFID'] = lOCATIONSHFID;
    data['MAIN'] = mAIN;
    data['WAREHOUSE'] = wAREHOUSE;
    data['ZONE'] = zONE;
    data['BIN'] = bIN;
    data['ZONE_CODE'] = zONECODE;
    data['ZONE_NAME'] = zONENAME;
    return data;
  }
}

class Shipments {
  String? sHIPMENTID;
  String? cONTAINERID;
  String? aRRIVALWAREHOUSE;
  String? iTEMNAME;
  String? iTEMID;
  String? pURCHID;
  int? cLASSIFICATION;
  String? sERIALNUM;
  String? rCVDCONFIGID;
  String? rCVDDATE;
  String? gTIN;
  String? rZONE;
  String? pALLETDATE;
  String? pALLETCODE;
  String? bIN;
  String? rEMARKS;
  int? pOQTY;
  int? rCVQTY;
  int? rEMAININGQTY;
  String? uSERID;
  String? tRXDATETIME;

  Shipments(
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

  Shipments.fromJson(Map<String, dynamic> json) {
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
