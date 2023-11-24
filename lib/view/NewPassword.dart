import 'package:flutter/material.dart';
import 'package:griding/constant/color.dart';
import 'package:griding/dataBaseQuery/Auth.dart';
import 'package:griding/view/Login.dart';
import 'package:griding/constant/url.dart';
import 'package:griding/dataBaseQuery/Query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmationController = TextEditingController();
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  late String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEmail();
  }

  void loadEmail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      email = localStorage.getString('email')!;
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double heightWithoutAppBar = height - AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor: ColorPallete.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorPallete.secondaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
        ),
        title: const Text(
          "New Password",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "New Password",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Enter your new password",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    )),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.02 * width, right: 0.02 * width),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !isPasswordVisible,
                        validator: (value) =>
                            value == '' ? 'please enter your password' : null,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: ConfirmationController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Confirm Password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !isPasswordVisible,
                        validator: (value) =>
                            value == '' ? 'please enter your password' : null,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                ConfirmationController.text) {

                              resetPassword();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Password doesn't match",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )));
                            }
                          }
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(350, 50),
                          backgroundColor: ColorPallete.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          "Confirm Password",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void resetPassword() {
    Query().resetPassword(email, passwordController.text);

    if (passwordController.text == ConfirmationController.text) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(
                Icons.close,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Password doesn't match",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )));
    }
  }
}
