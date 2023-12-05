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

  List<Map<String, dynamic>> subscriptionOptions = [
    {
      'title': 'Basic',
      'price': 'IDR 750.000,00',
      'features': ['Gym conventional', 'Sauna'],
      'images': [
        'assets/img1.jpg',
        'assets/img10.jpg',
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
      ],
      'images': [
        'assets/img8.jpg',
        'assets/img9.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var currentSubscription = subscriptionOptions[_currentOptionIndex];
    

    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 0.3 * h),
            Expanded(
              flex: 3,
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: currentSubscription['images'].length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      currentSubscription['images'][index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  currentSubscription['images'].length, (index) {
                return Container(
                  width: 5.0,
                  height: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.4),
                  ),
                );
              }),
            ),
            Column(
              children: [
                Text(
                  currentSubscription['title'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentSubscription['price'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),  
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        currentSubscription['features'].map<Widget>((feature) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                              size: 22,
                            ),
                            SizedBox(width: 2 * w),
                            Text(
                              feature,
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            buildNavigationControls(),
            SizedBox(height: 3 * h),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          ),
          child: Text(
            'Subscribe',
            style: TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
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
