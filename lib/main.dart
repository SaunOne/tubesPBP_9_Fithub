import 'package:flutter/material.dart';
import 'package:ugd6_b_9/view/camera.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/inputGerakanGym.dart';
import 'package:ugd6_b_9/view/login.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/register.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: Routes.login,
      routes: {
        Routes.login: (context) => const Login(),
        Routes.register: (context) => Register(),
        Routes.homePage: (context) => HomePage(),
        Routes.previewPage: (context) => const ProfileView(),
        Routes.profilePage: (context) => const ProfileView(),
      },
    ),
  );
}



