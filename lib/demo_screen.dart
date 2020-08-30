
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kanji_recognition_poc/hw_fragment.dart';
import 'package:kanji_recognition_poc/ocr_fragment.dart';

class DemoScreen extends StatelessWidget {
  final String title;
  final CameraDescription selectedCamera;
  final String type;

  DemoScreen({Key key, @required this.title, @required this.type, this.selectedCamera}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 'ocr') return OcrFragment(title: title, selectedCamera: selectedCamera);
    else if (type == 'hw') return HandwritingRecognitionFragment(title: title);
    else return null;
  }
}