import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/screens/post_register_screen.dart';
import 'package:_3ilm_nafi3/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  bool _isVerifyPasswordVisible = false;
  bool _isDialogOpen = false;
  String _selectedProfilePicture = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    _emailController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> saveValues(String username, String password) async {
    final url = Uri.parse(
      'http://3ilmnafi3.fony5290.odns.fr/api/users',
    );
    final response = await http.get(url);
    var data = jsonDecode(response.body);

    var loggedUser;
    for (var element in data) {
      if (element["username"].contains(username) &&
          element["username"].contains(password)) {
        loggedUser = element;
        break;
      }
    }

    String loggedID = "";

    if (loggedUser != null) {
      loggedID = loggedUser["id"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("loggedID", loggedID);
      await prefs.setString("admin", "no");
    }
  }

  void _login(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
    } else {
      saveValues(_usernameController.text, _passwordController.text);
      Navigator.pushReplacementNamed(context, '/home');

      setState(() {
        _isDialogOpen = true;
      });
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(color: Colors.white, child: PostRegisterPage()),
          );
        },
      ).then((_) {
        setState(() {
          _isDialogOpen = false;
        });
      });
    }
  }

  Future<void> _uploadUser(User user) async {
    final url = Uri.parse(
      'http://3ilmnafi3.fony5290.odns.fr/api/users',
    ); 

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type':
              'application/json',
        },
        body: json.encode(user.toJson()), 
      );

      if (response.statusCode == 201) {
        print('User created successfully');
        _login(context);
      } else {
        print('Failed to create user: ${response.statusCode}');
        print(
          response.body,
        ); 
      }
    } catch (e) {
      print('Errors: $e');
    }
  }

  void _createAccount() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final verifyPassword = _verifyPasswordController.text;

    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        password == verifyPassword &&
        (email.contains("gmail.com") || email.contains("hotmail"))) {
      print('Username: $username, Email: $email, Password: $password');
      print('Selected Profile Picture: $_selectedProfilePicture');

      User user = User(
        username:
            "$username;$password;${_selectedProfilePicture != "" ? _selectedProfilePicture.split("profile")[2].split(".")[0] : "0"}",
        email: email,
        passwordHash: password,
      );
      await _uploadUser(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez vérifier vos informations.')),
      );
    }
  }

  void _selectProfilePicture() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Selectionner photo de profile"),
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
                      _selectedProfilePicture =
                          'assets/images/profiles/profile${index + 1}.PNG';
                    });
                    Navigator.pop(context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/transparent.png', height: 150),

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

              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
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
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Verify Password Field
              TextField(
                controller: _verifyPasswordController,
                obscureText: !_isVerifyPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Vérifier le mot de passe',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isVerifyPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isVerifyPasswordVisible = !_isVerifyPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Profile Picture Section
              GestureDetector(
                onTap: _selectProfilePicture,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        _selectedProfilePicture.isEmpty
                            ? null
                            : AssetImage(_selectedProfilePicture),
                    backgroundColor: Colors.white,
                    child:
                        _selectedProfilePicture.isEmpty
                            ? Icon(
                              Icons.account_circle,
                              size: 70,
                              color: Colors.black,
                            )
                            : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déjà un compte? ",
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  GestureDetector(
                    onTap:
                        () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Se Connecter!',
                      style: TextStyle(color: green, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed:
                    () => _createAccount(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  'Créer le Compte',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
