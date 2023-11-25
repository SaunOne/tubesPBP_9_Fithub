import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/routes/routes.dart';

class TrainerView extends StatefulWidget {
  const TrainerView({super.key});

  @override
  State<TrainerView> createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Trainer',style: StyleText(color: Colors.black).styleH2bWithColor,),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(),
            child: Column(
              children: [
                for(int i = 0; i < 12 ; i++)
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.detailTrainer);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 140,
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
                                image: AssetImage('assets/images/tGym1.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bala Putra Dewa',style: StyleText().styleH4bWithColor,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text('Experience',style: StyleText().styleP2lWithColor,),
                                  ),
                                  Text(': National Bodybuilding Champion',style: StyleText().styleP2lWithColor),//data experience
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text('Age',style: StyleText().styleP2lWithColor,),
                                  ),
                                  Text(': 27 Years',style: StyleText().styleP2lWithColor),//data umur
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text('Domicile',style: StyleText().styleP2lWithColor,),
                                  ),
                                  Text(': Cabang Jogja',style: StyleText().styleP2lWithColor),//data experience
                                ],
                              ),
                              SizedBox(height: 3,),
                              Text('Avaiable',style: StyleText().styleP2lWithColor,),
                              SizedBox(height: 8,),
                              Row(children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  height: 17 ,
                                  
                                  decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text('Monday',style: StyleText(color: Colors.white).styleP3bWithColor,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  height: 17 ,
                
                                  decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text('Tuesday',style: StyleText(color: Colors.white).styleP3bWithColor,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  height: 17 ,
                
                                  decoration: BoxDecoration(
                                    color: ColorC().primaryColor1,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text('Wednesday',style: StyleText(color: Colors.white).styleP3bWithColor,),
                                ),
                              ],)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
