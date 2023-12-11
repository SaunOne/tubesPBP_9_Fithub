// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart';
import 'package:ugd6_b_9/main.dart';
import 'package:ugd6_b_9/view/homePage.dart';
import 'package:ugd6_b_9/view/widget/customRatingWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GymLocation {
  final String name;
  final String location;
  final String address;
  final String openHours;
  final String phoneNumber;
  final double rating;
  final String imageAsset;

  GymLocation({
    required this.name,
    required this.location,
    required this.address,
    required this.openHours,
    required this.phoneNumber,
    required this.rating,
    required this.imageAsset,
  });
}

class SearchGym extends StatefulWidget {
  int id;
  SearchGym({Key? key,required this.id}) : super(key: key);

  @override
  State<SearchGym> createState() => _SearchGymState();
}

class _SearchGymState extends State<SearchGym> {
  String selectedLocation = 'Semua Gym';
  PageController pageController = PageController();
  int indexTempatGym = 0;
  String domisili = 'Semua Gym';

  late List<TempatGym> tempatGymList;
  late List<TempatGym> jakarta = [];
  late List<TempatGym> yogyakarta = [];
  late List<TempatGym> bandung = [];

  List<TempatGym> mainTempatGym = [];

  Future<void> fetchData() async {
    await TempatGymClient().showAllTempatGym().then((value) {
      print('value : ${value}');
      setState(() {
        tempatGymList = value;
      });
    });

    // ... add other locations if needed
    setState(() {
      for (int i = 0; i < tempatGymList.length; i++) {
        if (tempatGymList[i].domisili == 'Yogyakarta') {
          jakarta.add(tempatGymList[i]);
        } else if (tempatGymList[i].domisili == 'Jakarta') {
          yogyakarta.add(tempatGymList[i]);
        } else if (tempatGymList[i].domisili == 'Bandung') {
          bandung.add(tempatGymList[i]);
        } 
      }
      
    });
    mainTempatGym = tempatGymList;
    print('Yogya : ${yogyakarta}');
  }

  Future<List<TempatGym>> fetchData_future() async {
    
    tempatGymList = await TempatGymClient().showAllTempatGym();
    return tempatGymList;
  }

  Future<bool> checkData() async {
    return tempatGymList != null;
  }

  @override
  void initState() {
   print('hai2');
   indexTempatGym = widget.id;
    super.initState();
    // TODO: implement initState
    fetchData().then((_) {
      
      // Access the data after it has been fetched
      if (tempatGymList != null && tempatGymList.isNotEmpty) {
        print('trainer name : ${tempatGymList[0].domisili}');
      }
    });
  }

  List<GymLocation> gymLocations = [
    GymLocation(
      name: 'Celebrity Fitness',
      location: 'Jakarta',
      address: 'City Walk',
      openHours: '6 AM–8 PM',
      phoneNumber: '02742922842',
      rating: 4.3,
      imageAsset: 'assets/images/tGym1.png',
    ),
    GymLocation(
      name: 'Celebrity Fitness',
      location: 'Jakarta',
      address: 'City Walk',
      openHours: '6 AM–8 PM',
      phoneNumber: '02742922842',
      rating: 4.3,
      imageAsset: 'assets/images/tGym1.png',
    ),
    GymLocation(
      name: 'Celebrity Fitness',
      location: 'Jakarta',
      address: 'City Walk',
      openHours: '6 AM–8 PM',
      phoneNumber: '02742922842',
      rating: 4.3,
      imageAsset: 'assets/images/tGym1.png',
    ),
  ]; // Default location

  @override
  Widget build(BuildContext context) {
    
            return SafeArea( 
              child: Scaffold(
                backgroundColor: ColorC().whiteColor,
                body: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Selamat datang, Yosa',
                              style: StyleText(color: Colors.black)
                                  .styleH2bWithColor,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                buildLocationText('Semua Gym'),
                                buildLocationText('Jakarta'),
                                buildLocationText('Bandung'),
                                buildLocationText('Yogyakarta'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 240,
                            width: 320,
                            child: PageView.builder(
                              onPageChanged: (index){
                                setState(() {
                                  indexTempatGym = index;
                                  
                                });
                                
                                print('index : $index');
                              },
                              controller: pageController,
                              // itemCount: pages.length,
                              itemBuilder: (_, index) {
                                indexTempatGym = index;
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/tempatGym/${mainTempatGym[indexTempatGym].imageGym}.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SmoothPageIndicator(
                                    onDotClicked: (index) {
                                      setState(() {
                                        indexTempatGym = index-1;
                                        print('ini indexnya : ${indexTempatGym}');
                                      });
                                      
                                    },
                                    controller: pageController,
                                    count: mainTempatGym.length,
                                    
                                    effect: const WormEffect(
                                      offset: 15,
                                      dotHeight: 12,
                                      dotWidth: 12,
                                      type: WormType.thinUnderground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${mainTempatGym[indexTempatGym].namaTempat}',
                                  style: StyleText(color: Colors.black)
                                      .styleH2bWithColor,
                                ),
                                Text(
                                  'Gymnastics center',
                                  style: StyleText(color: Colors.black)
                                      .styleH4lWithColor,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.mapLocationDot,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        mainTempatGym[indexTempatGym].alamat,
                                        style: StyleText(color: Colors.black)
                                            .styleM4bWithColor,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.solidClock,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Open at : ${mainTempatGym[indexTempatGym].jamBuka} AM - ${mainTempatGym[indexTempatGym].jamTutup} PM',
                                        style: StyleText(color: Colors.black)
                                            .styleM4bWithColor,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.phone,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),  
                                    Expanded(
                                      child: Text(
                                        '${mainTempatGym[indexTempatGym].phoneNumber}',
                                        style: StyleText(color: Colors.black)
                                            .styleM4bWithColor,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Review Summary',
                                  style: StyleText(color: Colors.black)
                                      .styleM4bWithColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomRatingWidget(rating: mainTempatGym[indexTempatGym].rating),
                                    Text(
                                      '${mainTempatGym[indexTempatGym].rating}',
                                      style: StyleText(color: Colors.black)
                                          .styleH2bWithColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: List.generate(5, (index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: ColorC().primaryColor1,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person_pin,
                                                  color: ColorC().whiteColor,
                                                  size: 30,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'Tinar',
                                                  style: StyleText(
                                                          color: ColorC()
                                                              .whiteColor)
                                                      .styleM4bWithColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                CustomRatingWidget(
                                                    rating: 4.5),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Expanded(
                                              child: Text(
                                                'Join Now dengan berbagai promo yang menarik.',
                                                style: StyleText(
                                                        color: ColorC()
                                                            .whiteColor)
                                                    .styleM4bWithColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
          
        );
  }

  Widget buildLocationText(String location) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocation = location;
          domisili = location;
          indexTempatGym = 0;
          print('index  gym : ${indexTempatGym}');
          if(location == 'Yogyakarta'){
            mainTempatGym = yogyakarta;
          } else if(location == 'Jakarta'){
            mainTempatGym = jakarta;
          } else if(location == 'Bandung'){
            mainTempatGym = bandung;
          } else {
            mainTempatGym = tempatGymList;
          }
          
          // gymLocations = []; //setState buat list gyms nantinya
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: location == selectedLocation
              ? ColorC().primaryColor1
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          location,
          style: TextStyle(
            color: location == selectedLocation ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildGymContainer(GymLocation gymLocation) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      alignment: Alignment.bottomCenter,
      height: 230,
      width: 164,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(gymLocation.imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: ColorC().primaryColor1,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Color.fromARGB(255, 0, 68, 170),
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                gymLocation.location,
                style: StyleText(color: Colors.white).styleH4bWithColor,
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapPin,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    gymLocation.address,
                    style: StyleText(color: Colors.white).stylePlWithColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
