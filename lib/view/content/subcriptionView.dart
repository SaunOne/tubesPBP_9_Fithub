import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubcriptionView extends StatefulWidget {
  const SubcriptionView({super.key});

  @override
  State<SubcriptionView> createState() => _SubcriptionViewState();
}

class _SubcriptionViewState extends State<SubcriptionView> {
  int _currentOptionIndex = 0;
  int _currentImageIndex = 0;

  List<Map<String, dynamic>> subscriptionOptions = [
    {
      'title': 'Basic',
      'price': 'IDR 750.000,00',
      'features': ['Gym conventional', 'Sauna'],
      'images': [
        'assets/img1.jpg', // Path to your basic plan image
        'assets/img10.jpg', // Add more images as needed
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
        'assets/img8.jpg', // Path to your premium plan image
        'assets/img9.jpg', // Add more images as needed
      ],
    },
  ];

   @override
  Widget build(BuildContext context) {
    var currentSubscription = subscriptionOptions[_currentOptionIndex];

    return Scaffold(
      backgroundColor: Colors.white, // Assuming a white background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // To add space between the elements
          children: [
            SizedBox(height: 5.h), // Extra space at the top
            CarouselSlider.builder(
              itemCount: currentSubscription['images'].length,
              itemBuilder: (context, index, realIndex) {
                return Image.asset(
                  currentSubscription['images'][index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
              options: CarouselOptions(
                height: 200.0, // Adjust the height to fit the design
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentOptionIndex = index;
                  });
                },
              ),
            ),
            Column(
              children: [
                Text(
                  currentSubscription['title'],
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentSubscription['price'],
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ...currentSubscription['features'].map(
                  (feature) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 22.sp),
                        SizedBox(width: 2.w),
                        Text(
                          feature,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildNavigationControls(),
            SizedBox(height: 5.h), // Extra space at the bottom
          ],
        ),
      ),
    );
  }

  Widget buildNavigationControls() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
            onPressed: _currentOptionIndex > 0
                ? () => setState(() => _currentOptionIndex--)
                : null,
          ),
          ElevatedButton(
            onPressed: () {
              // Implement subscription logic here
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.5.h),
            ),
            child: Text(
              'Subscribe',
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
            onPressed: _currentOptionIndex < subscriptionOptions.length - 1
                ? () => setState(() => _currentOptionIndex++)
                : null,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: SubcriptionView(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
