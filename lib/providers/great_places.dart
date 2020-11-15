import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/location_helper.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final locationAddress = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final locationWithAddress = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: locationAddress);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: locationWithAddress);
    _items.add(newPlace);
    notifyListeners();
    var ans = await DBHelper.insert({
      columnId: newPlace.id,
      columnTitle: newPlace.title,
      columnImage: newPlace.image.path,
      columnLat: newPlace.location.latitude,
      columnLng: newPlace.location.longitude,
      columnAddress: newPlace.location.address,
    });
    print(ans);
  }

  Future<void> fetchAndSetPlaces() async {
    var _placeList = await DBHelper.getData();
    _items = _placeList
        .map(
          (item) => Place(
            id: item[columnId],
            image: File(item[columnImage]),
            title: item[columnTitle],
            location: PlaceLocation(
                longitude: item[columnLng],
                latitude: item[columnLat],
                address: item[columnAddress]),
          ),
        )
        .toList();
    notifyListeners();
  }
}
