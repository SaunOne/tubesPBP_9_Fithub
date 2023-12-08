import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/GerakanClient.dart';
import 'package:ugd6_b_9/database/Client/JenisPaketClient.dart';
import 'package:ugd6_b_9/database/Client/LevelGerakanClient.dart';
import 'package:ugd6_b_9/database/Client/MengajarClient.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/database/Client/TrainerClient.dart';
import 'package:ugd6_b_9/database/Client/UserClient.dart';
import 'package:ugd6_b_9/entity/model/User.dart';
import 'package:ugd6_b_9/entity/model/gerakan.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
import 'package:ugd6_b_9/entity/model/levelGerakan.dart';
import 'package:ugd6_b_9/entity/model/mengajar_trainer.dart';
import 'package:ugd6_b_9/entity/model/trainer.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/content/detailGuide.dart';
import 'package:ugd6_b_9/view/content/detailTrainer.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart';
import 'package:ugd6_b_9/view/content/searchGym.dart';
import 'package:ugd6_b_9/view/content/subcriptionView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = User.empty();

  late List<Trainer> listTrainer;
  late List<TempatGym> listTempatGym;
  late List<Gerakan> listGerakan;
  late List<JenisPaket> listJenisPaket;
  late List<LevelGerakan> listLevelGerakan;
  

  Future<void> fetchData() async {
    await TrainerClient().showTrainerHome().then((value) {
      print('length trainer : ${value.length}');

      setState(() {
        listTrainer = value;
      });
    });
    await TempatGymClient().showTempatGymHome().then((value) {
      print('length tempatGym : ${value.length}');

      setState(() {
        listTempatGym = value;
      });
    });
    await GerakanClient().showGerkaanHome().then((value) {
      print('length Gerakan : ${value.length}');

      setState(() {
        listGerakan = value;
      });
    });
    await JenisPaketClient().getAllJenisPaket().then((value) {
      print('length jenisPaket : ${value.length}');

      setState(() {
        listJenisPaket = value;
      });
    });
    await LevelGerakanClient().showAllLevelGerakan().then((value) {
      print('length jenisPaket : ${value.length}');

      setState(() {
        listLevelGerakan = value;
      });
    });
  }

  Future<List<Trainer>> fetchData_future_trainerGym() async {
    listTrainer = await TrainerClient().showTrainerHome();
    return listTrainer;
  }

  Future<List<TempatGym>> fetchData_future_tempatGym() async {
    listTempatGym = await TempatGymClient().showTempatGymHome();
    return listTempatGym;
  }

  Future<List<Gerakan>> fetchData_future_gerakan() async {
    listGerakan = await GerakanClient().showGerkaanHome();
    return listGerakan;
  }

  Future<List<JenisPaket>> fetchData_future_jenisPaket() async {
    listJenisPaket = await JenisPaketClient().getAllJenisPaket();
    return listJenisPaket;
  }

  Future<bool> checkData() async {
    return listTrainer != null;
  }

  String findLevelGerakan(id){
    for(int i = 0 ; i < listLevelGerakan.length; i++){
      if(listLevelGerakan[i].id == id){
        return listLevelGerakan[i].levelGerakan;
      }
    }
    return '';
  }

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
    fetchData();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: fetchData_future_jenisPaket(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              body: HomeView(),
            );
          }
        });
  }

  SingleChildScrollView HomeView() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            greeting() + ',' + user.fullname,
            style: StyleText().styleH2bWithColor,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Your Next Workout',
                style: StyleText().styleH4bWithColor,
              ),
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
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.searchGym);
                },
                child: Text(
                  'See All',
                  style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                      .styleH4lWithColor,
                ),
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
                  for (int i = 0; i < listTempatGym.length; i++)
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SearchGym(id: listTempatGym[i].id);
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        alignment: Alignment.bottomCenter,
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/tempatGym/${listTempatGym[i].imageGym}.jpg',
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
                                ColorC().primaryColor1,
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
                                  '${listTempatGym[i].namaTempat}',
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
                                      '${listTempatGym[i].domisili}',
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
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.trainerView);
                },
                child: Text(
                  'See All',
                  style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                      .styleH4lWithColor,
                ),
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
            child: ListView.builder(
              itemCount: (listTrainer.length),
              itemBuilder: (context, index) {
                Trainer trainer = listTrainer[index];

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
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
                          width: 0.3 * w,
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
                              horizontal: 13, vertical: 13),
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
                                      return Text('Error: ${snapshot.error}');
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
                                            margin: EdgeInsets.only(right: 10),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            height: 17,
                                            decoration: BoxDecoration(
                                                color: ColorC().primaryColor1,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              '${mengajar.jadwalMengajar!.hari}',
                                              style:
                                                  StyleText(color: Colors.white)
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
              MaterialButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.subcriptionView);
                },
                child: Text(
                  'See All',
                  style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                      .styleH4lWithColor,
                ),
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
                  for (int i = 0; i < listJenisPaket.length; i++)
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SubcriptionView(id: listGerakan[i].id,);
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 180,
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/jenisPaket/${listJenisPaket[i].image}.jpg'),
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
                                    '${listJenisPaket[i].promo}% Off',
                                    style: StyleText(color: Colors.white)
                                        .styleH3bWithColor,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'IDR ${listJenisPaket[i].harga}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: const Color.fromARGB(255, 0, 0, 0), // Opsional, bisa dihilangkan jika tidak diperlukan
                                      decorationThickness:
                                          2.0, // Opsional, bisa dihilangkan jika tidak diperlukan
                                    ),
                                  ),
                                  Text(
                                   'IDR ${listJenisPaket[i].harga - (listJenisPaket[i].harga*(listJenisPaket[i].promo/100))}',
                                    style: StyleText(color: Colors.white)
                                        .stylePbWithColor,
                                  ),
                                ],
                              )
                            ],
                          ),
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
              MaterialButton(
                
                onPressed: () {
                  Navigator.pushNamed(context, Routes.gridGuidePage);
                },
                child: Text(
                  'See All',
                  style: StyleText(color: Color.fromARGB(255, 2, 81, 228))
                      .styleH4lWithColor,
                ),
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
                  for (int i = 0; i < 5; i++)
                    MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Guide();
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 5),
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
                              image: AssetImage('assets/images/gerakan/${listGerakan[i].imageGerakan}.jpg'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${findLevelGerakan(listGerakan[i].levelGerakanId)}',
                              style: StyleText().styleH4b,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '| ${listGerakan[i].namaGerakan}',
                                  style: StyleText().styleH4lWithColor,
                                ),
                              ],
                            ),
                          ],
                        ),
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
