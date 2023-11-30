// ignore_for_file: file_names

class BinToBinJournalModel {
  String? tRANSFERID;
  num? tRANSFERSTATUS;
  String? iNVENTLOCATIONIDFROM;
  String? iNVENTLOCATIONIDTO;
  String? iTEMID;
  num? qTYTRANSFER;
  num? qTYRECEIVED;
  String? cREATEDDATETIME;
  String? journalID;
  String? binLocation;
  String? dateTimeTransaction;
  String? cONFIG;
  String? uSERID;

  BinToBinJournalModel(
      {this.tRANSFERID,
      this.tRANSFERSTATUS,
      this.iNVENTLOCATIONIDFROM,
      this.iNVENTLOCATIONIDTO,
      this.iTEMID,
      this.qTYTRANSFER,
      this.qTYRECEIVED,
      this.cREATEDDATETIME,
      this.journalID,
      this.binLocation,
      this.dateTimeTransaction,
      this.cONFIG,
      this.uSERID});

  BinToBinJournalModel.fromJson(Map<String, dynamic> json) {
    tRANSFERID = json['TRANSFERID'];
    tRANSFERSTATUS = json['TRANSFERSTATUS'];
    iNVENTLOCATIONIDFROM = json['INVENTLOCATIONIDFROM'];
    iNVENTLOCATIONIDTO = json['INVENTLOCATIONIDTO'];
    iTEMID = json['ITEMID'];
    qTYTRANSFER = json['QTYTRANSFER'];
    qTYRECEIVED = json['QTYRECEIVED'];
    cREATEDDATETIME = json['CREATEDDATETIME'];
    journalID = json['JournalID'];
    binLocation = json['BinLocation'];
    dateTimeTransaction = json['DateTimeTransaction'];
    cONFIG = json['CONFIG'];
    uSERID = json['USERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TRANSFERID'] = tRANSFERID;
    data['TRANSFERSTATUS'] = tRANSFERSTATUS;
    data['INVENTLOCATIONIDFROM'] = iNVENTLOCATIONIDFROM;
    data['INVENTLOCATIONIDTO'] = iNVENTLOCATIONIDTO;
    data['ITEMID'] = iTEMID;
    data['QTYTRANSFER'] = qTYTRANSFER;
    data['QTYRECEIVED'] = qTYRECEIVED;
    data['CREATEDDATETIME'] = cREATEDDATETIME;
    data['JournalID'] = journalID;
    data['BinLocation'] = binLocation;
    data['DateTimeTransaction'] = dateTimeTransaction;
    data['CONFIG'] = cONFIG;
    data['USERID'] = uSERID;
    return data;
  }
}
