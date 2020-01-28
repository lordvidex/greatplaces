import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          child: Text('No Image'),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        Expanded(
          child: FlatButton.icon(
            color: Theme.of(context).primaryColor,
              icon: Icon(Icons.camera),
              label: Text('Take Picture'),
              onPressed: () {}),
        )
      ],
    );
  }
}
