import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  bool isPlaying = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      'https://www.w3schools.com/html/mov_bbb.mp4',
    );

    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1.0);

    _videoPlayerController.initialize().then((_) {
      setState(() {});
      _videoPlayerController.play();
      setState(() {
        isPlaying = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  // Function to toggle play/pause
  void togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
      isPlaying = !isPlaying;
    });
  }

  // Function to toggle favorite (heart)
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
          ),
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.black.withOpacity(0.3),
              child: Text(
                'bunny',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                maxLines: null,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/images/profiles/profile1.PNG'),
                  backgroundColor: Colors.black,
                ),
                IconButton(
                  onPressed: togglePlayPause,
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
