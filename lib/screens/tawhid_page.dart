import 'dart:convert';

import 'package:_3ilm_nafi3/models/uploader.dart';
import 'package:_3ilm_nafi3/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:http/http.dart' as http;

import '../models/video.dart';

class TawhidPage extends StatefulWidget {
  const TawhidPage({super.key});

  @override
  State<TawhidPage> createState() => _TawhidPageState();
}

class _TawhidPageState extends State<TawhidPage> {
  late Future<List<Video>> videosFuture;

  @override
  void initState() {
    super.initState();
    videosFuture = fetchVideos("");
  }

  Future<List<Video>> fetchVideos(String themeId) async {
    final url = Uri.parse(
      'https://3ilmnafi3.digilocx.fr/api/videos/isvalid/theme/92a89d9e-ebf2-4ed3-9ce4-03d06f7a6690',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List videosJson = data['videos'];
      return videosJson.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
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
                  Image.asset("assets/images/1.jpg", fit: BoxFit.cover),
                  Center(
                    child: Text(
                      "Tawhid",
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
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: green,
                              content: SingleChildScrollView(
                                child: Center(
                                  child: Text(
                                    "\nCheikh Abderrazak Al Badr : \n\n"
                                    "« Le Tawhid est la pierre angulaire de la prédication des prophètes et des messagers comme Allah تعالى le dit :\n\n"
                                    "وَلَقَدْ بَعَثْنَا فِى كُلِّ أُمَّةٍ رَّسُولًا أَنِ ٱعْبُدُوا۟ ٱللَّهَ وَٱجْتَنِبُوا۟ ٱلطَّٰغُوتَ فَمِنْهُم مَّنْ هَدَى ٱللَّهُ وَمِنْهُم مَّنْ حَقَّتْ عَلَيْهِ ٱلضَّلَٰلَةُ فَسِيرُوا۟ فِى ٱلْأَرْضِ فَٱنظُرُوا۟ كَيْفَ كَانَ عَٰقِبَةُ ٱلْمُكَذِّبِينَ\n\n"
                                    "16 : 36 - Nous avons envoyé dans chaque communauté un Messager, [pour leur dire]: \"Adorez Allah et écartez-vous du Tagut\". Alors Allah en guida certains, mais il y en eut qui ont été destinés a l'égarement. Parcourez donc la terre, et regardez quelle fut la fin de ceux qui traitaient [Nos messagers] de menteurs.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    "Fermer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: green),
                      child: Text(
                        "A propos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: FutureBuilder<List<Video>>(
                          future: videosFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(color: green),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Veuillez vérifier votre connection et réessayez plus tard."),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("Aucune vidéo trouvée."),
                              );
                            }

                            final videos = snapshot.data!;

                            return GridView.builder(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                top: 50,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 0.8,
                                  ),
                              itemCount: videos.length,
                              itemBuilder: (context, index) {
                                final video = videos[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => VideoPage(
                                              videoId: video.id,
                                              videoUrl: video.videoUrl,
                                              title: video.title,
                                              uploader: Uploader(
                                                id: video.uploader['id'],
                                                isAdmin: false,
                                                username:
                                                    video.uploader['username']
                                                        .split(";")[0],
                                                email: "test",
                                                profilePic:
                                                    video.uploader['username']
                                                        .split(";")[2],
                                              ),
                                              likeCount: video.likesCount,
                                              refr: video.ref,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 9 / 16,
                                          child: Image.network(
                                            video.imageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite_border,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 4),
                                          Text(video.likesCount.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
