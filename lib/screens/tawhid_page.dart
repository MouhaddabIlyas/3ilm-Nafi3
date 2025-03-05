import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';

class TawhidPage extends StatefulWidget {
  const TawhidPage({super.key});

  @override
  State<TawhidPage> createState() => _TawhidPageState();
}

class _TawhidPageState extends State<TawhidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset("assets/images/1.jpg", fit: BoxFit.cover),
                  Center(
                    child: Text(
                      "Tawhid",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 30,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: green,
                              content: SingleChildScrollView(
                                child: Center(
                                  child: Text(
                                    "\nCheikh Abderrazak Al Badr : \n\n"
                                    "« Le Tawhid est la pierre angulaire de la prédication des prophètes et des messagers comme Allah تعالى le dit :\n\n"
                                    "وَلَقَدْ بَعَثْنَا فِى كُلِّ أُمَّةٍ رَّسُولًا أَنِ ٱعْبُدُوا۟ ٱللَّهَ وَٱجْتَنِبُوا۟ ٱلطَّٰغُوتَ فَمِنْهُم مَّنْ هَدَى ٱللَّهُ وَمِنْهُم مَّنْ حَقَّتْ عَلَيْهِ ٱلضَّلَٰلَةُ فَسِيرُوا۟ فِى ٱلْأَرْضِ فَٱنظُرُوا۟ كَيْفَ كَانَ عَٰقِبَةُ ٱلْمُكَذِّبِينَ\n\n"
                                    "16 : 36 - Nous avons envoyé dans chaque communauté un Messager, [pour leur dire]: \"Adorez Allah et écartez-vous du Tagut\". Alors Allah en guida certains, mais il y en eut qui ont été destinés a l'égarement. Parcourez donc la terre, et regardez quelle fut la fin de ceux qui traitaient [Nos messagers] de menteurs.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    "Fermer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: green),
                      child: Text(
                        "A propos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 35),
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
