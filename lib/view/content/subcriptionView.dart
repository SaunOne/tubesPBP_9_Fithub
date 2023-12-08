import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ugd6_b_9/database/Client/FasilitasClient.dart';
import 'package:ugd6_b_9/database/Client/JenisPaketClient.dart';
import 'package:ugd6_b_9/entity/model/fasilitas.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
import 'package:ugd6_b_9/view/content/paymentView.dart';

class SubcriptionView extends StatefulWidget {
  int id;
  SubcriptionView({super.key, required this.id});

  @override
  State<SubcriptionView> createState() => _SubcriptionViewState();
}

class _SubcriptionViewState extends State<SubcriptionView> {
  int _currentOptionIndex = 0;
  CarouselController _carouselController = CarouselController();
  int _currentImageIndex = 0;
  int _currentIndicatorIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<JenisPaket>>(
        future: JenisPaketClient().getAllJenisPaket(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot);
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('Tidak ada data.');
          } else {
            List<JenisPaket> listJenisPaket = snapshot.data!;
            print(
                'di atasi sebelum masuk ${listJenisPaket[_currentImageIndex].id}');
            return Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.045 * h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/jenisPaket/${listJenisPaket[_currentOptionIndex].image}.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 300,
                            width: double.infinity,
                          ),
                          SizedBox(
                            height: 0.02 * h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                listJenisPaket[_currentOptionIndex]
                                    .namaMembership,
                                style: TextStyle(
                                  fontSize: 0.06 * w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp.${listJenisPaket[_currentOptionIndex].harga}',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color.fromARGB(255, 255, 0, 0), // Opsional, bisa dihilangkan jika tidak diperlukan
                                  decorationThickness:
                                      2.0, // Opsional, bisa dihilangkan jika tidak diperlukan
                                ),
                              ),
                              Text(
                                'Rp.${listJenisPaket[_currentOptionIndex].harga - (listJenisPaket[_currentOptionIndex].harga * (listJenisPaket[_currentOptionIndex].promo / 100))}',
                                style: TextStyle(
                                  fontSize: 0.06 * w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                width: 0.9 * w,
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: SizedBox(
                                  height: 0.11 * h,
                                  child: FutureBuilder<List<Fasilitas>>(
                                    future: FasilitasClient()
                                        .showFasilitasByJenisPaket(
                                            listJenisPaket[_currentOptionIndex]
                                                .id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        print(snapshot);
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData) {
                                        return Text('Tidak ada data.');
                                      } else {
                                        List<Fasilitas> listFaislitas =
                                            snapshot.data!;
                                        return ListView.builder(
                                          itemCount: listFaislitas.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    color:
                                                        ColorC().primaryColor1,
                                                    size: 0.04 * w,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      listFaislitas[index]
                                                          .namaFasilitas,
                                                      style: TextStyle(
                                                        fontSize: 0.04 * w,
                                                        color: ColorC()
                                                            .primaryColor1,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          shrinkWrap: true,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    buildNavigationControls(listJenisPaket.length,
                        listJenisPaket[_currentOptionIndex].id),
                    SizedBox(height: 0.08 * h),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildNavigationControls(int length, int id_paket) {
    print('id_paket $id_paket');
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorC().primaryColor1),
          onPressed: () {
            _carouselController.previousPage();
            setState(() {
              if (_currentOptionIndex == 0) {
                _currentOptionIndex = (length - 1);
              } else {
                _currentOptionIndex--;
              }
              print('length = ${length} : index ${_currentOptionIndex}');
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentPage(id_paket: id_paket)),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: ColorC().primaryColor1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 8.0),
          ),
          child: Text(
            'Subscribe',
            style: TextStyle(fontSize: 0.04 * w),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: ColorC().primaryColor1),
          onPressed: () {
            setState(() {
              if (_currentOptionIndex == (length - 1)) {
                // _carouselController.jumpToPage(0);
                _currentOptionIndex = 0;
              } else {
                // _carouselController.nextPage();
                _currentOptionIndex++;
              }
              print('length = ${length} : index ${_currentOptionIndex}');
            });
          },
        ),
      ],
    );
  }
}
