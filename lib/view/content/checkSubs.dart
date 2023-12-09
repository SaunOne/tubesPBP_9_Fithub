import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/SubscriptionClient.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/view/content/notaView.dart';
import 'package:ugd6_b_9/view/content/subcriptionView.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:uuid/uuid.dart';
import 'package:ugd6_b_9/entity/model/bank.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
import 'package:ugd6_b_9/entity/model/subscription.dart';
import 'package:ugd6_b_9/entity/model/user.dart';

class MembershipPage extends StatefulWidget {
  User user;
  JenisPaket jensiPaket;
  Bank bank;
  int id_subscription;
  MembershipPage(
      {super.key,
      required this.user,
      required this.bank,
      required this.jensiPaket,
      required this.id_subscription});

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  Bank? bank;
  User? user;
  JenisPaket? jenisPaket;
  Subscription? subscription;
  double totalHarga = 0;

  Future<void> fetchData() async {
    bank = widget.bank;
    user = widget.user;
    jenisPaket = widget.jensiPaket;

    await SubscriptionClient()
        .showSubscriptionById(widget.id_subscription)
        .then((value) {
      subscription = value;
      print('data sub : ${value.tanggalPembayaran}');
    });
  }

  Future<Subscription> fetchData_future() async {
    return await SubscriptionClient()
        .showSubscriptionById(widget.id_subscription);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void hitungTotalHarga(harga, pajak) {
    totalHarga = harga + pajak;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Subscription>(
        future: fetchData_future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            String tanggal = subscription!.tanggalPembayaran.toString();
            DateTime parsedDate = DateTime.parse(tanggal);
            String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
            double harga = jenisPaket!.harga -
                (jenisPaket!.harga * (jenisPaket!.promo / 100));
            hitungTotalHarga(harga, (jenisPaket!.harga * 0.01));
            
            return Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
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
                                  'Detail Subscription',
                                  style: StyleText().styleH2bWithColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Lottie.asset(
                              'assets/Validate.json',
                              width: 500,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text(
                                    'Manage your membership preferences. You can either update your details to enjoy the latest benefits, or if you no longer wish to continue, choose to cancel your membership.',
                                    textAlign: TextAlign.center,
                                    style: StyleText().styleH4lWithColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          SubscriptionClient().deleteSubscription(subscription!.id);
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return HomePage();
                                          }));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              
                                              content: Row(children: [
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Cancel Successfully",
                                                  style: StyleText()
                                                      .styleH4lWithColor,
                                                ),
                                              ]),
                                              backgroundColor: Color.fromARGB(255, 20, 164, 1),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          primary: Colors.red,
                                          fixedSize: Size(100, 30),
                                        ),
                                        
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('masih aman gakk?? : ${subscription!.id}');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SubcriptionView(id: 1,type: 2,updateSubs: subscription),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          primary: Colors.orange,
                                          fixedSize: Size(100, 30),
                                        ),
                                        child: const Text(
                                          'Change',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(32, 175, 177, 199),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorC().primaryColor3),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID Subscription:',
                                            style: StyleText(
                                                    color: const Color.fromARGB(
                                                        255, 100, 100, 100))
                                                .styleH4lWithColor,
                                          ),
                                          Text(
                                            'ID00234SM12',
                                            style:
                                                StyleText().styleH2lWithColor,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Name Subscription : ',
                                            style: StyleText(
                                                    color: const Color.fromARGB(
                                                        255, 100, 100, 100))
                                                .styleH4lWithColor,
                                          ),
                                          Text(
                                            'Basic Package',
                                            style:
                                                StyleText().styleH2lWithColor,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Expired Date:',
                                            style: StyleText(
                                                    color: Color.fromARGB(
                                                        255, 100, 100, 100))
                                                .styleH4lWithColor,
                                          ),
                                          Text(
                                            '12-12-2024',
                                            style:
                                                StyleText().styleH2lWithColor,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Price : ',
                                            style: StyleText(
                                                    color: Color.fromARGB(
                                                        255, 100, 100, 100))
                                                .styleH4lWithColor,
                                          ),
                                          Text(
                                            'IDR 2.000.000',
                                            style:
                                                StyleText().styleH2lWithColor,
                                          ),
                                          Text(
                                            'Payment Method : ',
                                            style: StyleText(
                                                    color: Color.fromARGB(
                                                        255, 100, 100, 100))
                                                .styleH4lWithColor,
                                          ),
                                          Text(
                                            'Bank BCA',
                                            style:
                                                StyleText().styleH2lWithColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NotaPage(bank: bank!,jensiPaket: jenisPaket!,user: user!,id_subscription: user!.id,),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      primary: ColorC().primaryColor1,
                                      fixedSize: Size(200, 50),
                                    ),
                                    child: Text(
                                      'Next Details',
                                      style: StyleText(color: Colors.white)
                                          .styleH4bWithColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
