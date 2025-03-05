import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:_3ilm_nafi3/constants.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class UploadPage extends StatefulWidget {
  final String videoPath;

  UploadPage({required this.videoPath});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  List<String> selectedThemes = [];
  File? _thumbnail;
  String? selectedScholar;
  String? selectedImam;

  bool isScholarExpanded = false;
  bool isImamExpanded = false;
  bool isCheikhSelected = false;
  bool isImamSelected = false;

  bool isThemeExpanded = false;

  bool isConsented = false;

  bool _isDialogOpen = false;

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _thumbnail = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
                    child: Center(
                      child: Text(
                        "Ajouter Une Vidéo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),

                  // Title Input
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Titre',
                      labelStyle: TextStyle(
                        color: _titleFocusNode.hasFocus
                            ? Colors.green
                            : Colors.black,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez insérer un titre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Theme Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Selectionnez 1 à 3 thèmes',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isThemeExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            isThemeExpanded = !isThemeExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                  if (isThemeExpanded)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: themes.map((theme) {
                        return ChoiceChip(
                          label: Text(
                            theme,
                            style: const TextStyle(fontSize: 10),
                          ),
                          selected: selectedThemes.contains(theme),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (selectedThemes.length < 3) {
                                  selectedThemes.add(theme);
                                }
                              } else {
                                selectedThemes.remove(theme);
                              }
                            });
                          },
                          selectedColor: Colors.green,
                          labelStyle: TextStyle(
                            color: selectedThemes.contains(theme)
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),

                  // Thumbnail Selector
                  const Text('Selectionnez un intervenant',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  // Scholar Selector
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheikhSelected,
                          onChanged: (value) {
                            setState(() {
                              isCheikhSelected = value!;
                              if (value) {
                                isImamSelected = false;
                              }
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        const Text("Savant"),
                        const SizedBox(width: 20),
                        Checkbox(
                          value: isImamSelected,
                          onChanged: (value) {
                            setState(() {
                              isImamSelected = value!;
                              if (value) {
                                isCheikhSelected = false;
                              }
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        const Text("Imam /\nTalibu Ilm"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Show Scholar Widget if Cheikh is selected
                  if (isCheikhSelected) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Sélectionnez 1 Savant',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isScholarExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              isScholarExpanded = !isScholarExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                    if (isScholarExpanded)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: scholars.map((scholar) {
                          return ChoiceChip(
                            label: Text(
                              scholar,
                              style: const TextStyle(fontSize: 10),
                            ),
                            selected: selectedScholar == scholar,
                            onSelected: (selected) {
                              setState(() {
                                selectedScholar = selected ? scholar : null;
                              });
                            },
                            selectedColor: Colors.green,
                            labelStyle: TextStyle(
                              color: selectedScholar == scholar
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          );
                        }).toList(),
                      ),
                  ],

                  // Show Imam Widget if Imam is selected
                  if (isImamSelected) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Sélectionnez 1 Imam',
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isImamExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              isImamExpanded = !isImamExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                    if (isImamExpanded)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: imams.map((imam) {
                          return Material(
                            color: Colors
                                .transparent,
                            child: ChoiceChip(
                              label: Text(
                                imam,
                                style: const TextStyle(fontSize: 10),
                              ),
                              selected: selectedImam == imam,
                              onSelected: (selected) {
                                setState(() {
                                  selectedImam = selected ? imam : null;
                                });
                              },
                              selectedColor:
                                  Colors.green,
                              labelStyle: TextStyle(
                                color: selectedImam == imam
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                  const SizedBox(height: 20),

                  // Thumbnail Selector
                  const Text('Selectionnez une couverture pour votre vidéo',
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _thumbnail == null
                            ? const Center(child: Text('Choisir couverture'))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _thumbnail!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: isConsented,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isConsented = newValue!;
                          });
                        },
                        activeColor: green,
                      ),
                      Flexible(
                        child: Text(
                          'Je confirme avoir lu les conditions pour pouvoir poster ma vidéo',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedThemes.isNotEmpty &&
                            _thumbnail != null &&
                            (selectedScholar != null || selectedImam != null) &&
                            (isCheikhSelected || isImamSelected) &&
                            isConsented) {
                          // Proceed to upload video and thumbnail
                          print(
                              'Uploading video with title: ${_titleController.text}');
                          print('Selected Themes: $selectedThemes');
                          if (selectedScholar != null && isCheikhSelected) {
                            print('Selected Scholar: $selectedScholar');
                          } else {
                            print('Selected Imam: $selectedImam');
                          }
                          
                          print('Thumbnail Path: ${_thumbnail!.path}');
                          Navigator.of(context).pushNamed('/home');
                  //Navigator.pushReplacementNamed(context, '/home');
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
                                "Votre vidéo a été envoyée pour être visualisée par notre équipe administrative avant d'être approuvée. Cela peut prendre du temps. Vous pouvez continuer à utiliser l'application.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
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
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Veuillez remplir tous les champs!')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 30.0),
                        child: Text('Télécharger Vidéo',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
