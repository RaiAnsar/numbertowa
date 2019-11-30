import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number x WhatsApp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Number to What\'s App'),
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
  Country _selected;

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => new Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CountryPicker(
                showDialingCode: true,
                onChanged: (Country country) {
                  setState(() {
                    _selected = country;
                  });
                },
                selectedCountry: _selected,
              ),
              Center(
                child: SizedBox(
                  width: 380.0,
                  // height: 50.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 20,
                    textAlign: TextAlign.center,
                    enableInteractiveSelection: true,
                    enableSuggestions: true,
                    cursorColor: Colors.amber,
                    autofocus: true,
                    controller: myController,
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      focusColor: Colors.cyanAccent,
                      filled: true,
                      hoverColor: Colors.red,
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                  ),
                ),
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  int cCode = int.parse(_selected.dialingCode);
                  int mobileNumber = int.parse(myController.text);
                  String url = 'https://wa.me/$cCode$mobileNumber';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                label: Text('Open in WhatsApp'),
                icon: Icon(Icons.open_in_new),
                backgroundColor: Colors.deepPurpleAccent[100],
              ),
            ],
          ),
        ),
      );
}
