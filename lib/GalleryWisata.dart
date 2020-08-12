import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryWisata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryWisataState();
  }
}

class _GalleryWisataState extends State<GalleryWisata> {
  var photo = [
    "https://cdns.klimg.com/merdeka.com/i/w/news/2018/05/21/978617/content_images/670x335/20180521113239-2-trans-studio-mini-maguwo-001-tantri-setyorini.jpg",
    "https://cdns.klimg.com/merdeka.com/i/w/news/2018/05/21/978617/content_images/670x335/20180521113239-1-the-world-landmarks-merapi-park-001-tantri-setyorini.jpg",
    "https://cdns.klimg.com/merdeka.com/i/w/news/2018/05/21/978617/content_images/670x335/20180521113239-3-pantai-nglambor-001-tantri-setyorini.jpg",
    "https://cdns.klimg.com/merdeka.com/i/w/news/2018/05/21/978617/content_images/670x335/20180521113240-4-jogja-bay-waterpark-001-tantri-setyorini.jpg",
    "https://cdns.klimg.com/merdeka.com/i/w/news/2018/05/21/978617/content_images/670x335/20180521113240-5-kebun-teh-nglinggo-001-tantri-setyorini.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galeri Wisata"),
      ),
      body: GridView.builder(
        itemCount: photo.length ?? 0,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            child: GridTile(
              child: Image.network(
                photo[index],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
