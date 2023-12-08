import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/view/content/notaView.dart';
import 'package:ugd6_b_9/view/content/subcriptionView.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:uuid/uuid.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                          ),
                          Text(
                            'Detail Subscription',
                            style: StyleText().styleH2bWithColor,
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    Lottie.asset(
                      'assets/Validate.json',
                      width: 500,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Manage your membership preferences. You can either update your details to enjoy the latest benefits, or if you no longer wish to continue, choose to cancel your membership.',
                            textAlign: TextAlign.center,
                            style: StyleText().styleH4lWithColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cancel Successfully",
                                          style: StyleText().styleH4lWithColor,
                                        ),
                                      ]),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  primary: Colors.red,
                                  fixedSize: Size(100, 30),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SubcriptionView(id: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  primary: Colors.orange,
                                  fixedSize: Size(100, 30),
                                ),
                                child: const Text(
                                  'Change',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(32, 175, 177, 199),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: ColorC().primaryColor3),
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID Subscription:',
                                    style: StyleText(
                                            color: const Color.fromARGB(
                                                255, 100, 100, 100))
                                        .styleH4lWithColor,
                                  ),
                                  Text(
                                    'ID00234SM12',
                                    style: StyleText().styleH2lWithColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Name Subscription : ',
                                    style: StyleText(
                                            color: const Color.fromARGB(
                                                255, 100, 100, 100))
                                        .styleH4lWithColor,
                                  ),
                                  Text(
                                    'Basic Package',
                                    style: StyleText().styleH2lWithColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Expired Date:',
                                    style: StyleText(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100))
                                        .styleH4lWithColor,
                                  ),
                                  Text(
                                    '12-12-2024',
                                    style: StyleText().styleH2lWithColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Price : ',
                                    style: StyleText(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100))
                                        .styleH4lWithColor,
                                  ),
                                  Text(
                                    'IDR 2.000.000',
                                    style: StyleText().styleH2lWithColor,
                                  ),
                                  Text(
                                    'Payment Method : ',
                                    style: StyleText(
                                            color: Color.fromARGB(
                                                255, 100, 100, 100))
                                        .styleH4lWithColor,
                                  ),
                                  Text(
                                    'Bank BCA',
                                    style: StyleText().styleH2lWithColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotaPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              primary: ColorC().primaryColor1,
                              fixedSize: Size(200, 50),
                            ),
                            child: Text(
                              'Next Details',
                              style: StyleText(color: Colors.white).styleH4bWithColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
