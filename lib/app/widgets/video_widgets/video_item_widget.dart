import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItemWidget extends StatefulWidget {
  final String url;
  final Size size;

  VideoItemWidget(this.url, this.size);

  @override
  _VideoItemWidgetState createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  late VideoPlayerController _videoPlayerController;

  bool playButton = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();

      setState(() {
        playButton = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget isPlaying() {
    return _videoPlayerController.value.isPlaying
        ? SizedBox()
        : Container(
            width: widget.size.width,
            height: widget.size.height,
            color: Colors.black.withOpacity(0.3),
            child: Icon(Icons.play_arrow, color: Colors.white, size: 80));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Stack(alignment: Alignment.topRight, children: [
          VideoPlayer(_videoPlayerController),
          Center(child: isPlaying()),
          InkWell(
              child: Opacity(
                  opacity: 0.6,
                  child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 30, right: 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://media.istockphoto.com/vectors/car-keys-vector-id1202497889?k=20&m=1202497889&s=612x612&w=0&h=mKOpQWpd9xu0v66OurI5ZHPuKrYo1HNAWMPvsTrhYdo='))))),
              onTap: () {
                Navigator.pop(context);
              })
        ]));
  }
}
