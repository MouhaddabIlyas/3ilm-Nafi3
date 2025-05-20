import 'package:flutter/material.dart';

class VideoMetadataPage extends StatelessWidget {
  final String title;
  final String uploaderUsername;
  final String? ref;

  const VideoMetadataPage({
    super.key,
    required this.title,
    required this.uploaderUsername,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Mise en ligne par : $uploaderUsername',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
          
              Padding(
                padding: const EdgeInsets.only(top:25),
                child: Text(
                  'Intervenant : $ref',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
