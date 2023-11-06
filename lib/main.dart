import 'package:flutter/material.dart';
import 'package:ugd6_b_9/timer.dart';
import 'package:ugd6_b_9/view/camera.dart';
import 'package:ugd6_b_9/homePage.dart';
import 'package:ugd6_b_9/view/inputGerakanGym.dart';
import 'package:ugd6_b_9/view/login.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/register.dart';
import 'package:ugd6_b_9/view/track.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: Routes.homePage,
      routes: {
        // Routes.trackPage: (context) => TrackPage(),
        Routes.login: (context) => const Login(),
        Routes.register: (context) => Register(),
        Routes.homePage: (context) => HomePage(),
        Routes.previewPage: (context) => const ProfileView(),
        Routes.profilePage: (context) => const ProfileView(),
        Routes.trackPage: (context) => const TrackPage(),
        Routes.timerPage: (context) => const Timer(), 
      },
    ),
  );
}



