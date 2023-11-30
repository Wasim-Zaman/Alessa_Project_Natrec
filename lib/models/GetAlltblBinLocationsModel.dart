// ignore_for_file: file_names

class GetAlltblBinLocationsModel {
  String? groupWarehouse;
  String? zones;
  String? palletNumber;
  num? palletHeight;
  num? palletRow;
  num? palletWidth;
  num? palletTotalSize;
  String? palletType;
  num? palletLength;

  GetAlltblBinLocationsModel(
      {this.groupWarehouse,
      this.zones,
      this.palletNumber,
      this.palletHeight,
      this.palletRow,
      this.palletWidth,
      this.palletTotalSize,
      this.palletType,
      this.palletLength});

  GetAlltblBinLocationsModel.fromJson(Map<String, dynamic> json) {
    groupWarehouse = json['GroupWarehouse'];
    zones = json['Zones'];
    palletNumber = json['PalletNumber'];
    palletHeight = json['PalletHeight'];
    palletRow = json['PalletRow'];
    palletWidth = json['PalletWidth'];
    palletTotalSize = json['PalletTotalSize'];
    palletType = json['PalletType'];
    palletLength = json['PalletLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupWarehouse'] = groupWarehouse;
    data['Zones'] = zones;
    data['PalletNumber'] = palletNumber;
    data['PalletHeight'] = palletHeight;
    data['PalletRow'] = palletRow;
    data['PalletWidth'] = palletWidth;
    data['PalletTotalSize'] = palletTotalSize;
    data['PalletType'] = palletType;
    data['PalletLength'] = palletLength;
    return data;
  }
}
