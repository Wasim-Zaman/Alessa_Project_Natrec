// ignore_for_file: camel_case_types

class getAllWmsSalesPickingListModel {
  String? pICKINGROUTEID;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  String? iTEMID;
  String? iTEMNAME;
  double? qTY;
  String? cUSTOMER;
  String? dLVDATE;
  String? tRANSREFID;
  num? eXPEDITIONSTATUS;

  getAllWmsSalesPickingListModel(
      {this.pICKINGROUTEID,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.iTEMID,
      this.iTEMNAME,
      this.qTY,
      this.cUSTOMER,
      this.dLVDATE,
      this.tRANSREFID,
      this.eXPEDITIONSTATUS});

  getAllWmsSalesPickingListModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
