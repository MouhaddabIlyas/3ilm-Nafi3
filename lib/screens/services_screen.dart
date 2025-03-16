import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:_3ilm_nafi3/constants.dart';

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<bool> isExpandedList = List.generate(
    services_titles.length,
    (_) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Nos Services",
            style: TextStyle(color: Colors.orange, fontSize: 32),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: services_titles.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(services_titles[index]),
                      trailing: AnimatedRotation(
                        turns: isExpandedList[index] ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      onTap: () {
                        setState(() {
                          isExpandedList[index] = !isExpandedList[index];
                        });
                      },
                    ),
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child:
                          isExpandedList[index]
                              ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      services_images[index],
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap:
                                          () => launchURL(
                                            services_links[index],
                                            index,
                                          ),
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              index == 1
                                                  ? ''
                                                  : 'Visiter: ', // Replace "Visit" with empty string for the second service
                                          style: TextStyle(
                                            color: Colors.black,
                                          ), // Default text color
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: services_links[index],
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap =
                                                        () => launchURL(
                                                          services_links[index],
                                                          index,
                                                        ), // Handle tap
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : SizedBox.shrink(),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green, // Using the green color from constants
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                launchURL("https://www.instagram.com/digilocx/");
              },
              child: Text(
                "Proposer mon service",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String url, [int index = -1]) async {
    final Uri uri = Uri.parse(url);

    print("Trying to launch URL: $url");

    if (index == 1) {
      // Special case for the second link (Whatsapp)
      final Uri whatsappUri = Uri.parse("https://wa.me/212674281752");
      if (await canLaunch(whatsappUri.toString())) {
        print("Launching WhatsApp...");
        await launch(whatsappUri.toString());
      } else {
        print("Could not launch WhatsApp");
      }
      return;
    }

    // General URL launch
    if (await canLaunchUrl(uri)) {
      print("Launching URL: $url");
      await launchUrl(uri);
    } else {
      print("Could not launch $url");
    }
  }
}
