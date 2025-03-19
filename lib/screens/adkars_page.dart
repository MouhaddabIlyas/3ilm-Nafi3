import 'package:_3ilm_nafi3/constants.dart';
import 'package:flutter/material.dart';

class AdkarsPage extends StatefulWidget {
  const AdkarsPage({super.key});

  @override
  State<AdkarsPage> createState() => _AdkarsPageState();
}

class _AdkarsPageState extends State<AdkarsPage> {
  int tasbihs = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(color: green),
            Text("A venir..."),
            Text(
              "En attendant, voici un Tasbih pour se souvenir d'Allah",
              textAlign: TextAlign.center,
            ),
            Text(
              "{وَاذْكُرُوا اللَّهَ كَثِيرًا لَعَلَّكُمْ تُفْلِحُونَ}",
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            Text(
              "سبحان الله\n"
              "الحمد لله\n"
              "الله أكبر\n"
              "لا إله إلا الله\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),

            //SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
