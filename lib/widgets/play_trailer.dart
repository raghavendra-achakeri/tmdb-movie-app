import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailer extends StatefulWidget {
  final String movieId;
  PlayTrailer({Key key, this.movieId}) : super(key: key);

  @override
  _PlayTrailerState createState() => _PlayTrailerState();
}

class _PlayTrailerState extends State<PlayTrailer> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    // some widgets
                    player,
                    //some other widgets
                  ],
                );
              }),
        ),
      ),
    );
  }
}
