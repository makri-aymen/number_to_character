import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NumberToCharacters/number_to_character.dart';



final ControllerText = TextEditingController(text: "1998" );
final ControllerText2 = TextEditingController(text: "" );
var converter = NumberToCharacterConverter('en');
//var converterold = NumberToTextConverter.forInternationalNumberingSystem();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Convert your number to text',
            ),
            TextField(
              onTap: (){
                ControllerText.text= "";
                ControllerText2.text= "";
              },
              keyboardType: TextInputType.number,
              controller: ControllerText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,color: Colors.red),
            ),
            TextField(
              onTap: (){
                Clipboard.setData(ClipboardData(text: ControllerText2.text));
                ControllerText.text= "";
                ControllerText2.text= "";
              },
              enabled: false,
              keyboardType: TextInputType.number, // Onl
              controller: ControllerText2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,color: Colors.red),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            //int number = int.parse(ControllerText.text);
            //ControllerText2.text = converter.convertInt(int.parse(ControllerText.text));
            ControllerText2.text = converter.convertDouble(double.parse(ControllerText.text));

            //ControllerText2.text = converterold.convert(int.parse(ControllerText.text));
          } catch ( E ) {

          }
        },
        tooltip: 'Convert',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
