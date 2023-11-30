// ignore_for_file: file_names

class GetAllWmsTruckMasterModel {
  String? plateNo;
  String? barcodeSerialNumber;
  String? transportationCompanyName;

  GetAllWmsTruckMasterModel(
      {this.plateNo, this.barcodeSerialNumber, this.transportationCompanyName});

  GetAllWmsTruckMasterModel.fromJson(Map<String, dynamic> json) {
    plateNo = json['PlateNo'];
    barcodeSerialNumber = json['BarcodeSerialNumber'];
    transportationCompanyName = json['TransportationCompanyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PlateNo'] = plateNo;
    data['BarcodeSerialNumber'] = barcodeSerialNumber;
    data['TransportationCompanyName'] = transportationCompanyName;
    return data;
  }
}
