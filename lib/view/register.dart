import 'package:flutter/material.dart';
import 'package:ugd6_b_9/Entity/ResponseDataUser.dart';
import 'package:ugd6_b_9/Testing/Testing_function.dart';
import 'package:ugd6_b_9/constant/color.dart';
import 'package:ugd6_b_9/database/Auth.dart';
import 'package:ugd6_b_9/entity/user.dart';
import 'package:ugd6_b_9/view/Login.dart';
import 'package:ugd6_b_9/view/homePage.dart';

String? name, email, gender, password, tanggalLahir;

enum Gender { male, female }

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tanggal_lahirController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  Gender? selectedGender;

  bool isVisible = false;
  bool isExist = false;
  bool isChecked = false;

  String selectedValue = ''; // Track the selected value
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Sign up with your username and password',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 100, 100, 100)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    key: const Key('fullnameField'),
                    controller: fullnameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge_outlined),
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                    validator: (value) =>
                        value == '' ? 'Please enter your username' : null,
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  TextFormField(
                    key: const Key('usernameField'),
                    controller: nameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.5),
                        )),
                    validator: (value) =>
                        value == '' ? 'Please enter your username' : null,
                  ),
                  const SizedBox(height: 21.0),
                  TextFormField(
                      key: const Key('emailField'),
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outline),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.5),
                          )),
                      // onChanged: (value) async {
                      //   isExist = await isEmail(value);
                      //   setState(() {
                      //     isExist;
                      //   });
                      // },
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter your email';
                        } else if (isExist) {
                          return 'Email already exist';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 21.0),
                  TextFormField(
                    key: Key('passwordField'),
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    obscureText: !isVisible,
                    validator: (value) =>
                        value == '' ? 'Please enter your password' : null,
                  ),
                  const SizedBox(height: 21.0),
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
                        key: const Key('dateField'),
                        controller: tanggal_lahirController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.5),
                          ),
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
                            icon: const Icon(Icons.date_range),
                          ),
                        ),
                        validator: (value) =>
                            value == '' ? 'Please select a birth date' : null,
                        onTap: () {
                          // Ini mencegah keyboard dari muncul saat menekan TextFormField
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<Gender>(
                        key: Key('maleTap'),
                        activeColor: ColorPallete.primaryColor,
                        value: Gender.male,
                        groupValue: selectedGender,
                        onChanged: (Gender? value) {
                          setState(() {
                            selectedGender = value;
                            genderController.text = 'Male';
                          });
                        },
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 18),
                      ),
                      Radio<Gender>(
                        key: Key('femaleTap'),
                        activeColor: ColorPallete.primaryColor,
                        value: Gender.female,
                        groupValue: selectedGender,
                        onChanged: (Gender? value) {
                          setState(() {
                            selectedGender = value;
                            genderController.text = 'Female';
                          });
                        },
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        key: const Key('termsButton'),
                        value: isChecked,
                        activeColor: ColorPallete.primaryColor,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        'Have read the ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 100, 100, 100),
                        ),
                      ),
                      Text(
                        'terms of service',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorPallete.primaryColor,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      key: const Key('signUpButton'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPallete.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                      onPressed: () async {
                        print('masuk sebelum validate');
                        if (formKey.currentState!.validate()) {
                          handleTestingRegister(fullname: fullnameController.text,username: 'saun01',email: '12@gmail.com',password: '1232145',birthdate: '12/12/2023',gender: 'Male'
                              );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    key: Key('loginButton'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorPallete.primaryColor,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handleRegister(String fullname, String username, String email,
      String password, String birthdate, String gender) async {
    bool success = false;
    print('ini email : ${email}');
    print('ini fullname : ${fullname}');
    print('ini username : ${username}');

    ResponseDataUser data = await Authentication()
        .Register(fullname, username, email, password, birthdate, gender);

    if (data.message == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: Key('registerSuccess'),
          content: Text(data.message),
          backgroundColor: Colors.green,
        ),
      );
      success = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data.message),
          backgroundColor: Colors.red,
        ),
      );
      success = false;
    }
    return success;
  }

  Future<void> handleTestingRegister({required String fullname,required String username,required String email,
      required String password,required String birthdate,required String gender}) async {
    bool success = false;

    print('ini fullname : ${fullname}');

    var user = User(
        id: 1,
        fullname: email,
        username: fullname,
        email: email,
        password: password,
        birthdate: birthdate,
        gender: gender,
        phone: '1',
        weight: 200,
        height: 200,
        photo: '12');

        // print('masuk : ${user.gender}');

    if (user.fullname == '' ||
        user.username == '' ||
        user.email == '' ||
        user.birthdate == '' ||
        user.password == '' ||
        user.gender == '') {
          print('masuk sini');
    
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      },),);
      print('masuk ketempat yang benar');
    }
  }
}

class CustomDropdownFormField extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFormField({
    required this.labelText,
    required this.prefixIcon,
    required this.items,
    required this.onChanged,
  });

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? selectedValue;
  bool isExist = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('${widget.labelText}: '), // Label for the dropdown
            DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? value) async {
                setState(() {
                  selectedValue = value!;
                });
                setState(() {
                  isExist = value == null ? false : true;
                });
                widget.onChanged(value);
              },
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
