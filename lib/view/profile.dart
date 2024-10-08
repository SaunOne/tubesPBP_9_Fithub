import 'package:flutter/material.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/entity/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/database/Client/UserClient.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User.empty();

  void getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    try {
      User getUser = await Query().getByUserId(localStorage.getInt('id')!);

      setState(() {
        user = getUser;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: StyleText().styleH2bWithColor,
        ),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.fullname}',
                            style: StyleText().styleH3bWithColor,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  '${user.email}',
                                  style: StyleText().styleH4lWithColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.email_outlined)
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                user.phone.isEmpty
                                    ? Text(
                                        '08xxxxxxxxxx',
                                        style: StyleText().styleH4lWithColor,
                                      )
                                    : Text(
                                        '${user.phone}',
                                        style: StyleText().styleH4lWithColor,
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.phone_outlined)
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Gender : ',
                                          style: StyleText().styleH4bWithColor),
                                      Text('${user.gender}',
                                          style: StyleText().styleH4lWithColor),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Born : ',
                                          style: StyleText().styleH4bWithColor),
                                      Text('${user.birthdate}',
                                          style: StyleText().styleH4lWithColor),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Height : ',
                                          style: StyleText().styleH4bWithColor),
                                      Text('${user.height}' + ' cm',
                                          style: StyleText().styleH4lWithColor),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text('Weight : ',
                                          style: StyleText().styleH4bWithColor),
                                      Text('${user.weight}' + ' Kg',
                                          style: StyleText().styleH4lWithColor),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/images/tGym1.png',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileView(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: ColorC().primaryColor1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                _ListMenu(
                  icon: Icon(Icons.help_outline),
                  text: Text('Get Help'),
                  route: HomePage(),
                ),
                SizedBox(height: 30),
                _ListMenu(
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  text: Text('Logout', style: TextStyle(color: Colors.red)),
                  route: HomePage(),
                  colorArrow: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ListMenu extends StatelessWidget {
  Icon icon;
  Text text;
  Widget route;
  Color? colorArrow;
  _ListMenu(
      {Key? key,
      required this.icon,
      required this.text,
      required this.route,
      this.colorArrow});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => route));
      },
      padding: EdgeInsets.all(0),
      child: Container(
        width: 370,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 20,
            ),
            text,
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: colorArrow ?? Colors.black),
          ],
        ),
      ),
    );
  }
}

Future<User> getUserById(int id) async {
  print(id);
  User data = await Query().getByUserId(id);
  return data;
}
