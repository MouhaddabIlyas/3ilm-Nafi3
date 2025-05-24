import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    Timer(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      String? isAdmin = prefs.getString("admin");
      if (isAdmin == "yes") {
        Navigator.pushReplacementNamed(context, "/adminConsole");
      } else {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/transparent.jpg'),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 30.0,
              ),
              child: Image.asset('assets/images/aya.png'),
            ),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
