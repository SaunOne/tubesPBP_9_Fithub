import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/database/sql_helperUser.dart';
import 'dart:convert';
import 'package:ugd6_b_9/utils/imageUtility.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../../routes/routes.dart';


class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  _PreviewPageState createState() => _PreviewPageState();
}



class _PreviewPageState extends State<PreviewPage> {

  String pathPhoto = '';
  Map<String, dynamic>? tempUser;
  int? id;

  void getDataFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginDataString = prefs.getString('login_data') ?? '';

    Map<String, dynamic> loginData = jsonDecode(loginDataString);

    String username = loginData['username'];
    String password = loginData['password'];

    tempUser = await userId(username, password);
    if (tempUser != null) {
      id = tempUser!['id'];
      print('idnya : $id');
      setState(() {
        id = tempUser!['id'];

      });
    } else {
      print('User not found');
    }
  }

  Future<Map<String, dynamic>?> userId(String username, String password) async {
    return await SQLHelper.getUserIdByUsernamePassword(username, password);
  }

  @override
  void initState() {
    super.initState();
    getDataFromPreferences();
  }

  void addPhoto(String pathPhoto, int id) async {
    // Get the photo bytes from the path.
    final Uint8List photoBytes = await File(pathPhoto).readAsBytes();
    // Convert the photo bytes to a base64 string.
    final String photoString = Utility.base64String(photoBytes);
    // Save the photo to the database.
    await SQLHelper.addPhoto(photoString, id);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 115, 0, 54),

          title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text({'id': id.toString(), 'name': widget.picture.name}.toString()),
          Image.file(File(widget.picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(widget.picture.name),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              addPhoto(widget.picture.path, id!);
              Navigator.pushNamed(context, Routes.profilePage);
            },
            child: const Text(
                'Save'
            ),
          ),
        ]),
      ),
    );
  }
}
