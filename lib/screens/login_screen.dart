import 'dart:convert';

import 'package:_3ilm_nafi3/models/user.dart';
import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<User?> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("loggedID");
    final url = Uri.parse(
      'https://3ilmnafi3.digilocx.fr/api/users/${userID}',
    ); 
    final response = await http.get(url);

    if (response.statusCode == 200) {
      
      return User.fromJson(json.decode(response.body));
    } else {
      
      throw Exception('Failed to load user data');
    }
  }

  bool _isDialogOpen = false;

  late Future<User?> user;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> saveValues(String userID, String isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("loggedID", userID);
    await prefs.setString("admin", isAdmin);
  }

  void _login(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
    } else {
     
      final url = Uri.parse(
        'https://3ilmnafi3.digilocx.fr/api/users',
      ); 
      final response = await http.get(url);
      var data = jsonDecode(response.body);

      var loggedUser;
      for (var element in data) {
        if (element["username"].contains("/${_usernameController.text};") &&
            element["username"].contains(";${_passwordController.text};")) {
          loggedUser = element;
          break;
        }
      }

      if (loggedUser != null) {
        if (loggedUser["username"].contains("admin")) {
          saveValues(loggedUser["id"], "yes");
          Navigator.pushReplacementNamed(context, '/adminConsole');
        } else {
          saveValues(loggedUser["id"], "no");
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nom d'utilisateur ou mot de passe incorrect."),
          ),
        );
      }

      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => FutureBuilder<User?>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the response, show a loading indicator
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: Text('No user data found.'));
                  }

                  final user = snapshot.data!;

                  
                  return Container();
                },
              ),
        ),
      );
*/
      /*
      Navigator.pushReplacementNamed(context, '/home');
      // Dialog TEST
      setState(() {
        _isDialogOpen = true;
      });
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              color: Colors.white,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Text(
                    "Félicitations!\nVotre vidéo a été approuvée!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          _isDialogOpen = false;
        });
      });
      // Dialog TEST END
    */
    }
  }

  void _createAccount() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      print('Username: $username, Password: $password');
    } else {
      print('Please enter a username and password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/transparent.jpg', height: 150),

            // Username Field
            TextField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                labelStyle: TextStyle(
                  color:
                      _usernameFocusNode.hasFocus
                          ? Colors.orange
                          : Colors.black,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(
                  color:
                      _passwordFocusNode.hasFocus
                          ? Colors.orange
                          : Colors.black,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Create Account Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nouvel utilisateur? ",
                  style: TextStyle(color: Colors.black, fontSize: 11),
                ),
                GestureDetector(
                  onTap: //_createAccount,
                      () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Text(
                    'Créer un compte!',
                    style: TextStyle(color: green, fontSize: 11),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Login Button
            ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'Se Connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
