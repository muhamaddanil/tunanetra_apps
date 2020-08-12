import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisata_yogyakarta/main.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _SplashScreenBody(),
    );
  }
}

class _SplashScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenBodyState();
  }
}

class _SplashScreenBodyState extends State<_SplashScreenBody> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route route) => false);
    });
    return Scaffold(
      body: Center(
          child: Image(
        image: AssetImage("graphics/splashsc.png"),
        width: 75,
        height: 75,
      )),
    );
  }
}
