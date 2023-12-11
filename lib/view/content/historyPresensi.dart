import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/PresensiClient.dart';
import 'package:ugd6_b_9/database/Client/UserClient.dart';
import 'package:ugd6_b_9/entity/model/presensi.dart';
import 'package:ugd6_b_9/entity/model/user.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:slideable/slideable.dart';

class HistoryPresensi extends StatefulWidget {
  const HistoryPresensi({Key? key}) : super(key: key);

  @override
  State<HistoryPresensi> createState() => _HistoryPresensiState();
}

class _HistoryPresensiState extends State<HistoryPresensi> {
  late List<Presensi> listPresensi;
  int? id_user;
  late User user;

  Future<void> fetchData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    id_user = localStorage.getInt('id') as int;

    print('id User : $id_user');
    await PresensiClient().getPresensiByUserId(id_user!).then((value) {
      print('value : ${value}');

      setState(() {
        listPresensi = value;
      });
    });
    print('pencrian');
  }

  Future<List<Presensi>> fetchData_future() async {
    return await PresensiClient().getPresensiByUserId(id_user!);
  }

  Future<bool> checkData() async {
    return listPresensi != null;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  TextEditingController updateDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Presensi>>(
        future: fetchData_future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
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
                                    'Hello, ',
                                    style:
                                        StyleText(color: ColorC().primaryColor1)
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
                                          color: Color.fromARGB(
                                              255, 100, 100, 100),
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
                                  itemCount: listPresensi.length,
                                  itemBuilder: (context, index) {
                                    String tanggal =
                                        listPresensi[index].tanggal.toString();
                                    DateTime parsedDate =
                                        DateTime.parse(tanggal);
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(parsedDate);
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
                                            _selectDate(context, index);
                                          },
                                        ),
                                        ActionItems(
                                          backgroudColor: Colors.transparent,
                                          icon: Icon(
                                            FontAwesomeIcons.trash,
                                            color: Colors.red,
                                          ),
                                          onPress: () {
                                            _showDeleteDialog(
                                                listPresensi[index].id, index);
                                          },
                                        ),
                                      ],
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.only(
                                            bottom: 10,
                                            top: 3,
                                            left: 3,
                                            right: 3),
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${listPresensi[index].id}',
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
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Icon(
                                                    FontAwesomeIcons.calendar,
                                                    size: 20,
                                                    color:
                                                        ColorC().primaryColor1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${formattedDate}',
                                                  style: StyleText(
                                                    color:
                                                        ColorC().primaryColor1,
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
        });
  }

  Widget input() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(int id, int index) async {
    // await showDialog(
    //   context: context,
    //   builder: (_) => CupertinoAlertDialog(
    //     title: Text('Edit Presence'),
    //     content: Text(
    //       'Are you sure you want to Update this Presence?',
    //       style: StyleText().styleH4lWithColor,
    //     ),
    //     actions: [
    //       CupertinoDialogAction(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: Text(
    //           'No',
    //           style: StyleText(color: Colors.blue).styleH3lWithColor,
    //         ),
    //       ),
    //       CupertinoDialogAction(
    //         onPressed: () async {
    //           await _selectDate(context);
    //           print('ini selected date : ${updateDateController.text}');
    //           PresensiClient().updatePresensi(id,updateDateController.text);
    //           setState(() {
    //             listPresensi[index].tanggal = DateTime.parse(updateDateController.text);
    //             Navigator.pop(context);
    //           });

    //         },
    //         child: Text(
    //           'Yes',
    //           style: TextStyle(color: Colors.black),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Future<void> _showDeleteDialog(int id, int index) async {
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
            onPressed: () {
              PresensiClient().deletePresensi(id);
              setState(() {
                Navigator.pop(context);
                listPresensi.removeAt(index);
              });
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      updateDateController.text = '${date.year}-${date.month}-${date.day}';
    }

    setState(() {
      PresensiClient()
          .updatePresensi(listPresensi[index].id, updateDateController.text);
      setState(() {
        listPresensi[index].tanggal = updateDateController.text;
        Navigator.pop(context);
      });
    });
  }
}
