import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _locationPreviewUrl;
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
              onPressed: () {},
              icon: Icon(Icons.location_on),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              label: Text('Show on Map'),
              onPressed: () {},
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
