class Uploader {
  final String id;
  final bool isAdmin;
  final String username;
  final String email;
  final String? profilePic;

  Uploader({
    required this.id,
    required this.isAdmin,
    required this.username,
    required this.email,
    this.profilePic,
  });

  factory Uploader.fromJson(Map<String, dynamic> json) {
    return Uploader(
      id: json['id'],
      isAdmin: json['isAdmin'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }
}
