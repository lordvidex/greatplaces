import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('An error occured!'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Consumer<GreatPlaces>(
                builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          onTap: () {},
                          title: Text(greatPlace.items[i].title),
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlace.items[i].image),
                          ),
                        ),
                      ),
                child: Center(
                  child: Text(
                    'No saved places available',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }),
    );
  }
}
