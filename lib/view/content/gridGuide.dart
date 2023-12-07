import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/main.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/feature/track.dart';
import 'package:ugd6_b_9/entity/model/gerakan.dart';
import 'package:ugd6_b_9/database/Client/GerakanClient.dart'; // Import the GerakanClient

class GridGuide extends StatefulWidget {
  const GridGuide({super.key});

  @override
  State<GridGuide> createState() => _GridGuideState();
}

class _GridGuideState extends State<GridGuide> {
  int nav = 1;
  late GerakanClient _gerakanClient;
  List<Gerakan>? _gerakans;

  @override
  void initState() {
    super.initState();
    _gerakanClient = GerakanClient();
    _loadGerakans();
  }

  void _loadGerakans() async {
    try {
      var gerakans = await _gerakanClient.getGerakanByLevel(nav);
      setState(() {
        _gerakans = gerakans;
      });
    } catch (e) {
      print("Error fetching gerakans: $e");
    }
  }

  void changeGrid(int nav) {
    setState(() {
      this.nav = nav;
      _gerakans = null;
    });
    _loadGerakans();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  changeGrid(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: nav == 1
                                  ? ColorC().primaryColor1
                                  : Colors.white))),
                  child: Text(
                    'Beginner',
                    style: StyleText().styleH3l,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  changeGrid(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: nav == 2
                                  ? ColorC().primaryColor1
                                  : Colors.white))),
                  child: Text(
                    'Intermediate',
                    style: StyleText().styleH3l,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  changeGrid(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: nav == 3
                                  ? ColorC().primaryColor1
                                  : Colors.white))),
                  child: Text(
                    'Advance',
                    style: StyleText().styleH3l,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: _gerakans == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _gerakans!.length,
                    itemBuilder: (context, index) {
                      var gerakan = _gerakans![index];
                      return MaterialButton(
                        onPressed: () {
                          // Handle navigation logic here
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(gerakan
                                  .imageGerakan),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  gerakan
                                      .namaGerakan,
                                  style: StyleText().styleH3bWithColor,
                                ),
                                Text(
                                  gerakan
                                      .deskripsi,
                                  style: StyleText().stylePlWithColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
