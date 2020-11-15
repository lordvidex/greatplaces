import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../models/place.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function getLocation;
  LocationInput(this.getLocation);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _locationPreviewUrl;

  Future<void> _fetchUserLocation() async {
    final locData = await Location().getLocation();
    final staticUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    widget.getLocation(PlaceLocation(
        latitude: locData.latitude, longitude: locData.longitude));
    setState(() {
      _locationPreviewUrl = staticUrl;
    });
  }

  Future<void> _getLocationOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(fullscreenDialog: true, builder: (_) => MapScreen()));
    if (selectedLocation == null) {
      return;
    }
    final staticUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    widget.getLocation(PlaceLocation(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude));
    setState(() {
      _locationPreviewUrl = staticUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 300,
          width: double.infinity,
          child: _locationPreviewUrl == null
              ? Center(
                  child: Text(
                    'No location added!',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  _locationPreviewUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              label: Text('Current location'),
              onPressed: _fetchUserLocation,
              icon: Icon(Icons.location_on),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              label: Text('Show on Map'),
              onPressed: _getLocationOnMap,
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
