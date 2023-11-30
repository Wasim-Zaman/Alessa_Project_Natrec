import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constants.dart';

class InsertShipmentController {
  static Future<void> insertShipment(
    String SHIPMENTID,
    String CONTAINERID,
    String ARRIVALWAREHOUSE,
    String ITEMNAME,
    String ITEMID,
    String PURCHID,
    String CLASSIFICATION,
    String SERIALNUM,
    String RCVDCONFIGID,
    String RCVD_DATE,
    String GTIN,
    String RZONE,
    String PALLET_DATE,
    String PALLETCODE,
    String BIN,
    String REMARKS,
    String POQTY,
    String RCVQTY,
    String REMAININGQTY,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    String url = "${Constants.baseUrl}insertIntoMappedBarcode";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": token,
      "Host": Constants.host,
      "Accept": "application/json",
      "itemcode": ITEMID,
      "itemdesc": ITEMNAME,
      "gtin": GTIN,
      "remarks": REMARKS,
      "classification": CLASSIFICATION.toString(),
      "mainlocation": ARRIVALWAREHOUSE,
      "binlocation": BIN,
      "intcode": RCVDCONFIGID,
      "itemserialno": SERIALNUM,
      "mapdate": PALLET_DATE,
      "palletcode": PALLETCODE,
      "reference": SHIPMENTID,
      "sid": SHIPMENTID,
      "cid": CONTAINERID,
      "po": POQTY,
      "trans": "123",
    };

    try {
      var response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");
      } else {
        print("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
