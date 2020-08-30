
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_screen.dart';

class OcrFragment extends StatelessWidget {
  final String title;
  final CameraDescription selectedCamera;

  OcrFragment({Key key, @required this.title, @required this.selectedCamera}) : super(key: key);

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Center(
        child: Text(this.title, style: TextStyle(fontSize: 24),),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraScreen(title: title, camera: selectedCamera),
          )
        );},
      ),
    );
  }
  
}