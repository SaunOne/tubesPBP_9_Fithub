import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ugd6_b_9/view/content/paymentView.dart';

class SubcriptionView extends StatefulWidget {
  const SubcriptionView({super.key});

  @override
  State<SubcriptionView> createState() => _SubcriptionViewState();
}

class _SubcriptionViewState extends State<SubcriptionView> {
  int _currentOptionIndex = 0;
  CarouselController _carouselController = CarouselController();
  int _currentImageIndex = 0;
  int _currentIndicatorIndex = 0;

  List<Map<String, dynamic>> subscriptionOptions = [
    {
      'title': 'Basic',
      'price': 'IDR 750.000,00',
      'features': ['Gym conventional', 'Sauna'],
      'images': [
        'assets/img6.jpg',
        'assets/img7.jpg',
      ],
    },
    {
      'title': 'Premium',
      'price': 'IDR 1.150.000,00',
      'features': [
        'Gym conventional',
        'Sauna',
        'Powerlifting room',
        'Weightlifting room',
        'Free refill water',
        'Gym conventional',
        'Sauna',
        'Powerlifting room',
        'Weightlifting room',
        'Free refill water',
        'Gym conventional',
        'Sauna',
        'Powerlifting room',
        'Weightlifting room',
        'Free refill water',
      ],
      'images': [
        'assets/img8.jpg',
        'assets/img9.jpg',
        'assets/img8.jpg',
        'assets/img9.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var currentSubscription = subscriptionOptions[_currentOptionIndex];
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: currentSubscription['images'].length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        child: Image.asset(
                          currentSubscription['images'][index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  SizedBox(
                    height: 0.01 * h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        currentSubscription['title'],
                        style: TextStyle(
                          fontSize: 0.06 * w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentSubscription['price'],
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: SizedBox(
                          height: 0.15 * h,
                          child: ListView(
                            shrinkWrap: true,
                            children: currentSubscription['features']
                                .map<Widget>((feature) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: ColorC().primaryColor1,
                                      size: 0.04 * w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: TextStyle(
                                          fontSize: 0.04 * w,
                                          color: ColorC().primaryColor1,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Container(
                        width: 0.9 * w,
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            buildNavigationControls(),
            SizedBox(height: 0.1 * h),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationControls() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorC().primaryColor1),
          onPressed: () {
            if (_currentOptionIndex > 0) {
              _carouselController.previousPage();
              setState(() {
                _currentOptionIndex--;
              });
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PaymentPage()),
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
            if (_currentOptionIndex < subscriptionOptions.length - 1) {
              _carouselController.nextPage();
              setState(() {
                _currentOptionIndex++;
              });
            }
          },
        ),
      ],
    );
  }
}
