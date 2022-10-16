import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NumberToCharacters/number_to_character.dart';


final ControllerText = TextEditingController(text: "0" );
final ControllerText2 = TextEditingController(text: "" );
var converter = NumberToCharacterConverter('en');

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title?? ""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
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
              style: const TextStyle(fontSize: 16,color: Colors.red),
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
              style: const TextStyle(fontSize: 16,color: Colors.red),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            //int number = int.parse(ControllerText.text);
            // ControllerText2.text = converter.convertInt(int.parse(ControllerText.text));
             ControllerText2.text = converter.convertDouble(double.parse(ControllerText.text));

            //ControllerText2.text = converterold.convert(int.parse(ControllerText.text));
          } catch (exception) {

          }
        },
        tooltip: 'Convert',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
