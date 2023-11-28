import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/view/PreLogin.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/generate_qr/generate_qr_page.dart';
import 'package:ugd6_b_9/view/content/detailTrainer.dart';
import 'package:ugd6_b_9/view/content/gridGuide.dart';
import 'package:ugd6_b_9/qr_scan/scan_qr_page.dart';
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
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/register.dart';
import 'package:ugd6_b_9/view/feature/track.dart';
import 'package:ugd6_b_9/view/showGym.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_b_9/routes/GeneratorRoutes.dart';


import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return const MaterialApp(
            initialRoute: Routes.preLogin,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}


