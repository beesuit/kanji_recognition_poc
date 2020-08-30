
import 'package:flutter/material.dart';

class HandwritingRecognitionFragment extends StatefulWidget{
  final String title;

  HandwritingRecognitionFragment({Key key, @required this.title}) : super(key:key);
  
  @override
  _HwRecognitionFragmentState createState() => _HwRecognitionFragmentState();

}

class _HwRecognitionFragmentState extends State<HandwritingRecognitionFragment> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text('To be implemented'),
      )
    );
  }
  
}