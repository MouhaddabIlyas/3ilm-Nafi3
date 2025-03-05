import 'package:flutter/material.dart';

class KnowledgeTestPage extends StatefulWidget {
  @override
  _KnowledgeTestPageState createState() => _KnowledgeTestPageState();
}

class _KnowledgeTestPageState extends State<KnowledgeTestPage> {
  
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? answer5;

  
  bool get allAnswersCorrect {
    return answer1 == 'je suis salafi' &&
        answer2 == 'Au dessus de son trône' &&
        answer3 == 'Salafi' &&
        answer4 == 'leurs obéir dans le bien' &&
        answer5 == 'Vrai';
  }

  
  void handleCompleteTest() {
    
    if (allAnswersCorrect) {
      _showResultDialog(
        "Baarak Allahu fik, tu peux mettre tes vidéos, ta vidéo est en train d'être téléchargée. toute vidéo qui contredit le minhaj salaf sera supprimée.",
        true, 
      );
    } else {
      _showResultDialog(
        "Baarak Allahu fik mais tu ne peux pas mettre de vidéo pour l’instant.",
        false, 
      );
    }
  }

  
  void _showResultDialog(String message, bool success) {
    // Close the dialog first
    Navigator.pop(context);

    
    if (success) {
      _upload();
    }

   
    Navigator.pushReplacementNamed(context, '/home');

    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }

  
  void _upload() {
    print("Upload executed");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1) Quelle est ta croyance ?'),
              RadioListTile<String>(
                title: Text('je suis salafi'),
                value: 'je suis salafi',
                groupValue: answer1,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer1 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('je suis soufi'),
                value: 'je suis soufi',
                groupValue: answer1,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer1 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('je suis ash3ari'),
                value: 'je suis ash3ari',
                groupValue: answer1,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer1 = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('2) Où est Allah ?'),
              RadioListTile<String>(
                title: Text('Partout'),
                value: 'Partout',
                groupValue: answer2,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer2 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Au dessus de son trône'),
                value: 'Au dessus de son trône',
                groupValue: answer2,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer2 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Dans nos coeurs'),
                value: 'Dans nos coeurs',
                groupValue: answer2,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer2 = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('3) Quel savant suis-tu ?'),
              RadioListTile<String>(
                title: Text('Ash3ari'),
                value: 'Ash3ari',
                groupValue: answer3,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer3 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('ikhwani'),
                value: 'ikhwani',
                groupValue: answer3,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer3 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Salafi'),
                value: 'Salafi',
                groupValue: answer3,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer3 = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('4) Quel est le devoir envers les gouverneurs ?'),
              RadioListTile<String>(
                title: Text('faire des manifestations'),
                value: 'faire des manifestations',
                groupValue: answer4,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer4 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('les combattre'),
                value: 'les combattre',
                groupValue: answer4,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer4 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('leurs obéir dans le bien'),
                value: 'leurs obéir dans le bien',
                groupValue: answer4,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer4 = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text('5) La Sounna est appelée la 2em révélation ?'),
              RadioListTile<String>(
                title: Text('Vrai'),
                value: 'Vrai',
                groupValue: answer5,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer5 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Faux'),
                value: 'Faux',
                groupValue: answer5,
                activeColor: Colors.orange, 
                onChanged: (String? value) {
                  setState(() {
                    answer5 = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleCompleteTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, 
                ),
                child: Text(
                  'Compléter mon test',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
