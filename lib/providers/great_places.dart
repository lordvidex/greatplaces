import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) async{
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    var ans = await DBHelper.insert({
      columnId: newPlace.id,
      columnTitle: newPlace.title,
      columnImage: newPlace.image.path,
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
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
