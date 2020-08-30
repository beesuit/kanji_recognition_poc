import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:tesseract_ocr/tesseract_ocr.dart';

class CameraScreen extends StatefulWidget {
  final String title;
  final CameraDescription camera;

  CameraScreen({Key key, @required this.title, @required this.camera}): super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeController;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max
    );

    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<void>(
        future: _initializeController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeController;
            final path = join(
              (await getTemporaryDirectory()).path, '${DateTime.now()}.png'
            );

            await _controller.takePicture(path);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPicture(imagePath: path)
              )
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
  
}

class DisplayPicture extends StatelessWidget {
  final String imagePath;

  DisplayPicture({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PICTURE')),
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.star),
        onPressed: () async {
          String text = await TesseractOcr.extractText(imagePath, language: 'jpn');
          print(text);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Detected Text'),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Dismiss'),
                  onPressed: () {Navigator.of(context).pop();},
                )
              ],
            )
          );
        },
      ),
    );
  }
}