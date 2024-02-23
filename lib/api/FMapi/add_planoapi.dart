import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_service.dart';
import '../api_service2.dart';

class AddPlanooutlet {
  static List<int> outletpdtmapid = [];
  static int outletid;
  static List<dynamic> cid = [];
  static List<String> planoimg = [];
}

Future addplanooutletmap() async {
  Map addplanofm = {
    'mapping_id': AddPlanooutlet.outletpdtmapid,
    'outlet_id': AddPlanooutlet.outletid,
    'category_id': AddPlanooutlet.cid,
    'planogram_img': AddPlanooutlet.planoimg,
  };
  print(jsonEncode(addplanofm));
  http.Response brand = await http.post(
    AddPlanoFM,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${DBrequestdata.receivedtoken}',
    },
    body: jsonEncode(addplanofm),
  );
  print('planogram : ${brand.body}');
}
