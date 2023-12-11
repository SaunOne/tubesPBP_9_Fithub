import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/GerakanClient.dart';
import 'package:ugd6_b_9/entity/model/gerakan.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/feature/timer.dart';

class Guide extends StatefulWidget {
  int id;
  Guide({super.key, required this.id});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  int? id;

  @override
  void initState() {
    id = widget.id;

    // TODO: implement initState
    super.initState();
  }

  int setJumlahGerakan(String levelGerakan){
    print('level Gerakan : ${levelGerakan}');
    if(levelGerakan == 'Beginner'){
      return 2;
    } else if(levelGerakan == 'Intermediate'){
      return 4;
    } else {
      return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Gerakan>(
      future: GerakanClient().getGerakanById(id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
        } else if (snapshot.hasError) {
          print(snapshot);
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('Tidak ada data.');
        } else {
          Gerakan gerakan = snapshot.data!;
          int jumlahGerakan = setJumlahGerakan(gerakan.levelGerakan!.levelGerakan);
          print('jumlah  : ${jumlahGerakan}');
          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                      'assets/images/gerakan/${gerakan.imageGerakan}.jpg'),
                  fit: BoxFit.fitWidth,
                  isAntiAlias: true,
                ),
                color: Colors.red,
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  height: 200,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.chevronLeft),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                            '${gerakan.namaGerakan}',
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
                                ' ${gerakan.levelGerakan!.levelGerakan}',
                                style: StyleText().styleH3b,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(gerakan.deskripsi,style: StyleText(color: Color.fromARGB(255, 85, 85, 85)).styleH4lWithColor,),
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
                          Flexible(
                            
                            child: SingleChildScrollView(
                              child: Column(children: [
                                for (int i = 0; i < jumlahGerakan; i++)
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
                                                      'assets/images/gerakan/${gerakan.imageGerakan}.jpg'),
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
                                                Text('${gerakan.namaGerakan}',
                                                    style: StyleText(
                                                            color: Colors.white)
                                                        .stylePbWithColor),
                                                Text('01:00',
                                                    style: StyleText(
                                                            color: Colors.white)
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
              color: gerakan.levelGerakan!.levelGerakan == 'Advanced'? Colors.white : ColorC().primaryColor1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Start',
                style: StyleText(color: gerakan.levelGerakan!.levelGerakan == 'Advanced'? Colors.black : Colors.white).styleH2bWithColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.timerPage);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  }
}
