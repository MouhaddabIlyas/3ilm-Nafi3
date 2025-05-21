import 'dart:convert';

import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/models/uploader.dart';
import 'package:_3ilm_nafi3/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class MyVideosPage extends StatefulWidget {
  @override
  _MyVideosPageState createState() => _MyVideosPageState();
}

class _MyVideosPageState extends State<MyVideosPage> {
  List<Video> myVideos = [];
  String? loggedID;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyVideos();
  }

  Future<void> loadMyVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedID = prefs.getString('loggedID');

    final response = await http.get(
      Uri.parse("https://3ilmnafi3.digilocx.fr/api/videos"),
    );

    if (response.statusCode == 200 && loggedID != null) {
      List allVideos = json.decode(response.body);
      setState(() {
        myVideos =
            allVideos
                .map((json) => Video.fromJson(json))
                .where((video) => video.uploader['id'] == loggedID)
                .toList();
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteVideo(String id) async {
    final response = await http.delete(
      Uri.parse("https://3ilmnafi3.digilocx.fr/api/videos/$id"),
    );
    if (response.statusCode == 200) {
      setState(() {
        myVideos.removeWhere((video) => video.id == id);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Veuillez réessayer plus tard.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes vidéos')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: green,))
              : GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: myVideos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  final video = myVideos[index];
                  return AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(video.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: Icon(Icons.cancel, color: Colors.white),
                            onPressed:
                                () => showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text('Supprimer'),
                                        content: Text(
                                          'Voulez-vous supprimer cette vidéo?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(
                                                  context,
                                                ), 
                                            child: Text('Annuler',style: TextStyle(color: Colors.black),),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                              ); 
                                              deleteVideo(
                                                video.id,
                                              ); 
                                            },
                                            child: Text(
                                              'Supprimer',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          right: 4,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              video.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
