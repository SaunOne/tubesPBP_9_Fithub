import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/database/sql_helperUser.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/register.dart';


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
    return SafeArea(
        child: Scaffold(
            body: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
              validator: (value) =>
                  value == '' ? 'please enter your Email' : null,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
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
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 115, 0, 54),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                        )),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login(usernameController.text, passwordController.text);

                        saveLoginData(usernameController.text, passwordController.text);
                        
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Text("Login")))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun?"),
                GestureDetector(
                  onTap: () {
                   Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    )));
  }

  // login

  Future<void> login(String username, String password) async {
    final data = await SQLHelper.login(username, password);
    if (data.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil'),
        ),
      );
      await saveLoginData(username, password);
      Navigator.pushNamed(context, Routes.homePage);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah'),
        ),
      );
    }
  }

//   savepref by get the user

  Future<void> saveLoginData(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> loginData = {'username': username, 'password': password};
    prefs.setString('login_data', jsonEncode(loginData));
  }


}