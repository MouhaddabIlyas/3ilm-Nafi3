
class Video {
  final String id;
  final String title;
  final String videoUrl;
  final String uploaderId;
  final List<String> themes;
  final int likesCount;
  final String imageUrl;
  final String reference;

  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.uploaderId,
    required this.themes,
    required this.likesCount,
    required this.imageUrl,
    required this.reference,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    var themesFromJson = json['themes'] as List;
    List<String> themesList = themesFromJson.map((theme) => theme as String).toList();

    return Video(
      id: json['id'],
      title: json['title'],
      videoUrl: json['videoUrl'],
      uploaderId: json['uploaderId'],
      themes: themesList,
      likesCount: json['likesCount'],
      imageUrl: json['imageUrl'],
      reference: json['reference'],
    );
  }
}

class VideoTheme {
  final String name;
  final List<Video> videos;
  final List<Video> videosQueue;

  VideoTheme({
    required this.name,
    required this.videos,
    required this.videosQueue,
  });

  factory VideoTheme.fromJson(Map<String, dynamic> json) {
    var videoList = json['videos'] as List;
    List<Video> videoItems = videoList.map((i) => Video.fromJson(i)).toList();

    var videoQueueList = json['videosQueue'] as List;
    List<Video> videoQueueItems = videoQueueList.map((i) => Video.fromJson(i)).toList();

    return VideoTheme(
      name: json['name'],
      videos: videoItems,
      videosQueue: videoQueueItems,
    );
  }
}
