import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/theme.dart';

class Uploader {
  final String id;
  final String username;

  Uploader({required this.id, required this.username});

  factory Uploader.fromJson(Map<String, dynamic> json) {
    return Uploader(id: json['id'], username: json['username']);
  }
}

class Video {
  final String id;
  final String title;
  final String videoUrl;
  final String uploaderId;
  final List<String> themes;
  final int likesCount;
  final String imageUrl;
  final String reference;
  final Uploader uploader;

  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.uploaderId,
    required this.themes,
    required this.likesCount,
    required this.imageUrl,
    required this.reference,
    required this.uploader,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    List<String> themesList = List<String>.from(
      json['themes'].map((theme) => theme['name']),
    );

    return Video(
      id: json['id'],
      title: json['title'],
      videoUrl: json['videoUrl'],
      uploaderId: json['uploaderId'],
      themes: themesList,
      likesCount: json['likesCount'],
      imageUrl: json['imageUrl'],
      reference: json['reference'],
      uploader: Uploader.fromJson(json['uploader']),
    );
  }
}

Future<List<Video>> fetchVideos() async {
  final url = Uri.parse('http://3ilmnafi3.fony5290.odns.fr/api/videos');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (error) {
    throw Exception('Error fetching videos: $error');
  }
}

class ThemePage extends StatefulWidget {
  final String theme;
  final String videosPath;
  final String imagePath;

  const ThemePage({
    Key? key,
    required this.theme,
    required this.videosPath,
    required this.imagePath,
  }) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  late Future<VideoTheme> themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(widget.imagePath, fit: BoxFit.cover),
                  Center(
                    child: Text(
                      widget.theme,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 30,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator(color: green,)),
                /*child: FutureBuilder<List<Video>>(
                  future: fetchVideos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(green),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.data);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No videos available'));
                    } else {
                      final videos = snapshot.data!;

                      return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return ListTile(
                            title: Text(video.title),
                            subtitle: Text(video.uploaderId),
                            leading: Image.network(
                              video.imageUrl,
                            ), // Display the image
                            onTap: () {
                              // Handle video tap, like opening a new screen or playing the video
                            },
                          );
                        },
                      );
                    }
                  },
                ),*/
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
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
