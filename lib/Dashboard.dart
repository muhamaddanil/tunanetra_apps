import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final String title;

  Dashboard({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardState(titles: title);
  }
}

class _DashboardState extends State<Dashboard> {
  final String titles;

  _DashboardState({this.titles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles),),
      body: Center(
        child: Text(
            "The Special Region of Yogyakarta (Indonesian: Daerah Istimewa Yogyakarta, pronounced /ˌjɒɡjəˈkɑːrtə/) is a provincial-level autonomous region of Indonesia in the southern Java.[5] "
                "It is bordered by the Indian Ocean to the south, as well as sharing all the land borders to the province of Central Java. Ruled by the Yogyakarta Sultanate, the region is the only officially recognised monarchy within the government of Indonesia. "
                "The city of Yogyakarta is the capital and the economic center of the region.The Yogyakarta Sultanate has been established since 1755 and provided an unwavering support for Indonesia's independence during the Indonesian National Revolution (1945–1949). "
                "As a first-level division in Indonesia, Yogyakarta is governed by Sultan Hamengkubuwono as the governor and Prince Paku Alam as the vice governor. With a land area of 3,185.8 km², it is the second-smallest province of Indonesia after Jakarta.[6]"),
      ),
    );
  }
}
