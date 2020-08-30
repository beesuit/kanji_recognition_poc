import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kanji_recognition_poc/demo_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: MyApp(selectedCamera: firstCamera,)
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription selectedCamera;

  MyApp({Key key, @required this.selectedCamera}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KANJI',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Kanji Input Demo', selectedCamera: selectedCamera,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final CameraDescription selectedCamera;

  MyHomePage({Key key, @required this.title, @required this.selectedCamera}) : super(key: key);

  final List<String> demos = ['TesseractOCR', 'Handwriting recognition'];
  final Map<String, dynamic> configs = {
    'TesseractOCR': {'type':'ocr', 'desc': 'Demo of TesseractOCR. Click on the camera button to start.'},
    'Handwriting recognition': {'type':'hw', 'desc':'Demo of MLKit. Click on the canvas button to start.'},
    'EasyOCR': {'type':'ocr', 'desc':'Demo of EasyOCR. Click on the camera button to start.'}
  };

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String info = 'This is a Kanji input recognition POC.\nSelect any demo on the list and follow the instructions.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: widget.demos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.demos[index]),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DemoScreen(title: widget.demos[index], type: widget.configs[widget.demos[index]]['type'], selectedCamera: widget.selectedCamera),
                ));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(widget.title),
            content: Text(info),
          ),
        ),
        tooltip: 'Information',
        child: Icon(Icons.info_outline),
      ),
    );
  }
}
