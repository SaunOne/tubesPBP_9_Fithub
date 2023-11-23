import 'package:flutter/material.dart';

class User {
  int id;
  String fullname;
  String username;
  String email;
  String password;
  String birthdate;
  String gender;


  User({required this.id,required this.fullname,required this.username,required this.email,required this.password,
    required this.birthdate,required this.gender});

  User.empty()
      : id = 0,
        fullname = '',
        username = '',
        email = '',
        password = '',
        birthdate = '',
        gender = '';


  factory User.fromJson(Map<String, dynamic> json) {
    json = json['user'] ?? json;

    return User(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      birthdate: json['birthdate'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}