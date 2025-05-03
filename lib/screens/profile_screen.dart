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

Future<void> updatePic(
  String username,
  String password,
  String newPic,
  String isAdmin,
) async {
  final prefs = await SharedPreferences.getInstance();
  String? userID = prefs.getString("loggedID");

  final url = Uri.parse(
    'http://3ilmnafi3.fony5290.odns.fr/api/users/${userID}',
  );

  final body =
      isAdmin == "admin"
          ? jsonEncode({
            'username': '${username};${password};${newPic};${isAdmin}',
          })
          : jsonEncode({'username': '${username};${password};${newPic}'});

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response.statusCode == 200) {
    print('Username updated successfully');
  } else {
    print('Failed to update username: ${response.body}');
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User?> user;

  void _selectProfilePicture(String u, String p, String a) {
    String _selectedProfilePicture = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Changer photo de profile"),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 34,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedProfilePicture = '${index + 1}';
                      updatePic(u, p, _selectedProfilePicture, a);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Veuillez rafraichir la page.',
                                  ),
                                ),
                              );
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profiles/profile${index + 1}.PNG',
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

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
                    child: Stack(
                      children: [
                        // Profile Picture
                        Positioned.fill(
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
                        // Edit Button
                        Positioned(
                          bottom: 25,
                          right: 0,
                          child: IconButton(
                            onPressed: () async {
                              String admin = "";
                              try {
                                admin = user.username.split(";")[3];
                              } catch (e) {}
                              _selectProfilePicture(
                                user.username.split(";")[0],
                                user.username.split(";")[1],
                                admin,
                              );
                              
                              print("Change profile picture tapped");
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
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
                      try {
                        pickVideo(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Veuillez réessayer plus tard.'),
                          ),
                        );
                      }
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
                      //Navigator.pop(context);
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
