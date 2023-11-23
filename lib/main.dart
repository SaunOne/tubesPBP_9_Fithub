import 'package:flutter/material.dart';
import 'package:griding/view/PreLogin.dart';
import 'package:griding/route/Routes.dart';
import 'package:griding/view/Login.dart';
import 'package:griding/view/NewPassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     home: PreLogin(),
    );
  }
}

