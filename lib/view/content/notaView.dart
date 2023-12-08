import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/temporary/preview_screenforPDF.dart';
import 'package:ugd6_b_9/view/temporary/dummby_generateDocument.dart';

class NotaPage extends StatefulWidget {
  const NotaPage({super.key});

  @override
  State<NotaPage> createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onPressed: () async {
                              final doc = await generateInvoice();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewScreen(
                                    doc: doc,
                                  ),
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
                            'Invoice #33337777',
                            style: StyleText(color: ColorC().primaryColor1)
                                .styleH2bWithColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.date_range_outlined,
                                  color: Color.fromARGB(255, 100, 100, 100)),
                              Text(
                                ' Transaction Date ' + '18-12-2023',
                                style: StyleText(
                                        color:
                                            Color.fromARGB(255, 100, 100, 100))
                                    .styleH3lWithColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'IDR' + ' 200.0000',
                            style: StyleText(
                                    color:
                                        const Color.fromARGB(255, 0, 135, 104))
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          'Made Yosa Bagas Brawijaya',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Dapatkan manfaat maksimal dari latihan Anda dengan FitHub Premium. Raih kebugaran terbaik dengan fitur eksklusif kami.',
                          style: StyleText(
                                  color: Color.fromARGB(255, 100, 100, 100))
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Basic Package',
                                style: StyleText().styleH2lWithColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Expired Date:',
                                style: StyleText(
                                        color:
                                            Color.fromARGB(255, 100, 100, 100))
                                    .styleH4lWithColor,
                              ),
                              Text(
                                '12-12-2024',
                                style: StyleText().styleH2lWithColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Method : ',
                                      style: StyleText(
                                              color: Color.fromARGB(
                                                  255, 100, 100, 100))
                                          .styleH4lWithColor,
                                    ),
                                    Text(
                                      'Bank BCA',
                                      style: StyleText().styleH2lWithColor,
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
                            'Basic Package',
                            style: StyleText().styleH3lWithColor,
                          ),
                          Spacer(),
                          Text(
                            'IDR 200.000',
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
                        'IDR 7.500 (1%)',
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
                        'IDR 300.000',
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
}
