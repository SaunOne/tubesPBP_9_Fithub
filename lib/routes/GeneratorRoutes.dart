import 'package:flutter/material.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/testing.dart';
import 'package:ugd6_b_9/view/PreLogin.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/generate_qr/generate_qr_page.dart';
import 'package:ugd6_b_9/view/content/detailTrainer.dart';
import 'package:ugd6_b_9/view/content/gridGuide.dart';
import 'package:ugd6_b_9/qr_scan/scan_qr_page.dart';
import 'package:ugd6_b_9/view/content/paymentView.dart';
import 'package:ugd6_b_9/view/content/searchGym.dart';
import 'package:ugd6_b_9/view/content/subcriptionView.dart';
import 'package:ugd6_b_9/view/feature/timer.dart';
import 'package:ugd6_b_9/view/content/notificationView.dart';
import 'package:ugd6_b_9/view/content/trainerView.dart';
import 'package:ugd6_b_9/view/feature/calender.dart';
import 'package:ugd6_b_9/view/feature/camera.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/login.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/profile.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/register.dart';
import 'package:ugd6_b_9/view/feature/track.dart';
import 'package:ugd6_b_9/view/showGym.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_b_9/view/NewPassword.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => Register());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.previewPage:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.trackPage:
        return MaterialPageRoute(builder: (_) => const TrackPage());
      case Routes.timerPage:
        return MaterialPageRoute(builder: (_) => const Timer());
      case Routes.gridGuidePage:
        return MaterialPageRoute(builder: (_) => const GridGuide());
      case Routes.detailGuidePage:
        return MaterialPageRoute(builder: (_) => const Guide());
      case Routes.scanPage:
        return MaterialPageRoute(
            builder: (_) => const BarcodeScannerPageView());
      case Routes.generateQr:
        return MaterialPageRoute(builder: (_) => const GenerateQRPage());
      case Routes.calendarScreen:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case Routes.trainerView:
        return MaterialPageRoute(builder: (_) => const TrainerView());
      case Routes.notificationView:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      // case Routes.detailTrainer:
      //   return MaterialPageRoute(builder: (_) => const DetailTrainer());
      case Routes.preLogin:
        return MaterialPageRoute(builder: (_) => const PreLogin());
      
      case Routes.newPass:
        return MaterialPageRoute(builder: (_) => const NewPassword());

      case Routes.paymentView:
        // return MaterialPageRoute(builder: (_) => const PaymentPage());
      case Routes.searchGym:
        return MaterialPageRoute(builder: (_) =>  SearchGym(id: 1,));
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const Profile());

      case Routes.testQuery:
        return MaterialPageRoute(builder: (_) =>  TestQuery());


      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
