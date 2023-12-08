import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/MengajarClient.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/database/Client/TrainerClient.dart';
import 'package:ugd6_b_9/entity/model/mengajar_trainer.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart';
import 'package:ugd6_b_9/entity/model/trainer.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/content/detailTrainer.dart';

class TrainerView extends StatefulWidget {
  const TrainerView({super.key});

  @override
  State<TrainerView> createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView> {
  late List<Trainer> trainerList;

  Future<void> fetchData() async {
    await TrainerClient().showAllTrainers().then((value) {
      print('value : ${value}');

      setState(() {
        trainerList = value;
      });
    });
  }

  Future<List<Trainer>> fetchData_future() async {
    trainerList = await TrainerClient().showAllTrainers();
    return trainerList;
  }

  Future<bool> checkData() async {
    return trainerList != null;
  }


  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    fetchData().then((_) {
      // Access the data after it has been fetched
      if (trainerList != null && trainerList.isNotEmpty) {
        print('trainer name : ${trainerList[0].namaTrainer}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Trainer>>(
      future: fetchData_future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Trainer',
                style: StyleText(color: Colors.black).styleH2bWithColor,
              ),
            ),
            body: Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(),
                child: ListView.builder(
                  itemCount: trainerList.length,
                  itemBuilder: (context, index) {
                    Trainer trainer = trainerList[index];

                    // print('nama trainer : ${trainer.tempatGym!.namaTempat}');
                    return MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                      onPressed: () {
                        print(
                            "id sebelum masuk ${trainer.namaTrainer} : ${trainer.id}");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailTrainer(id_tempat_gym: trainer.id);
                        }));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            const BoxShadow(
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
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/trainer/trainer${index + 1}.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trainer.namaTrainer,
                                    style: StyleText().styleH4bWithColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        child: Text(
                                          'Experience',
                                          style: StyleText().styleP2lWithColor,
                                        ),
                                      ),
                                      Text(': ${trainer.experience} ',
                                          style: StyleText()
                                              .styleP2lWithColor), //data experience
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        child: Text(
                                          'Phone',
                                          style: StyleText().styleP2lWithColor,
                                        ),
                                      ),
                                      Text(': ${trainer.phoneNumber}',
                                          style: StyleText()
                                              .styleP2lWithColor), //data umur
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        child: Text(
                                          'Age',
                                          style: StyleText().styleP2lWithColor,
                                        ),
                                      ),
                                      Text(': ${trainer.age}',
                                          style: StyleText()
                                              .styleP2lWithColor), //data experience
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Avaiable',
                                    style: StyleText().styleP2lWithColor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    // color: Colors.amber,
                                    height: 0.02 * h,
                                    width: 0.52 * w,
                                    child: FutureBuilder<List<MengajarTrainer>>(
                                      future: MengajarTrainerClient()
                                          .showMengajarByTrainerID(trainer.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
                                        } else if (snapshot.hasError) {
                                          print(snapshot);
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Text('Tidak ada data.');
                                        } else {
                                          List<MengajarTrainer> listMengajar =
                                              snapshot.data!;
                                          print(
                                              'isi mengajar : ${listMengajar.length}');
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: listMengajar.length,
                                            itemBuilder: (context, index) {
                                              MengajarTrainer mengajar =
                                                  listMengajar[index];
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                height: 17,
                                                decoration: BoxDecoration(
                                                    color:
                                                        ColorC().primaryColor1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  '${mengajar.jadwalMengajar!.hari}',
                                                  style: StyleText(
                                                          color: Colors.white)
                                                      .styleP3bWithColor,
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
