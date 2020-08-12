import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiWisata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokasiWisataState();
  }
}

class _LokasiWisataState extends State<LokasiWisata> {
  Completer<GoogleMapController> _completer = Completer();
  GlobalKey mapsKey;
  Set<Marker> _markers = Set();
  static LatLng tuguLatLng = LatLng(-7.7829371, 110.3670597);
  static LatLng prambanan = LatLng(-7.7520206, 110.4892787);
  static LatLng breksi = LatLng(-7.7816005, 110.5043874);
  CameraTargetBounds bound;

  CameraPosition tuguJogja = CameraPosition(
    target: prambanan,
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi Wisata"),
      ),
      body: GoogleMap(
        padding: EdgeInsets.all(10),
        key: mapsKey,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        cameraTargetBounds: bound,
        mapToolbarEnabled: true,
        compassEnabled: true,
        trafficEnabled: true,
        zoomGesturesEnabled: true,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: tuguJogja,
      ),
    );
  }

  void _addMarkers() {
    var markderId = DateTime.now().toString();
    final tuguId = MarkerId(markderId);
    final tugu = Marker(
        markerId: tuguId,
        position: tuguLatLng,
        infoWindow: InfoWindow(title: "Tugu Yogyakarta"));

    final candiPrambananId = MarkerId(markderId);
    final candiPrambanan = Marker(
        markerId: candiPrambananId,
        position: prambanan,
        infoWindow: InfoWindow(title: "Candi Prambanan"));

    final tebingBreksiId = MarkerId(markderId);
    final tebingBreksi = Marker(
        markerId: tebingBreksiId,
        position: breksi,
        infoWindow: InfoWindow(title: "Tebing Breksi"));

    setState(() {
      _markers.add(tugu);
      _markers.add(candiPrambanan);
      _markers.add(tebingBreksi);
      var bounds = LatLngBounds(
          northeast: breksi,
          southwest: tuguLatLng);
      bound = CameraTargetBounds(bounds);
    });
  }
}
