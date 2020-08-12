import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      home: PortalBerita(),
    ));

class PortalBerita extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PortalBeritaState();
  }
}

class _PortalBeritaState extends State<PortalBerita> {
  GlobalObjectKey keys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portal Berita"),
      ),
      body: Container(
        child: ModalProgressHUD(
          inAsyncCall: false,
          opacity: 1.0,
          progressIndicator: CircularProgressIndicator(),
          child: WebView(
            initialUrl: "https://jogjaprov.go.id/home",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
