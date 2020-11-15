import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/great_places.dart';
import '../components/image_input.dart';
import '../components/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textController = TextEditingController();
  File _savedImage;
  PlaceLocation _savedLocation;
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _getImage(File image) {
    _savedImage = image;
  }

  void _getLocation(PlaceLocation loc) {
    _savedLocation = loc;
  }

  void _addPlace() {
    if (_textController.text.isEmpty ||
        _savedImage == null ||
        _savedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_textController.text, _savedImage, _savedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_getImage),
                    SizedBox(height: 10),
                    LocationInput(_getLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _addPlace,
          ),
        ],
      ),
    );
  }
}
