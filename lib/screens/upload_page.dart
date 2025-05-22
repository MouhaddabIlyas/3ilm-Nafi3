import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:_3ilm_nafi3/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> createNewVideo({
  required String title,
  required String videoUrl,
  required String uploaderId,
  required List<String?> themes,
  required String? imageUrl,
  required String ref,
}) async {
  final url = Uri.parse('https://3ilmnafi3.digilocx.fr/api/videos');

  final body = jsonEncode({
    "title": title,
    "videoUrl": videoUrl,
    "uploaderId": uploaderId,
    "themes": themes,
    "imageUrl": imageUrl,
    "reference": ref,
  });

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("✅ Video created successfully.");
      return true;
    } else {
      print("❌ Failed to create video: ${response.statusCode}");
      print("Body: ${response.body}");
      return false;
    }
  } catch (e) {
    print("❌ Error creating video: $e");
    return false;
  }
}

Future<String?> uploadVideo(String filePath) async {
  final url = Uri.parse(
    'https://3ilmnafi3.digilocx.fr/api/upload/upload-media',
  );
  final request = http.MultipartRequest('POST', url);

  final file = await http.MultipartFile.fromPath(
    'video',
    filePath,
    filename: basename(filePath),
    contentType: MediaType('video', 'mp4'),
  );

  request.files.add(file);

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      final videoUrl = data['video'] as String?;

      return videoUrl;
    } else {
      print('Upload failed');
      print('Body: ${response.body}');
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      final videoUrl = data['video'] as String?;

      return videoUrl;
    }
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}

Future<String?> uploadImage(String filePath) async {
  final url = Uri.parse(
    'https://3ilmnafi3.digilocx.fr/api/upload/upload-media',
  );
  final request = http.MultipartRequest('POST', url);

  final extension = extensionFromPath(filePath).toLowerCase();
  final mediaType = getMediaTypeForExtension(extension);

  final file = await http.MultipartFile.fromPath(
    'image', 
    filePath,
    filename: basename(filePath),
    contentType: mediaType,
  );

  request.files.add(file);

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final imageUrl = responseData['data']?['image'];
      return imageUrl;
    } else {
      final responseData = jsonDecode(response.body);
      final imageUrl = responseData['data']?['image'];
      return imageUrl;
    }
  } catch (e) {
    print('Image upload error: $e');
    return null;
  }
}

String extensionFromPath(String filePath) {
  return extension(filePath).replaceFirst('.', '');
}

MediaType getMediaTypeForExtension(String ext) {
  switch (ext) {
    case 'png':
      return MediaType('image', 'png');
    case 'jpeg':
    case 'jpg':
      return MediaType('image', 'jpeg');
    case 'gif':
      return MediaType('image', 'gif');
    case 'webp':
      return MediaType('image', 'webp');
    case 'bmp':
      return MediaType('image', 'bmp');
    case 'tiff':
    case 'tif':
      return MediaType('image', 'tiff');
    default:
      return MediaType('application', 'octet-stream'); // fallback
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
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

  late String thumbnailUrl;

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() async {
        _thumbnail = File(pickedFile.path);
        thumbnailUrl = pickedFile.path;
      });
    }
  }

  Future<void> uploadWithDialog(
    BuildContext context,
    String filePath,
    String vTitle,
    List<String?> tIDS,
    String rf,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Téléchargement"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: green),
              SizedBox(height: 16),
              Text("Veuillez ne pas fermer l'application..."),
            ],
          ),
        );
      },
    );

    
    final imageUrl = await uploadImage(thumbnailUrl);
    final result = await uploadVideo(filePath);

    final prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("loggedID");

    
    Navigator.of(context).pop();

    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text(
              result != null
                  ? "Téléchargement réussit!"
                  : "Téléchargement échoué",
            ),
            content: Text(
              result != null
                  ? "Votre video a été envoyée pour confirmation par notre équipe administrative."
                  : "Veuillez réessayer plus tard.",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (result != null) {
                    await createNewVideo(
                      title: vTitle,
                      videoUrl: result,
                      imageUrl: imageUrl,
                      themes: tIDS,
                      uploaderId: userID!,
                      ref: rf,
                    );
                    Navigator.of(
                      context,
                    ).pushReplacementNamed('/home');
                  }
                },
                child: Text("OK", style: TextStyle(color: green)),
              ),
            ],
          ),
    );
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Flexible(
                          flex: 5,
                          child: const Text(
                            "Ajouter Une Vidéo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Title Input
                  TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Titre',
                      labelStyle: TextStyle(
                        color:
                            _titleFocusNode.hasFocus
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
                      children:
                          themes.map((theme) {
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
                                color:
                                    selectedThemes.contains(theme)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            );
                          }).toList(),
                    ),
                  const SizedBox(height: 20),

                  // Thumbnail Selector
                  const Text(
                    'Selectionnez un intervenant',
                    style: TextStyle(fontSize: 16),
                  ),
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
                        children:
                            scholars.map((scholar) {
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
                                  color:
                                      selectedScholar == scholar
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
                        children:
                            imams.map((imam) {
                              return Material(
                                color: Colors.transparent,
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
                                  selectedColor: Colors.green,
                                  labelStyle: TextStyle(
                                    color:
                                        selectedImam == imam
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
                  const Text(
                    'Selectionnez une couverture pour votre vidéo',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.8 * 1.6,
                        width: MediaQuery.of(context).size.width * 0.8 * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child:
                            _thumbnail == null
                                ? const Center(
                                  child: Text(
                                    'Choisir couverture\n(Doit être en ratio 9:16)',
                                  ),
                                )
                                : AspectRatio(
                                  aspectRatio: 9 / 16,
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
                          List<String?> thIDs = [];
                          for (String t in selectedThemes) {
                            thIDs.add(themesIDs[t]?["id"]);
                          }

                          String? r = selectedScholar ?? selectedImam;

                          uploadWithDialog(
                            context,
                            widget.videoPath,
                            _titleController.text,
                            thIDs,
                            r!,
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 30.0,
                        ),
                        child: Text(
                          'Télécharger Vidéo',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
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
