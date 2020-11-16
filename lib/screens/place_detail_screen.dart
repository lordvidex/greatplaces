import 'package:flutter/material.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-detail";
  @override
  Widget build(BuildContext context) {
    String selectedPlaceId =
        ModalRoute.of(context).settings.arguments as String;
    final Place selectedPlace = Provider.of<GreatPlaces>(context, listen: false)
        .findPlaceById(selectedPlaceId);
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPlace.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.file(
                    selectedPlace.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
              SizedBox(height: 10),
              Text(
                selectedPlace.location.address,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.grey,
                    ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text('View on Map'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      initialLocation: selectedPlace.location,
                      isViewMode: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
