// ignore_for_file: camel_case_types

class getDispatchingTableModel {
  String? sALESID;
  String? iTEMID;
  String? nAME;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  num? oRDERED;
  String? pACKINGSLIPID;
  String? vEHICLESHIPPLATENUMBER;

  getDispatchingTableModel(
      {this.sALESID,
      this.iTEMID,
      this.nAME,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.oRDERED,
      this.pACKINGSLIPID,
      this.vEHICLESHIPPLATENUMBER});

  getDispatchingTableModel.fromJson(Map<String, dynamic> json) {
    sALESID = json['SALESID'];
    iTEMID = json['ITEMID'];
    nAME = json['NAME'];
    iNVENTLOCATIONID = json['INVENTLOCATIONID'];
    cONFIGID = json['CONFIGID'];
    oRDERED = json['ORDERED'];
    pACKINGSLIPID = json['PACKINGSLIPID'];
    vEHICLESHIPPLATENUMBER = json['VEHICLESHIPPLATENUMBER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SALESID'] = sALESID;
    data['ITEMID'] = iTEMID;
    data['NAME'] = nAME;
    data['INVENTLOCATIONID'] = iNVENTLOCATIONID;
    data['CONFIGID'] = cONFIGID;
    data['ORDERED'] = oRDERED;
    data['PACKINGSLIPID'] = pACKINGSLIPID;
    data['VEHICLESHIPPLATENUMBER'] = vEHICLESHIPPLATENUMBER;
    return data;
  }
}
