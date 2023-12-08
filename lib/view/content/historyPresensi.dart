import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:slideable/slideable.dart';

class HistoryPresensi extends StatefulWidget {
  const HistoryPresensi({Key? key}) : super(key: key);

  @override
  State<HistoryPresensi> createState() => _HistoryPresensiState();
}

class _HistoryPresensiState extends State<HistoryPresensi> {
  final List<String> presensiData = [
    'Presensi 1',
    'Presensi 2',
    'Presensi 3',

    // Add more data as needed
  ];

  TextEditingController updateDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            'History Presence',
                            style: StyleText().styleH2bWithColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/History.json',
                            width: 200,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello, ' + 'Made Yosa Bagas Brawijaya',
                            style: StyleText(color: ColorC().primaryColor1)
                                .styleH2bWithColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'This is Your History Log Presence',
                                style: StyleText(
                                  color: Color.fromARGB(255, 100, 100, 100),
                                ).styleH3lWithColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 800,
                        child: ListView.builder(
                          itemCount: presensiData.length,
                          itemBuilder: (context, index) {
                            return Slideable(
                              items: [
                                ActionItems(
                                  backgroudColor: Colors.transparent,
                                  radius: BorderRadius.circular(10),
                                  icon: Icon(
                                    FontAwesomeIcons.penToSquare,
                                    color: Colors.amber,
                                  ),
                                  onPress: () {
                                    _showEditDialog();
                                  },
                                ),
                                ActionItems(
                                  backgroudColor: Colors.transparent,
                                  icon: Icon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.red,
                                  ),
                                  onPress: () {
                                    _showDeleteDialog();
                                  },
                                ),
                              ],
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(
                                    bottom: 10, top: 3, left: 3, right: 3),
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 1),
                                      blurRadius: 3,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Basic Package',
                                          style: StyleText().styleH3b,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Icon(
                                            FontAwesomeIcons.calendar,
                                            size: 20,
                                            color: ColorC().primaryColor1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '2023-11-12',
                                          style: StyleText(
                                            color: ColorC().primaryColor1,
                                          ).styleH4lWithColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog() async {
    await showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Edit Presence'),
        content: Text(
          'Are you sure you want to Update this Presence?',
          style: StyleText().styleH4lWithColor,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: StyleText(color: Colors.blue).styleH3lWithColor,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              await _selectDate(context);
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    await showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('Confirmation'),
        content: Text(
          'Are you sure you want to Delete this Presence?',
          style: StyleText().styleH4lWithColor,
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
          CupertinoDialogAction(
            onPressed: () {},
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      updateDateController.text = '${date.day}-${date.month}-${date.year}';
    }
  }
}
