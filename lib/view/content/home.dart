import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Query.dart';

import '../../Entity/User.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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


  String greeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: user != null ? Future.delayed(Duration(seconds: 2)) : null,builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      } else {
        return Scaffold(
          body: HomeView(),
        );
      }
    });

  }

  SingleChildScrollView HomeView() {
    return SingleChildScrollView(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        Text(greeting() + ',' + user.fullname,style: StyleText().styleH2bWithColor,),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text('Your Next Workout',style: StyleText().styleH4bWithColor,),
            SizedBox(
              width: 20,
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 15),
              decoration: BoxDecoration(
                color: ColorC().primaryColor1,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '21 Oct 2023',
                    style: StyleText(color: Colors.white).stylePbWithColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey, // Warna bayangan
                offset: Offset(0, 2), // Posisi bayangan (x, y)
                blurRadius: 6, // Radius blur
                spreadRadius: 1, // Radius penyebaran
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goal For This Month',
                style: StyleText().styleH3b,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.weightHanging,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Weight Loss 3Kg', style: StyleText().styleH4l),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Gym Routine 12 Times / Month',
                      style: StyleText().styleH4l),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Gym on your City',
              style: StyleText().styleH4b,
            ),
            Text(
              'See All',
              style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                  .styleH4lWithColor,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 220,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    alignment: Alignment.bottomCenter,
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/tGym1.png',
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: ColorC().primaryColor1,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment
                              .topCenter, // Posisi awal gradien di atas
                          end: Alignment
                              .bottomCenter, // Posisi akhir gradien di bawah
                          colors: [
                            Colors.transparent,
                            Colors.blue,
                          ], // Warna gradien (tr  ansparan di atas, biru di bawah)
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Jakarta',
                              style: StyleText(color: Colors.white)
                                  .styleH4bWithColor,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.mapPin,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Citi Walk',
                                  style: StyleText(color: Colors.white)
                                      .stylePlWithColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Personal Trainer',
              style: StyleText().styleH4b,
            ),
            Text(
              'See All',
              style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                  .styleH4lWithColor,
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    margin:
                        EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // Warna bayangan
                          offset: Offset(0, 1), // Posisi bayangan (x, y)
                          blurRadius: 6, // Radius blur
                          spreadRadius: 0.5, // Radius penyebaran
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          clipBehavior: Clip
                              .antiAlias, // Mengatur agar anak-anak di-clip sesuai dengan borderRadius
                          child: Image.asset(
                            'assets/images/pTrainer1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bala Putra Dewa'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    child: Text('Experient',
                                        style: StyleText().styleP2b),
                                  ),
                                  Text(
                                    ": National Budybuilling Champion ",
                                    style: StyleText().styleP2l,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    child: Text('Age',
                                        style: StyleText().styleP2b),
                                  ),
                                  Text(
                                    ": 27 Year ",
                                    style: StyleText().styleP2l,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    child: Text('Domicilie',
                                        style: StyleText().styleP2b),
                                  ),
                                  Text(
                                    ": Cabang Jogja ",
                                    style: StyleText().styleP2l,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    child: Text('Available',
                                        style: StyleText().styleP2b),
                                  ),
                                  Text(
                                    ":  ",
                                    style: StyleText().styleP2l,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      color: ColorC().primaryColor1,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Modey',
                                      style: StyleText(color: Colors.white)
                                          .styleP2bWithColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      color: ColorC().primaryColor1,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Tuesday',
                                      style: StyleText(color: Colors.white)
                                          .styleP2bWithColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 2, bottom: 2, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      color: ColorC().primaryColor1,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Wednesday',
                                      style: StyleText(color: Colors.white)
                                          .styleP2bWithColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Promo Subcriptiion',
              style: StyleText().styleH4b,
            ),
            Text(
              'See All',
              style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                  .styleH4lWithColor,
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 290,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 180,
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/sGym1.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Promo',
                                style: StyleText(color: Colors.white)
                                    .styleH3bWithColor,
                              ),
                              Text(
                                '25% Off',
                                style: StyleText(color: Colors.white)
                                    .styleH3bWithColor,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "IDR Rp.500.000/mont",
                                style: StyleText(color: Colors.white)
                                    .stylePbWithColor,
                              ),
                              Text(
                                "IDR Rp.500.000/mont",
                                style: StyleText(color: Colors.white)
                                    .stylePbWithColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recomendation',
              style: StyleText().styleH4b,
            ),
            Text(
              'See All',
              style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                  .styleH4lWithColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          padding: EdgeInsets.only(top: 6, bottom: 6, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(int i = 0 ; i < 5 ; i ++)
                Container(
                  margin: EdgeInsets.only(bottom: 10,top: 5),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Warna bayangan
                        offset: Offset(0, 1), // Posisi bayangan (x, y)
                        blurRadius: 6, // Radius blur
                        spreadRadius: 0.5, // Radius penyebaran
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/eGym3.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Beginner',style: StyleText().styleH4b,),
                      Row(children: [
                        SizedBox(width: 40,),
                        Text('| Push Up',style: StyleText().styleH4lWithColor,),
                      ],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    ),
  );
  }
}
