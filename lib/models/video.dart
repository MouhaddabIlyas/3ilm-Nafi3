import 'package:_3ilm_nafi3/models/uploader.dart';

class Video {
  final String id;
  final String title;
  final String imageUrl;
  final int likesCount;
  final String videoUrl;
  final Map<String, dynamic> uploader;
  late String? ref;
  late bool? isValid;
  late List? themes;

  Video({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.likesCount,
    required this.videoUrl,
    required this.uploader,
    this.ref,
    this.isValid,
    this.themes,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      likesCount: json['likesCount'],
      videoUrl: json['videoUrl'],
      uploader: json['uploader'],
      ref: json['reference'],
      isValid: json['isValid'],
      themes: json['themes'],
    );
  }
}
