import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ugd6_b_9/routes/routes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_b_9/routes/GeneratorRoutes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  Future<bool> checkLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can return a loading indicator here if needed
          return CircularProgressIndicator();
        } else {
          return ProviderScope(
            child: MaterialApp(

              initialRoute: snapshot.data ?? false ? Routes.homePage : Routes.preLogin,

              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          );  
        }
      },
    );
  }
}

