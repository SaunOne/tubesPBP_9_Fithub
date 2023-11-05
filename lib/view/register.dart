import 'package:flutter/material.dart';
import 'package:ugd6_b_9/constant/color.dart';
import 'package:ugd6_b_9/database/sql_helperUser.dart';
import 'package:ugd6_b_9/view/login.dart';

import '../routes/routes.dart';

// String? name, email, gender, password, tanggalLahir;

enum Gender { male, female }

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  SizedBox(
                    height: 21,
                  ),
                  TextFormField(
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
                  SizedBox(height: 21.0),
                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outline),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.5),
                          )),
                      onChanged: (value) async {
                        isExist = await isEmail(value);
                        setState(() {
                          isExist;
                        });
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter your email';
                        } else if (isExist) {
                          return 'Email already exist';
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 21.0),
                  TextFormField(
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
                  SizedBox(height: 21.0),
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
                            icon: Icon(Icons.date_range),
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
                  // TextFormField(
                  //   controller: genderController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.person),
                  //     labelText: 'Gender',
                  //   ),
                  //   validator: (value) =>
                  //       value == '' ? 'Please enter your Gender' : null,
                  // ),
                  Row(
                    children: [
                      Radio<Gender>(
                        activeColor: primaryColor,
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
                        activeColor: primaryColor,
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
                        value: isChecked,
                        activeColor: primaryColor,
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
                      const Text(
                        'terms of service',
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await addEmployee();
                          Navigator.pushNamed(context, Routes.login);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: primaryColor,
                              content: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Register Success',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
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
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
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
                              color: primaryColor,
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

  Future<void> addEmployee() async {
    // String name, String email, String gender, String password, String tanggal_lahir
    await SQLHelper.addUser(
        fullnameController.text,
        nameController.text,
        emailController.text,
        genderController.text,
        passwordController.text,
        tanggal_lahirController.text);
  }

  Future<bool> isEmail(String email) async {
    final data = await SQLHelper.isEmailExist(email);
    return data.isNotEmpty;
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
