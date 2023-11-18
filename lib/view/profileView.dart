import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ugd6_b_9/view/feature/camera.dart';
import 'package:ugd6_b_9/database/sql_helperUser.dart';
import 'package:ugd6_b_9/view/login.dart';
import 'package:ugd6_b_9/utils/imageUtility.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tanggal_lahirController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
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
        nameController.text = tempUser!['name'];
        emailController.text = tempUser!['email'];
        genderController.text = tempUser!['gender'];
        passwordController.text = tempUser!['password'];
        tanggal_lahirController.text = tempUser!['tanggal_lahir'];
        fullnameController.text = tempUser!['fullname'];
        pathPhoto = tempUser!['PathPhoto'];
      });
    } else {
      print('User not found');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 88, 0, 49),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            weight: 20,
                            color: Colors.white,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: pathPhoto == ''
                                  ? const Icon(
                                      Icons.person,
                                      size: 100,
                                      color: Colors.white,
                                    )
                                  : Utility.imageFromBase64String(pathPhoto),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hello, ${nameController.text}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'What a new experience!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Divider(
                        height: 50,
                        color: Colors.grey,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your Username' : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your Email' : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your Password' : null,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: genderController,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: const Icon(Icons.man),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your Gender' : null,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          tanggal_lahirController.text =
                              '${date!.day}/${date.month}/${date.year}';
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: tanggal_lahirController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: const Icon(Icons.date_range),
                              labelText: 'Date of Birth',
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  tanggal_lahirController.text =
                                      '${date!.day}/${date.month}/${date.year}';
                                },
                                icon: Icon(Icons.date_range),
                              ),
                            ),
                            validator: (value) => value == ''
                                ? 'Please select a birth date'
                                : null,
                            onTap: () {
                              // Ini mencegah keyboard dari muncul saat menekan TextFormField
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              editUser(id!);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit Berhasil'),
                              ),
                            );
                          },
                          child: const Text(
                            'Save Edit',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 88, 0, 49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            await availableCameras().then((value) =>
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Camera(camera: value))));
                          },
                          child: Text('edit Photo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 88, 0, 49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.red,
                            onSurface: Colors.white,
                            textStyle: TextStyle(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> userId(String username, String password) async {
    return await SQLHelper.getUserIdByUsernamePassword(username, password);
  }

  Future<void> editUser(int id) async {
    await SQLHelper.editUser(
        id,
        fullnameController.text,
        nameController.text,
        emailController.text,
        genderController.text,
        passwordController.text,
        tanggal_lahirController.text);
  }

  Future<void> addPhoto(String PathPhoto, int id) async {
    await SQLHelper.addPhoto(PathPhoto, id);
  }
}
