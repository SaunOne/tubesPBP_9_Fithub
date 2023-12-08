import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
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
  String photo;
  int trainerId;
  int memberId;

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
      required this.height,
      required this.photo,
      required this.trainerId,
      required this.memberId});

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
        height = 0.0,
        photo = '',
        trainerId = 0,
      memberId = 0;


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
      photo: json['photo'] ?? '',
      trainerId: json['trainer_id'] ?? 0,
      memberId: json['member_id'] ?? 0,
      
    );
  }
}
