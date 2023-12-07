// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/TrainerClient.dart';
import 'package:ugd6_b_9/entity/model/trainer.dart';
import 'package:ugd6_b_9/view/widget/customRatingWidget.dart';

class DetailTrainer extends StatefulWidget {
  int id_tempat_gym;
  DetailTrainer({super.key, required this.id_tempat_gym});
  @override
  State<DetailTrainer> createState() => _DetailTrainerState();
}

class _DetailTrainerState extends State<DetailTrainer> {
  int id = 0;
  @override
  void initState() {
    // TODO: implement initState;
    id = widget.id_tempat_gym;
    print('id trainer : ${id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage('assets/images/trainer/trainer${id}.jpg'),
              fit: BoxFit.cover),
        ),
        child: FutureBuilder<Trainer>(
          future: TrainerClient().findTrainerById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
            } else if (snapshot.hasError) {
              print(snapshot);
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('Tidak ada data.');
            } else {
              Trainer trainer = snapshot.data!;
              print('isi mengajar : ${trainer.namaTrainer}');
              return Column(
                children: [
                  SafeArea(
                    child: Container(
                      child: Row(
                        children: [
                          BackButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 350,
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${trainer.namaTrainer}",
                            style: StyleText().styleH2bWithColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${trainer.tempatGym!.domisili}',
                            style: StyleText().styleH4l,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                child: Text('Age', style: StyleText().styleH4l),
                              ),
                              Text(
                                ': ${trainer.age} Years',
                                style: StyleText().styleH4l,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                child:
                                    Text('Phone Number', style: StyleText().styleH4l),
                              ),
                              Text(
                                ': ${trainer.phoneNumber}',
                                style: StyleText().styleH4l,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                child: Text('Expereince',
                                    style: StyleText().styleH4l),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ': ${trainer.experience}',
                                      style: StyleText().styleH4l,
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
                            margin: EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Expert',
                              style: StyleText(color: Colors.white)
                                  .styleH4bWithColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomRatingWidget(rating: trainer.rating),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '${trainer.rating}',
                                style: StyleText().styleH3bWithColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 25,
                                decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Monday',
                                  style: StyleText(color: Colors.white)
                                      .stylePbWithColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 25,
                                decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Tuesday',
                                  style: StyleText(color: Colors.white)
                                      .stylePbWithColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 25,
                                decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Wednesday',
                                  style: StyleText(color: Colors.white)
                                      .stylePbWithColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
