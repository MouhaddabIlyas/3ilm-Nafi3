import 'package:flutter/material.dart';

class AdminVideoPage extends StatelessWidget {
  const AdminVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 3 * MediaQuery.of(context).size.width / 4,
          child: Text(
            "Il n'y a aucune vidéo en attente pour le moment. Bon travail!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
