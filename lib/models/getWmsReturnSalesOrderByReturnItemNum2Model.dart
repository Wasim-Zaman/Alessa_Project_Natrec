// ignore_for_file: camel_case_types

class getWmsReturnSalesOrderByReturnItemNum2Model {
  String? iTEMID;
  String? nAME;
  num? eXPECTEDRETQTY;
  String? sALESID;
  String? rETURNITEMNUM;
  String? iNVENTSITEID;
  String? iNVENTLOCATIONID;
  String? cONFIGID;
  String? wMSLOCATIONID;
  String? itemSerialNo;

  getWmsReturnSalesOrderByReturnItemNum2Model(
      {this.iTEMID,
      this.nAME,
      this.eXPECTEDRETQTY,
      this.sALESID,
      this.rETURNITEMNUM,
      this.iNVENTSITEID,
      this.iNVENTLOCATIONID,
      this.cONFIGID,
      this.wMSLOCATIONID,
      this.itemSerialNo});

  getWmsReturnSalesOrderByReturnItemNum2Model.fromJson(
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
    itemSerialNo = json['ITEMSERIALNO'];
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
    data['ITEMSERIALNO'] = itemSerialNo;
    return data;
  }
}
