import 'package:flutter_test/flutter_test.dart';

class User {
  final String username;
  final String email;
  final String? passwordHash; 

  User({
    required this.username,
    required this.email,
    
    required this.passwordHash,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      passwordHash: json['passwordHash'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': passwordHash,
    };
  }
}

