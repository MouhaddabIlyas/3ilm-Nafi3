import 'dart:convert';

import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/models/uploader.dart';
import 'package:_3ilm_nafi3/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/video.dart';

class UserProfilePage extends StatefulWidget {
  final Uploader user;

  UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late String profilePic;

  List<Video> userVideos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserVideos();
  }

  Future<void> fetchUserVideos() async {
    final response = await http.get(
      Uri.parse('https://3ilmnafi3.digilocx.fr/api/videos'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final allVideos = jsonList.map((v) => Video.fromJson(v)).toList();
      final filtered =
          allVideos.where((video) {
            return video.uploader['id'] == widget.user.id;
          }).toList();

      setState(() {
        userVideos = filtered;
        isLoading = false;
      });
    } else {
      
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    profilePic = widget.user.profilePic!;
    return Scaffold(
      appBar: AppBar(centerTitle: true, backgroundColor: Colors.transparent,scrolledUnderElevation: 0,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child:
                  widget.user.profilePic == "0"
                      ? Icon(Icons.person, color: Colors.white, size: 50)
                      : null,
              backgroundImage:
                  widget.user.profilePic != "0"
                      ? AssetImage(
                        "assets/images/profiles/profile${widget.user.profilePic}.PNG",
                      )
                      : null,
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:15),
              child: Text(
                "Vidéos",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator(color: green,)))
                : userVideos.isEmpty
                ? const Center(child: Text('No videos uploaded yet.'))
                : Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userVideos.length,
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 16,
                      ),
                      itemBuilder: (context, index) {
                        final video = userVideos[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => VideoPage(
                                      title: video.title,
                                      uploader: widget.user,
                                      videoUrl: video.videoUrl,
                                      videoId: video.id,
                                      likeCount: video.likesCount,
                                      refr: video.ref,
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Image.network(
                                    video.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                video.title,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}


