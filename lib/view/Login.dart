
import 'package:flutter/material.dart';
import 'package:griding/Component/EllipsShape.dart';
import 'package:griding/constant/color.dart';
import 'package:griding/view/NewPassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.4 * height,
                  child: EllipsShape(height, width, 0.7),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.3 * width, top: 0.03 * height),
              child: Image.asset(
                'Assets/FitHub.png',
                height: 0.3 * height,
                width: 0.4 * width,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.33 * width, top: 0.24 * height),
              child: const Text(
                "Where Results Begin",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            FormLogin(height, context)
          ],
        ));
  }



  Form FormLogin(double height, BuildContext context) {
    return Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, top: 0.35 * height),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Login with your username and password",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 0.04 * height,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                children: [
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 30),
                    controller: usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return 'please enter your username';
                      }
                      return null;
                    }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 30),
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
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                     if(passwordController.text == "" && usernameController.text.isNotEmpty || formKey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewPassword()),
                        );
                     }
                    },
                    style: TextButton.styleFrom(
                      primary: ColorPallete.primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    child: const Text("Forgot Password?"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: ColorPallete.primaryColor,
                            content: const Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Login Successful",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 60),
                      backgroundColor: ColorPallete.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    child: const Text("Login"),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
