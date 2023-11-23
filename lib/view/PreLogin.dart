import 'package:flutter/material.dart';
import 'package:griding/constant/color.dart';
import 'package:griding/Component/EllipsShape.dart';
import 'package:griding/view/Login.dart';
import 'package:griding/view/Register.dart';
class PreLogin extends StatefulWidget {
  const PreLogin({super.key});

  @override
  State<PreLogin> createState() => _HomeState();
}

class _HomeState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.7 * height,
                  child: EllipsShape(height, width, 0.6),
                ),
                //img
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 0.58 * height),
                child: const Column(
                  children: [
                    Text(
                      "Join Us Today",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Enter Your details to proceed further",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ),
            ),
            Button(height),
            Logo(height: height, width: width),
          ]
        ),
      ),
    );
  }


  Center Button(double height) {
    return Center(
            child: Container(
             margin: EdgeInsets.only(top: 0.69 * height),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      backgroundColor: ColorPallete.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      backgroundColor: ColorPallete.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    child: const Text("Sign Up"),
                  ),
                ],
              )
            ),
          );
  }
}



class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 90, 50, 50),
      child: Image.asset(
        "Assets/logo2.jpg",
        fit: BoxFit.cover,
        alignment: Alignment.center,
        height: 0.3 * height,
        width: 0.8 * width,
      ),
    );
  }
}


