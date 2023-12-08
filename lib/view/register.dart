import 'package:flutter/material.dart';
import 'package:ugd6_b_9/Entity/ResponseDataUser.dart';
import 'package:ugd6_b_9/constant/color.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/AuthClient.dart';
import 'package:ugd6_b_9/view/Login.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/gestures.dart';

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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sign Up',
                    style: StyleText().styleH1bWithColor,
                  ),
                  Text(
                    'Sign up with your username and password',
                    style: StyleText(color: Color.fromARGB(255, 100, 100, 100))
                        .styleH3lWithColor,
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
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter your email';
                      } else if (isExist) {
                        return 'Email already exist';
                      } else {
                        return null;
                      }
                    },
                  ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must at least be 8 characters';
                      } else {
                        return null;
                      }
                    },
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
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilderRadioGroup<Gender>(
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      labelStyle:
                          StyleText(color: Colors.black).styleH2lWithColor,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    name: 'gender',
                    options: [
                      FormBuilderFieldOption(
                          value: Gender.male,
                          child: Text(
                            'Male',
                            style: StyleText().styleH3lWithColor,
                          )),
                      FormBuilderFieldOption(
                          value: Gender.female,
                          child: Text(
                            'Female',
                            style: StyleText().styleH3lWithColor,
                          )),
                    ],
                    onChanged: (Gender? value) {
                      setState(() {
                        selectedGender = value;
                        if (value == Gender.male) {
                          genderController.text = 'Male';
                        } else if (value == Gender.female) {
                          genderController.text = 'Female';
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                    activeColor: ColorC().primaryColor1,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: FormBuilderCheckbox(
                      name: 'terms',
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Have Read the ',
                              style: StyleText(color: Colors.black)
                                  .styleH4lWithColor,
                            ),
                            TextSpan(
                              text: 'Terms & Condition',
                              style: StyleText(color: ColorC().primaryColor1)
                                  .styleM4bWithColor,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Terms and Conditions for FitHub',
                                        style: StyleText().styleH2bWithColor,
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Welcome to FitHub! As you embark on a transformative fitness journey with our application, please acquaint yourself with the following terms and conditions. To use FitHub, you must be committed to maintaining a healthy lifestyle, and you are responsible for safeguarding your account information to ensure secure access.',
                                              style:
                                                  StyleText().styleH3lWithColor,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'FitHub provides you with access to a variety of fitness-related content and services, although we cannot guarantee the absolute accuracy of the provided information. Your usage is also governed by our Privacy Policy, reflecting our commitment to protecting your health and wellness data. We retain the right to terminate access at our discretion, and these terms are subject to the laws of your jurisdiction.',
                                              style:
                                                  StyleText().styleH3lWithColor,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'If you have any questions or concerns about FitHub, feel free to reach out to us at [Your Contact Information]. We appreciate your commitment to a healthier lifestyle and hope you enjoy a transformative and rewarding fitness experience with FitHub!',
                                              style:
                                                  StyleText().styleH3lWithColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Okay'),
                                          child: Text(
                                            'Okay',
                                            style: StyleText(
                                                    color:
                                                        ColorC().primaryColor1)
                                                .styleH3bWithColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      activeColor: ColorC().primaryColor1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      
                      validator: (value) {
                        if (value == null) {
                          return 'Please check the terms & condition';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPallete.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          )),
                      onPressed: () async {
                        print('masuk sebelum validate');
                        if (formKey.currentState!.validate() && isChecked) {
                          handleRegister(
                              fullnameController.text,
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              tanggal_lahirController.text,
                              genderController.text);
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

  void handleRegister(String fullname, String username, String email,
      String password, String birthdate, String gender) async {
    print('ini email : ${email}');
    ResponseDataUser data = await Authentication()
        .Register(fullname, username, email, password, birthdate, gender);

    if (data.message == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8),
              Text(data.message),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.close, color: Colors.white),
              SizedBox(width: 8),
              Text(data.message),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
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
