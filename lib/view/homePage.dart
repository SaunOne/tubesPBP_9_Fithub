// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/entity/model/User.dart';
import 'package:ugd6_b_9/view/content/historyPresensi.dart';

import 'package:ugd6_b_9/view/content/searchGym.dart';

import 'package:ugd6_b_9/database/Client/UserClient.dart';

import 'package:ugd6_b_9/view/content/subcriptionView.dart';
import 'package:ugd6_b_9/view/content/gridGuide.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/content/home.dart';
import 'package:ugd6_b_9/view/content/trainerView.dart';
import 'package:ugd6_b_9/view/feature/track.dart';
import 'package:ugd6_b_9/view/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexContent = 0;
  bool isPop = false;
  late int id = 0;
  late User user = User.empty();

  List<Widget> content = [
    Home(),
    SearchGym(
      id: 1,
    ),
    SubcriptionView(id: 1),
    GridGuide()
  ];

  void onChange(index) {
    setState(
      () {
        indexContent = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = await Query().getByUserId(prefs.getInt('id')!);
    setState(() {
      id = prefs.getInt('id')!;
      this.user = user;
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: Container(
              padding: EdgeInsets.only(left: 20),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isPop = true;
                  });
                },
                color: Color.fromARGB(255, 0, 68, 170),
              ),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            title: Text(
              'HOME',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notification_add, size: 25),
                color: Color.fromARGB(255, 0, 68, 170),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notificationView);
                },
              ),
              SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 20,
              ),
            ],
            toolbarHeight: 60,
          ),
          body: content[indexContent],
          bottomNavigationBar: BottomAppBar(
            height: 60,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    onChange(0);
                  },
                  icon: Icon(
                    FontAwesomeIcons.house,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onChange(1);
                  },
                  icon: Icon(
                    Icons.place,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                IconButton(
                  onPressed: () {
                    onChange(2);
                  },
                  icon: Icon(
                    Icons.card_membership,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onChange(3);
                  },
                  icon: Icon(
                    FontAwesomeIcons.dumbbell,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              FontAwesomeIcons.qrcode,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.scanPage);
            },
            backgroundColor: ColorC().primaryColor1,
          ),
        ),
        if (isPop)
          Positioned(
              child: MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                isPop = false;
              });
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromARGB(97, 77, 77, 77),
            ),
          )),
        if (isPop)
          Positioned(
            child: Container(
              height: 420,
              width: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullname,
                                style: StyleText(color: Colors.black)
                                    .stylePbWithColor,
                              ),
                              Text(user.email,
                                  style: StyleText(color: Colors.black)
                                      .styleP2lWithColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.pushNamed(context, Routes.profile);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Profile', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.pushNamed(context, Routes.calendarScreen);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Schedule',
                              style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.pushNamed(context, Routes.trainerView);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.sports_gymnastics,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Trainer', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HistoryPresensi();
                        }));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_edu,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('history Presensi',
                              style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TrackPage();
                        }));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.run_circle,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Track Running',
                              style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                          onPressed: () {
                            forcelogout();
                            logout();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Logout',
                                  style: StyleText().styleH4bWithColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            right: 40,
            top: 70,
          ),
      ],
    );
  }

  Future<void> logout() async {
    try {
      User user = await Query().Logout(id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      Navigator.pushNamed(context, Routes.preLogin);
    } catch (e) {
      print(e);
    }
  }

  void forcelogout() {
    Navigator.pushNamed(context, Routes.preLogin);
  }
}
