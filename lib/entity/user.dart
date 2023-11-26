import 'package:flutter/material.dart';

class User {
  int id;
  String fullname;
  String username;
  String email;
  String password;
  String birthdate;
  String gender;
  String phone;
  double weight;
  double height;

  User(
      {required this.id,
      required this.fullname,
      required this.username,
      required this.email,
      required this.password,
      required this.birthdate,
      required this.gender,
      required this.phone,
      required this.weight,
      required this.height});

  User.empty()
      : id = 0,
        fullname = '',
        username = '',
        email = '',
        password = '',
        birthdate = '',
        gender = '',
        phone = '',
        weight = 0.0,
        height = 0.0;

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
      phone: json['phone'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
    );
  }
}
