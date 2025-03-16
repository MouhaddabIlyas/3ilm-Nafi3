import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/models/user.dart';
import 'package:_3ilm_nafi3/screens/upload_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User?> fetchUserData() async {
  final prefs = await SharedPreferences.getInstance();
  String? userID = prefs.getString("loggedID");

  final url = Uri.parse(
    'http://3ilmnafi3.fony5290.odns.fr/api/users/${userID}',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User?> user;

  @override
  void initState() {
    super.initState();
    user = fetchUserData();
  }

  final picker = ImagePicker();
  Future<void> pickVideo(BuildContext context) async {
    final XFile? pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      print('Picked video: ${pickedFile.path}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadPage(videoPath: pickedFile.path),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Aucune vidéo sélectionnée')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<User?>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: green));
            }

            if (snapshot.hasError) {
              //return Center(child: Text('Error: ${snapshot.error}'));
              return Center(
                child: Text(
                  'Ce service présente un problème actuellement. Veuillez réessayer plus tard.',
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(child: Text('No user data found.'));
            }

            final user = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Mon Profil",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 3 * MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 4,
                      right: MediaQuery.of(context).size.width / 4,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child:
                          user.username.split(";")[2] == "0"
                              ? Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100,
                              )
                              : null,
                      backgroundImage:
                          user.username.split(";")[2] != "0"
                              ? AssetImage(
                                "assets/images/small_profiles/profile${user.username.split(";")[2]}.PNG",
                              )
                              : null,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 30, left: 35),
                    child: Text(
                      "Nom d'utilisateur",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 30, left: 55),
                    child: Text(user.username.split(";")[0]),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushNamed('/video_page');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: const EdgeInsets.all(20),
                      color: green,
                      child: const Row(
                        children: [
                          Icon(Icons.videocam, color: Colors.white),
                          SizedBox(width: 15),
                          Text(
                            "Mes vidéos",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      pickVideo(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: const EdgeInsets.all(20),
                      color: green,
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 15),
                          Text(
                            "Ajouter une vidéo",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: const EdgeInsets.all(20),
                      color: const Color.fromARGB(255, 198, 17, 4),
                      child: const Row(
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.white),
                          SizedBox(width: 15),
                          Text(
                            "Se Déconnecter",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
