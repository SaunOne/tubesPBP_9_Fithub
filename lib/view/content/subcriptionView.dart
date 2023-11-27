import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:card_swiper/card_swiper.dart';

class SubcriptionView extends StatefulWidget {
  const SubcriptionView({super.key});

  @override
  State<SubcriptionView> createState() => _SubcriptionViewState();
}

class _SubcriptionViewState extends State<SubcriptionView> {
  List<Image> images = [
    Image.asset('assets/images/sGym.png'),
    Image.asset('assets/images/eGym1.png'),
    Image.asset('assets/images/eGym2.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'assets/images/sGym.png',
              fit: BoxFit.fill,
            ),
          ),
          Swiper.children(
            autoplay: false,
            pagination: const SwiperPagination(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 10.0,
                    activeSize: 15.0)),
            children: <Widget>[
              Container(
                color: Colors.amber,
                height: 100,
                width: 100,
              ),
              Container(
                color: const Color.fromARGB(255, 255, 114, 7),
              ),
              Container(
                color: const Color.fromARGB(255, 28, 7, 255),
              ),
            ],
          )
        ],
      ),
    );
  }
}
