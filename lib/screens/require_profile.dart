import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequireProfile extends StatefulWidget {
  const RequireProfile({super.key});

  @override
  State<RequireProfile> createState() => _RequireProfileState();
}

class _RequireProfileState extends State<RequireProfile> {
  Future<bool> getUserState() async {
    final prefs = await SharedPreferences.getInstance();
    String? uID = prefs.getString("loggedID");
    return uID != null && uID.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getUserState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return ProfileScreen();
        } else {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "Vous devez vous connecter pour pouvoir accéder à la page \"Profile\".",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/login");
                  },
                  child: const Text("Se connecter"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "Vous n'avez pas de compte?",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                     Navigator.of(context).pushReplacementNamed("/register");
                  },
                  child: const Text("Créer un compte"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
