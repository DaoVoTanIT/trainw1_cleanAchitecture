import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getLocation() async {
    var geoLocator = Geolocator();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      //locationPermissionLevel: GeolocationPermission.location
    );
  }
}
