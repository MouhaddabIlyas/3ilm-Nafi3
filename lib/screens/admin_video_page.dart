import 'dart:convert';

import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../models/video.dart';

class _ImageVideoPager extends StatefulWidget {
  final String imageUrl;
  final String videoUrl;

  const _ImageVideoPager({required this.imageUrl, required this.videoUrl});

  @override
  State<_ImageVideoPager> createState() => _ImageVideoPagerState();
}

class _ImageVideoPagerState extends State<_ImageVideoPager> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://3ilmnafi3.digilocx.fr/uploads/${widget.videoUrl.split("/")[4]}",
      )
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // Page 1: Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(widget.imageUrl, fit: BoxFit.fill),
        ),
        // Page 2: Video
        _isVideoInitialized
            ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.white,
                      size: 64,
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                  ),
                ),
              ],
            )
            : Center(child: CircularProgressIndicator(color: green)),
      ],
    );
  }
}

class AdminValidationPage extends StatefulWidget {
  @override
  _AdminValidationPageState createState() => _AdminValidationPageState();
}

class _AdminValidationPageState extends State<AdminValidationPage> {
  List<Video> unapprovedVideos = [];

  @override
  void initState() {
    super.initState();
    fetchUnapprovedVideos();
  }

  Future<void> fetchUnapprovedVideos() async {
    final response = await http.get(
      Uri.parse('https://3ilmnafi3.digilocx.fr/api/videos'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        unapprovedVideos =
            data
                .map((v) => Video.fromJson(v))
                .where((v) => v.isValid == false)
                .toList();
      });
    }
  }

  Future<void> updateApproval(String videoId, bool approve) async {
    if (approve) {
      final response = await http.put(
        Uri.parse('https://3ilmnafi3.digilocx.fr/api/videos/$videoId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isValid': approve}),
      );
      if (response.statusCode == 200) {
        fetchUnapprovedVideos();
      }
    } else {
      final response = await http.delete(
        Uri.parse("https://3ilmnafi3.digilocx.fr/api/videos/$videoId"),
      );
      if (response.statusCode == 200) {
        fetchUnapprovedVideos();
      }
    }
  }

  void showVideoDialog(BuildContext context, String imageUrl, String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: _ImageVideoPager(imageUrl: imageUrl, videoUrl: videoUrl),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Validation")),
      body: ListView.builder(
        itemCount: unapprovedVideos.length,
        itemBuilder: (_, index) {
          final video = unapprovedVideos[index];
          final themes = (video.themes as List)
              .map((theme) => theme['name'])
              .join(', ');

          return ListTile(
            leading: GestureDetector(
              onTap:
                  () =>
                      showVideoDialog(context, video.imageUrl, video.videoUrl),
              child: Image.network(
                video.imageUrl,
                width: 50,
                height: 170,
                fit: BoxFit.fitHeight,
              ),
            ),
            title: Text(
              video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Ref: ${video.ref}"), Text("Thèmes: $themes")],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: () => updateApproval(video.id, true),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => updateApproval(video.id, false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



































/*
class AdminVideoPage extends StatelessWidget {
  const AdminVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 3 * MediaQuery.of(context).size.width / 4,
              child: Text(
                "Il n'y a aucune vidéo en attente pour le moment. Bon travail!!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 35),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/