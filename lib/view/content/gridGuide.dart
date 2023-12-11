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
  late List<Gerakan> intermediate = [];
  late List<Gerakan> beginner = [];
  late List<Gerakan> advance = [];
  late List<Gerakan> mainListGerakan = [];
  List<String> listLevel = ['Beginner','Intermediate','Advance'];

  Future<void> fetchData() async {
    await GerakanClient().getGerakanByLevel(1).then((value) {
      print('value : ${value}');
      setState(() {
        beginner = value;
      });
    });
    await GerakanClient().getGerakanByLevel(2).then((value) {
      print('value : ${value}');
      setState(() {
        intermediate = value;
      });
    });
    await GerakanClient().getGerakanByLevel(3).then((value) {
      print('value : ${value}');
      setState(() {
        advance = value;
      });
    });

    await GerakanClient().getGerakanByLevel(1).then((value) {
      setState(() {
        mainListGerakan = value;
        print('data masuk : ${value}' );
      });
    });
  }

  void activeMainListGerakan(listGerakan) {
    setState(() {
       mainListGerakan = listGerakan;
    });
   
  }

  Future<List<Gerakan>> fetch_check() async {
    return await GerakanClient().getGerakanByLevel(1);
  }

  Future<bool> checkData() async {
    
    return mainListGerakan != await null;
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
    return FutureBuilder<List<Gerakan>>(
      future: fetch_check(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Tampilkan indikator loading jika masih menunggu data
        } else if (snapshot.hasError) {
          print('error : ${snapshot}');
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('Tidak ada data.');
        } else {
        
          // print('isi mengajar : ${trainer[1].namaTrainer}');
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
                        activeMainListGerakan(beginner);
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
                        activeMainListGerakan(intermediate);
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
                        activeMainListGerakan(advance);
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
                        for (int i = 0; i < mainListGerakan.length; i++)
                          MaterialButton(
                            onPressed: () {
                              print('length : ${mainListGerakan.length}');
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Guide(id: mainListGerakan[i].id);
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/gerakan/${mainListGerakan[i].imageGerakan}.jpg'),
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
                                      '${mainListGerakan[i].namaGerakan}',
                                      style: StyleText().styleH3bWithColor,
                                    ),
                                    Text(
                                      '|Workouts for ${mainListGerakan[i].levelGerakan!.levelGerakan}',
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
      },
    );
  }
}
