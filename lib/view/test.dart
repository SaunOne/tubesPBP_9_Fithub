import 'package:flutter/material.dart';
import 'package:griding/Entity/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:griding/Entity/ResponseDataUser.dart';
import 'package:griding/dataBaseQuery/Query.dart';

class test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<test> {
  late int id = 0;
  late User userData = User.empty(); // Initialize with an empty user object

  @override
  void initState() {
    super.initState();
    loadStoredData();
  }

  void loadStoredData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      id = localStorage.getInt('id')!;
      // Load user data when id is available
      if (id != 0) {
        getUserDataById();
      }
    });
  }

  void getUserDataById() async {
    try {
      User data = await getUserById(id);
      setState(() {
        userData = data;
      });
    } catch (e) {
      print("Error getting user data: $e");
      // Handle the error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: $id'),
            Text('User Name: ${userData.fullname}'),
            Text('Email: ${userData.email}'),
            // Add more widgets to display other user data as needed
          ],
        ),
      ),
    );
  }

  Future<User> getUserById(int id) async {
    print(id);
    User data = await Query().getByUser(id);
    return data;
  }
}
