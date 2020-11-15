import 'package:geocoding/geocoding.dart';

//const GOOGLE_API_KEY = 'AIzaSyC8daLQegMeDpfnymSxGBdCjkK2LAaEvAI';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    print(latitude);
    print(longitude);
    return 'https://static-maps.yandex.ru/1.x/?lang=en_US&ll=$longitude,$latitude&size=450,450&z=16&l=map&pt=$longitude,$latitude,comma';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark p = placemarks[0];
    String street = p.street;
    String adminArea = p.administrativeArea;
    String isoCountryCode = p.isoCountryCode;
    String postCode = p.postalCode;
    String country = p.country;
    return "$street, $adminArea, $isoCountryCode $postCode, $country";
  }
}
