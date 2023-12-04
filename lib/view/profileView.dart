import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ugd6_b_9/Entity/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ugd6_b_9/Entity/ResponseDataUser.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Query.dart';
import 'package:ugd6_b_9/constant/color.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/utils/imageUtility.dart';
import 'package:ugd6_b_9/entity/image.dart';

enum Gender { male, female }

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  late String pathPhoto = '';
  bool isEditMode = false;
  late ImageUser image;
  Future<User> user = Future<User>.value(User.empty());

  Gender? selectedGender;

  // String gender = 'Male'; // Default gender value
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  late bool isLoading;
  late int id;
  User userData = User.empty(); // Initialize with an empty user object

  @override
  void initState() {
    super.initState();
    loadStoredData();
  }

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        Uint8List bytes = File(image.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        pathPhoto = img64;
      });
    } else {
      print('No image selected.');
    }
  }

  LoadImage() {
    try {
      Uint8List bytes = base64Decode(pathPhoto);
      return Image.memory(bytes);
    } catch (e) {
      print(e);
      return Image.asset('assets/logo.png');
    }
  }

  void loadStoredData() async {
    Future.delayed(Duration(seconds: 3),
            () async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      id = localStorage.getInt('id')!;
      pathPhoto = localStorage.getString('photo')!;

      isLoading = true;
      setState(() {
        getUserDataById();
        user = getUserById(id);
      });
    });
  }

  void getUserDataById() async {
    try {
      User data = await getUserById(id);
      setState(() {
        userData = data;
        usernameController.text = userData.username;
        emailController.text = userData.email;
        dateOfBirthController.text = userData.birthdate;
        passwordController.text = userData.password;
        selectedGender =
            userData.gender == 'Male' ? Gender.male : Gender.female;
        fullnameController.text = userData.fullname;
        phoneController.text = userData.phone;
        weightController.text = userData.weight.toString();
        heightController.text = userData.height.toString();
        pathPhoto = userData.photo;
      });
    } catch (e) {
      print("Error getting user data: $e");
      // Handle the error if necessary
    }
  }

  void _saveProfile() async {
    if (!isEditMode) {
      return;
    }
    await Query().updateProfile(
        id,
        fullnameController.text,
        usernameController.text,
        emailController.text,
        dateOfBirthController.text,
        selectedGender == Gender.male ? 'Male' : 'Female',
        phoneController.text,
        double.parse(weightController.text),
        double.parse(heightController.text),
        pathPhoto);

    final snackBar = SnackBar(
      content: Text('Profile updated successfully'),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    isEditMode = false;
    getUserDataById();
    print('Save profile data');
  }

  //
  Uint8List decodeImage(String pathPhoto) {
    List<int> imageBytes = base64Decode(pathPhoto);
    return Uint8List.fromList(imageBytes);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          ),
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: FutureBuilder(
        future: user != null ? Future.delayed(Duration(seconds: 1), () => user) : null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      child: imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                imageFile!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: ClipRect(
                                child: LoadImage(),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello! ${fullnameController.text}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black),
                  SizedBox(height: 10),
                  _ProfileTextField(
                    controller: fullnameController,
                    label: "Fullname",
                    icon: Icons.badge,
                    isEditMode: isEditMode,
                  ),
                  _ProfileTextField(
                    controller: usernameController,
                    label: "Username",
                    icon: Icons.person_outline,
                    isEditMode: isEditMode,
                  ),
                  _ProfileTextField(
                    controller: phoneController,
                    label: "No Telephone",
                    icon: Icons.phone_android_outlined,
                    isEditMode: isEditMode,
                  ),
                  _ProfileTextField(
                    controller: emailController,
                    label: "Email",
                    icon: Icons.email_outlined,
                    isEditMode: isEditMode,
                  ),
                  _ProfileDateField(
                    controller: dateOfBirthController,
                    label: "Date of Birth",
                    icon: Icons.calendar_today_outlined,
                    isEditMode: isEditMode,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _ProfileMetricField(
                          controller: heightController,
                          label: "Height",
                          icon: Icons.straighten,
                          isEditMode: isEditMode,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _ProfileMetricField(
                          controller: weightController,
                          label: "Weight",
                          icon: Icons.monitor_weight,
                          isEditMode: isEditMode,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<Gender>(
                        activeColor: ColorPallete.primaryColor,
                        value: Gender.male,
                        groupValue: selectedGender,
                        onChanged: isEditMode
                            ? (Gender? value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              }
                            : null,
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 18),
                      ),
                      Radio<Gender>(
                        activeColor: ColorPallete.primaryColor,
                        value: Gender.female,
                        groupValue: selectedGender,
                        onChanged: isEditMode
                            ? (Gender? value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              }
                            : null,
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _saveProfile();
                    },
                    child: Text(
                      'Save',
                      style: StyleText().styleH4bWithColor,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: ColorC().primaryColor1,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add BottomNavigationBar or other widgets if needed
    );
  }

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }
}

class _buildProfile {}

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool isEditMode;

  const _ProfileTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.icon,
      this.isPassword = false,
      required this.isEditMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        ),
        obscureText: isPassword,
        enabled: isEditMode,
      ),
    );
  }
}

class _ProfileMetricField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isEditMode;

  const _ProfileMetricField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.isEditMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        ),
        enabled:
            isEditMode, // Tambahkan baris ini untuk mengatur status enabled
      ),
    );
  }
}

class _ProfileDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isEditMode;

  const _ProfileDateField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.isEditMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        ),
        readOnly: true,
        onTap: () async {
          if (isEditMode) {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
              controller.text = formattedDate;
            }
          }
        },
        enabled: isEditMode,
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onGenderChanged;

  const _GenderSelector({
    Key? key,
    required this.gender,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text('Male'),
              leading: Radio<String>(
                value: 'Male',
                groupValue: gender,
                onChanged: (value) {
                  onGenderChanged(value!);
                },
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text('Female'),
              leading: Radio<String>(
                value: 'Female',
                groupValue: gender,
                onChanged: (value) {
                  onGenderChanged(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<User> getUserById(int id) async {
  print(id);
  User data = await Query().getByUserId(id);
  return data;
}
