import 'dart:convert';

import 'package:_3ilm_nafi3/models/uploader.dart';
import 'package:_3ilm_nafi3/screens/metadata.dart';
import 'package:_3ilm_nafi3/screens/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String videoId;
  final String videoUrl;
  final String title;
  final Uploader uploader;
  final String? refr;

  late int likeCount;

  VideoPage({
    Key? key,
    required this.videoId,
    required this.videoUrl,
    required this.title,
    required this.uploader,
    required this.likeCount,
    required this.refr,
  }) : super(key: key);

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
    _initVideo();
    _loadLikeStatus();
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

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.network(
      "https://3ilmnafi3.digilocx.fr/uploads/${widget.videoUrl.split("/")[4]}",
    );
    await _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1.0);
    _videoPlayerController.play();
    setState(() => isPlaying = true);
  }

  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final likedVideos = prefs.getStringList('liked_videos') ?? [];
    setState(() {
      isFavorite = likedVideos.contains(widget.videoId);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final likedVideos = prefs.getStringList('liked_videos') ?? [];

    bool wasFavorite = isFavorite;

    setState(() {
      if (wasFavorite) {
        likedVideos.remove(widget.videoId);
        widget.likeCount--;
      } else {
        likedVideos.add(widget.videoId);
        widget.likeCount++;
      }
      isFavorite = !wasFavorite;
      prefs.setStringList('liked_videos', likedVideos);
    });

    
    final url = Uri.parse(
      'https://3ilmnafi3.digilocx.fr/api/videos/${widget.videoId}',
    );
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          
        },
        body: jsonEncode({'likesCount': widget.likeCount}),
      );

      if (response.statusCode != 200) {
        print('Failed to update likes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating like count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child:
                _videoPlayerController.value.isInitialized
                    ? FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    )
                    : Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    ),
          ),
          Positioned(
            top: 35,
            left: 50,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => VideoMetadataPage(
                          title: widget.title,
                          uploaderUsername: widget.uploader.username,
                          ref: widget.refr,
                        ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.black.withOpacity(0.3),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 325,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.white,size: 40,),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _videoPlayerController.pause();
                      isPlaying = false;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserProfilePage(user: widget.uploader),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child:
                        widget.uploader.profilePic == "0"
                            ? Icon(Icons.person, color: Colors.white, size: 30)
                            : null,
                    backgroundImage:
                        widget.uploader.profilePic != "0"
                            ? AssetImage(
                              "assets/images/small_profiles/profile${widget.uploader.profilePic}.PNG",
                            )
                            : null,
                  ),
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
                  onPressed: _toggleFavorite,
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
