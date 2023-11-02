import 'package:flutter/material.dart';
import 'package:ugd6_b_9/database/sql_helperUser.dart';
import 'package:ugd6_b_9/view/login.dart';

import '../routes/routes.dart';

// String? name, email, gender, password, tanggalLahir;

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

  bool isVisible = false;
  bool isExist = false;
  String selectedValue = ''; // Track the selected value
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter your username' : null,
                    ),
                    TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                        ),
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
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Password',
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
                    TextFormField(
                      controller: genderController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Gender',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter your Gender' : null,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        tanggal_lahirController.text = '${date!.day}/${date.month}/${date.year}';
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: tanggal_lahirController,
                          decoration: InputDecoration(
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
                          validator: (value) =>
                              value == '' ? 'Please select a birth date' : null,
                          onTap: () {
                            // Ini mencegah keyboard dari muncul saat menekan TextFormField
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 115, 0, 54),
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
                                content: Text('Register Success'),
                              ),
                            );
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical:15.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 18.0),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Icon(Icons.arrow_back),
              backgroundColor:  Color.fromARGB(255, 115, 0, 54),
            )));
  }
  
  Future<void> addEmployee() async {
    // String name, String email, String gender, String password, String tanggal_lahir
    await SQLHelper.addUser(
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
