import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/generate_qr/generate_qr_page.dart';
import 'package:ugd6_b_9/view/content/gridGuide.dart';
import 'package:ugd6_b_9/qr_scan/scan_qr_page.dart';
import 'package:ugd6_b_9/timer.dart';
import 'package:ugd6_b_9/view/feature/calender.dart';
import 'package:ugd6_b_9/view/feature/camera.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/content/inputGerakanGym.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/login.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/register.dart';
import 'package:ugd6_b_9/view/feature/track.dart';
import 'package:ugd6_b_9/view/showGym.dart';

void main(){  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ResponsiveSizer(builder: (context,orientation,screenType){
      return MaterialApp(
      initialRoute: Routes.login,
      routes: {
        // Routes.trackPage: (context) => TrackPage(),
        Routes.login: (context) => const Login(),
        Routes.register: (context) => Register(),
        Routes.homePage: (context) => const HomePage(),
        Routes.previewPage: (context) => const ProfileView(),
        Routes.profilePage: (context) => const ProfileView(),
        Routes.trackPage: (context) => const TrackPage(),
        Routes.timerPage: (context) => const Timer(), 
        Routes.gridGuidePage: (context) => const GridGuide(),
        Routes.detailGuidePage: (context) => const Guide(),
        Routes.scanPage:(context) => const BarcodeScannerPageView(),
        Routes.generateQr: (context) => const GenerateQRPage(), 
        Routes.calendarScreen: (context) =>  CalendarScreen(),   
      });
    })
  );
}



