import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';

class PostRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(height: 10),
              const Text(
                "السلام عليكم ورحمة الله وبركاته",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Baarak Allah fik pour ton inscription !",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF029933),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "عilm Nafiع est une application qui vas te permettre par la grâce d’Allah سبحانه وتعالى "
                "d’apprendre ou d’en savoir plus, sur l’islam authentique « le Coran, la sunna du Messager ﷺ selon la "
                "compréhension des pieux prédécesseurs.",
                style: TextStyle(
                  fontSize: 16,
                  color: green,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Il y a aussi la mise en place de partage de vidéo pour espérer une sadaka Jariya ( صدقة جارية) in sha Allah.\n"
                "Qu’Allah nous facilite et accepte nos œuvres.\n",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "Amin !",
                style: TextStyle(
                  fontSize: 16,
                  color: green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
