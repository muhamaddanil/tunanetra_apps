import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWisata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoWisata();
  }
}

class _VideoWisata extends State<VideoWisata> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'WdNCl4Cx8iU',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
    );
  }
}
