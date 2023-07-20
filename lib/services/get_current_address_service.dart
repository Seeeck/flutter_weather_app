import 'package:geocoding/geocoding.dart';

Future getCurrentAddressService(double latitude, double longitude) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  return placemarks;
}
