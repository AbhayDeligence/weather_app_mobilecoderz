import 'package:geolocator/geolocator.dart';

class FeatchLatLng {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('service-------------$serviceEnabled');
    var reqagain = await Geolocator.requestPermission();
    print('request--------------$reqagain');
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
