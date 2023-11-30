// ignore_for_file: file_names

class GetPickingListModel {
  String? pICKINGROUTEID;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  String? iTEMID;
  String? iTEMNAME;
  num? qTY;
  String? cUSTOMER;
  String? dLVDATE;
  String? tRANSREFID;
  num? eXPEDITIONSTATUS;
  String? dATETIMEASSIGNED;
  String? aSSIGNEDTOUSERID;
  String? pICKSTATUS;
  num? qTYPICKED;

  GetPickingListModel(
      {this.pICKINGROUTEID,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.iTEMID,
      this.iTEMNAME,
      this.qTY,
      this.cUSTOMER,
      this.dLVDATE,
      this.tRANSREFID,
      this.eXPEDITIONSTATUS,
      this.dATETIMEASSIGNED,
      this.aSSIGNEDTOUSERID,
      this.pICKSTATUS,
      this.qTYPICKED});

  GetPickingListModel.fromJson(Map<String, dynamic> json) {
    pICKINGROUTEID = json['PICKINGROUTEID'];
    iNVENTLOCATIONID = json['INVENTLOCATIONID'];
    cONFIGID = json['CONFIGID'];
    iTEMID = json['ITEMID'];
    iTEMNAME = json['ITEMNAME'];
    qTY = json['QTY'];
    cUSTOMER = json['CUSTOMER'];
    dLVDATE = json['DLVDATE'];
    tRANSREFID = json['TRANSREFID'];
    eXPEDITIONSTATUS = json['EXPEDITIONSTATUS'];
    dATETIMEASSIGNED = json['DATETIMEASSIGNED'];
    aSSIGNEDTOUSERID = json['ASSIGNEDTOUSERID'];
    pICKSTATUS = json['PICKSTATUS'];
    qTYPICKED = json['QTYPICKED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PICKINGROUTEID'] = pICKINGROUTEID;
    data['INVENTLOCATIONID'] = iNVENTLOCATIONID;
    data['CONFIGID'] = cONFIGID;
    data['ITEMID'] = iTEMID;
    data['ITEMNAME'] = iTEMNAME;
    data['QTY'] = qTY;
    data['CUSTOMER'] = cUSTOMER;
    data['DLVDATE'] = dLVDATE;
    data['TRANSREFID'] = tRANSREFID;
    data['EXPEDITIONSTATUS'] = eXPEDITIONSTATUS;
    data['DATETIMEASSIGNED'] = dATETIMEASSIGNED;
    data['ASSIGNEDTOUSERID'] = aSSIGNEDTOUSERID;
    data['PICKSTATUS'] = pICKSTATUS;
    data['QTYPICKED'] = qTYPICKED;
    return data;
  }
}
