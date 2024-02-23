import 'package:geolocator/geolocator.dart';
import 'package:merchandising/model/Location_service.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/jpskippedapi.dart';
import 'package:merchandising/api/Journeyplansapi/todayplan/journeyplanapi.dart';
import 'package:merchandising/Merchandiser/merchandiserscreens/Maps_Veiw.dart';

distinmeters() {
  gettodayjp.distanceinmeters = [];
  gettodayjp.sortdistnce = [];
  print("length of outlets : ${gettodayjp.outletlat.length}");
  try {
    if (lat != null && long != null) {
      for (int u = 0; u < gettodayjp.outletlat.length; u++) {
        double dist = Geolocator.distanceBetween(
            lat,
            long,
            double.parse(gettodayjp.outletlat[u]),
            double.parse(gettodayjp.outletlong[u]));
        gettodayjp.distanceinmeters.add(dist / 1000);
        double sort = Geolocator.distanceBetween(
            lat,
            long,
            double.parse(gettodayjp.outletlat[u]),
            double.parse(gettodayjp.outletlong[u]));
        gettodayjp.sortdistnce.add(sort / 1000);
      }
      print(gettodayjp.distanceinmeters);
      //marker();
      distinmetersforskipjp();
    }
  } catch (e) {
    print("distance cal exception error : $e");
  }
}

distinmetersforskipjp() {
  todayskipjplist.distanceinmeters = [];
  for (int u = 0; u < todayskipjplist.outletlat.length; u++) {
    double skippeddist = Geolocator.distanceBetween(
        lat,
        long,
        double.parse(todayskipjplist.outletlat[u]),
        double.parse(todayskipjplist.outletlong[u]));
    todayskipjplist.distanceinmeters.add(skippeddist / 1000);
  }
}
