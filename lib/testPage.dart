import 'dart:convert';  // For json decoding
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Uploader {
  final String id;
  final String username;

  Uploader({
    required this.id,
    required this.username,
  });

  factory Uploader.fromJson(Map<String, dynamic> json) {
    return Uploader(
      id: json['id'],
      username: json['username'],
    );
  }
}

class Video {
  final String id;
  final String title;
  final String videoUrl;
  final String uploaderId;
  final List<String> themes;  // This is still a List<String>, assuming you want the theme names
  final int likesCount;
  final String imageUrl;
  final String reference;
  final Uploader uploader;  // The uploader field is now an object of the Uploader class

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

  // Factory method to create Video from JSON
  factory Video.fromJson(Map<String, dynamic> json) {
    // Parse the themes as a list of theme names
    List<String> themesList = List<String>.from(
        json['themes'].map((theme) => theme['name'])
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
      uploader: Uploader.fromJson(json['uploader']),  // Parse uploader
    );
  }
}


//http://3ilmnafi3.fony5290.odns.fr/api/videos

Future<List<Video>> fetchVideos() async {
  final url = Uri.parse('http://3ilmnafi3.fony5290.odns.fr/api/videos');  // Use the correct URL here

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




class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: FutureBuilder<List<Video>>(
        future: fetchVideos(),  // Call the fetchVideos function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                  leading: Image.network(video.imageUrl), // Display the image
                  onTap: () {
                    // Handle video tap, like opening a new screen or playing the video
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}