import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/timer.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/gym1.jpg'),
            fit: BoxFit.fitWidth,
            isAntiAlias: true,
          ),
          color: Colors.red,
        ),
        child: Column( 
          children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.topLeft,
            height: 200,
            child: IconButton(icon: const Icon(FontAwesomeIcons.chevronLeft),onPressed: (){
              Navigator.pop(context);
            },),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beginner',
                      style: StyleText().styleH1b,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '| 6 Workouts for',
                          style: StyleText().styleH3l,
                        ),
                        Text(
                          ' Beginner',
                          style: StyleText().styleH3b,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorC().primaryColor1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Schedule Workout',
                              style: StyleText(color: Colors.white)
                                  .stylePlWithColor,
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Text(
                              '3-5-2023',
                              style: StyleText(color: Colors.white)
                                  .stylePlWithColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Exercises',
                      style: StyleText().styleH3b,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: 80,
                              decoration: BoxDecoration(
                                color: ColorC().primaryColor1,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/audio/img1.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(
                                            6), // Menentukan border radius menjadi bulatan dengan radius 15.
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Warming Up',
                                              style:
                                                  StyleText(color: Colors.white)
                                                      .stylePbWithColor),
                                          Text('02:00',
                                              style:
                                                  StyleText(color: Colors.white)
                                                      .stylePlWithColor),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.chevronRight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: MaterialButton(
        height: 50,
        minWidth: 200,
        color: ColorC().secondaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Start',
          style: StyleText().styleH2bWithColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context,Routes.timerPage);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
