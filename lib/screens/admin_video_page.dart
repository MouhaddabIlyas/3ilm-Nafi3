import 'package:flutter/material.dart';

class AdminVideoPage extends StatelessWidget {
  const AdminVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 3 * MediaQuery.of(context).size.width / 4,
              child: Text(
                "Il n'y a aucune vidéo en attente pour le moment. Bon travail!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 35),
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
