import 'package:flutter/material.dart';

void main() => runApp(StatelefulExample());

class StatelefulExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _StatefulExampleBody(),
    );
  }
}

class _StatefulExampleBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatefulExampleState();
  }
}

class _StatefulExampleState extends State<_StatefulExampleBody> {
  String _newTextString = "Lauwba Techno Indonesia 2020";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Widget"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(_newTextString),
            RaisedButton(
                child: Text("Klik Saya"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _newTextString = "LKP Unikom Yogyakarta";
                  });
                })
          ],
        ),
      ),
    );
  }
}
