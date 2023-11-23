import 'dart:convert';
import 'package:http/http.dart';
import 'package:griding/Entity/User.dart';

class ResponseDataUser {
  String message;
  User Data;
  String access_token;
  String token_type;

  ResponseDataUser({required this.message,required this.Data,required this.access_token,required this.token_type});

  factory ResponseDataUser.fromJson(Map<String, dynamic> json) {
    return ResponseDataUser(
      message: json['message'] ?? '',
      Data: User.fromJson(json['data']?? {}),
      access_token: json['access_token']??'' ,
      token_type: json['token_type'] ?? '',
    );
  }

}