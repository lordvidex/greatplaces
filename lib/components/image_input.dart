import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function getImage;
  ImageInput(this.getImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  Future<void> _getImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    final imageName = path.basename(imageFile.path);
    setState(() {
      _image = imageFile;
    });
    final storageLoc = await sysPath.getApplicationDocumentsDirectory();
    final savedImage = await imageFile.copy('${storageLoc.path}/$imageName');
    widget.getImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 100,
          child: _image == null
              ? Text(
                  'No Image',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        Expanded(
          child: FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            onPressed: _getImage,
          ),
        )
      ],
    );
  }
}
