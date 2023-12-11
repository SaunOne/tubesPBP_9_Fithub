import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/SubscriptionClient.dart';
import 'package:ugd6_b_9/entity/model/bank.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
import 'package:ugd6_b_9/entity/model/subscription.dart';
import 'package:ugd6_b_9/entity/model/user.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:intl/intl.dart';
import 'package:ugd6_b_9/view/temporary/dummby_generateDocument.dart';
import 'package:ugd6_b_9/view/temporary/pdf_view.dart';
import 'package:ugd6_b_9/view/temporary/preview_screenforPDF.dart';

class NotaPage extends StatefulWidget {
  User user;
  JenisPaket jensiPaket;
  Bank bank;
  int id_subscription;
  NotaPage(
      {super.key,
      required this.user,
      required this.bank,
      required this.jensiPaket,
      required this.id_subscription});

  @override
  State<NotaPage> createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
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
            double harga = jenisPaket!.harga - (jenisPaket!.harga * (jenisPaket!.promo / 100));
            hitungTotalHarga(harga, (jenisPaket!.harga * 0.01));
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    'Payment successfully',
                                    style: StyleText().styleH2bWithColor,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.print,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            // return  
                                              return HomePage();
                                              // PreviewScreen(doc: await generateInvoice().then((value) {
                                              //   return value;
                                              // }));
                                            
                                          } 
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/SuccessPayment.json',
                                    width: 100,
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
                                    'Invoice #${subscription!.id}',
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
                                      Icon(Icons.date_range_outlined,
                                          color: Color.fromARGB(
                                              255, 100, 100, 100)),
                                      Text(
                                        ' Transaction Date ' +
                                            '${formattedDate}',
                                        style: StyleText(
                                                color: Color.fromARGB(
                                                    255, 100, 100, 100))
                                            .styleH3lWithColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'IDR' + ' ${totalHarga}',
                                    style: StyleText(
                                            color: const Color.fromARGB(
                                                255, 0, 135, 104))
                                        .styleH2lWithColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To: ',
                                  style: StyleText().styleH3bWithColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${user!.fullname}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Dapatkan manfaat maksimal dari latihan Anda dengan FitHub Premium. Raih kebugaran terbaik dengan fitur eksklusif kami.',
                                  style: StyleText(
                                          color: Color.fromARGB(
                                              255, 100, 100, 100))
                                      .stylePlWithColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(32, 175, 177, 199),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: ColorC().primaryColor3),
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
                                        '${subscription!.id}',
                                        style: StyleText().styleH2lWithColor,
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
                                        '${jenisPaket!.namaMembership}',
                                        style: StyleText().styleH2lWithColor,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Payment Method : ',
                                              style: StyleText(
                                                      color: Color.fromARGB(
                                                          255, 100, 100, 100))
                                                  .styleH4lWithColor,
                                            ),
                                            Text(
                                              '${bank!.namaBank}',
                                              style:
                                                  StyleText().styleH2lWithColor,
                                            ),
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Payment',
                                style: StyleText().styleH2bWithColor,
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${jenisPaket!.namaMembership}',
                                    style: StyleText().styleH3lWithColor,
                                  ),
                                  Spacer(),
                                  Text(
                                    'IDR ' + '${harga}',
                                    style: StyleText().styleH3lWithColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tax ',
                                style: StyleText().styleH3lWithColor,
                              ),
                              Spacer(),
                              Text(
                                'IDR ${jenisPaket!.harga * 0.01}',
                                style: StyleText().styleH3lWithColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total ',
                                style: StyleText().styleH3lWithColor,
                              ),
                              Spacer(),
                              Text(
                                'IDR ' + '${totalHarga}',
                                style: StyleText().styleH3lWithColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Dengan langganan FitHub Premium Anda, Anda telah memilih investasi terbaik untuk kesehatan dan kebugaran Anda. Selamat menikmati perjalanan menuju gaya hidup sehat!',
                                  style: StyleText(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                  ).stylePlWithColor,
                                  textAlign: TextAlign.center,
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
        });
  }
}
