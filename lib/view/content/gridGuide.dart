import 'package:flutter/material.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/GerakanClient.dart';
import 'package:ugd6_b_9/entity/model/gerakan.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/main.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/feature/track.dart';

class GridGuide extends StatefulWidget {
  const GridGuide({super.key});

  @override
  State<GridGuide> createState() => _GridGuideState();
}

class _GridGuideState extends State<GridGuide> {
  int nav = 1;
  late List<Gerakan> intermediate;
  late List<Gerakan> beginner;
  late List<Gerakan> advance;
  late List<Gerakan> mainListGerakan;

  Future<void> fetchData() async {
    await GerakanClient().getGerakanByLevel(1).then((value) {
      print('value : ${value}');
      setState(() {
         intermediate = value;
      });
    });
    await GerakanClient().getGerakanByLevel(2).then((value) {
      print('value : ${value}');
      setState(() {
         beginner = value;
      });
    });
    await GerakanClient().getGerakanByLevel(3).then((value) {
      print('value : ${value}');
      setState(() {
         advance = value;
      });
    });
  }

  void activeMainListGerakan(listGerakan){
    setState(() {
       mainListGerakan = listGerakan;
    });
   
  }

  Future<bool> checkData() async {
    return mainListGerakan != null;
  }

  void changeGrid(nav) {
    setState(() {
      this.nav = nav;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
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
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  for (int i = 1; i <= 3; i++)
                    MaterialButton(
                      onPressed: () {
                        
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: i == 2
                                ? AssetImage('assets/images/eGym$i.jpg')
                                : AssetImage('assets/images/eGym$i.png'),
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
                                'Beginer',
                                style: StyleText().styleH3bWithColor,
                              ),
                              Text(
                                '|6 Workouts for Beginner',
                                style: StyleText().stylePlWithColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
