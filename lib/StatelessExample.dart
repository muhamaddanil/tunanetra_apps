import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: StatelessExample()));

class StatelessExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateless Widget"),
      ),
      body: Center(
        child: Text(
          "Lauwba Techno Indonesia 2020",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
