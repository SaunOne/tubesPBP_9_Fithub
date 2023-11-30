import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';

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
  const SearchGym({Key? key}) : super(key: key);

  @override
  State<SearchGym> createState() => _SearchGymState();
}

class _SearchGymState extends State<SearchGym> {
  String selectedLocation = 'Semua Gym'; 

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
  ];// Default location

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorC().whiteColor,
          title: Text(
            'Search Gym',
            style: StyleText(color: Colors.black).styleH2bWithColor,
          ),
        ),
        backgroundColor: ColorC().whiteColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selamat datang, Yosa',
                        style: StyleText(color: Colors.black).styleH2bWithColor,
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
                Container(
                  width: double.infinity,
                  height: 220,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < gymLocations.length; i++)
                          buildGymContainer(gymLocations[i]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 350,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Celebrity Fitness',
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
                                  'Jl. Laksda Adisucipto No.32-34, Demangan, Kec. Gondokusuman, Kota Yogyakarta,Daerah Istimewa Yogyakarta 55221',
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
                                  'Open at : 6 AM–8 PM',
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
                                  '02742922842',
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
                              buildStarIcon(4.3),
                              Text(
                                '4.0',
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Column(
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
                                                    color: ColorC().whiteColor)
                                                .styleM4bWithColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      buildStarIcon(4.3),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: Text(
                                          'Join Now dengan berbagai promo yang menarik.',
                                          style: StyleText(
                                                  color: ColorC().whiteColor)
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
      ),
    );
  }

  Widget buildLocationText(String location) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocation = location;
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

Widget buildStarIcon(double rating) {
  List<Widget> starIcons = [];

  int fullStars = rating.floor();
  for (int i = 0; i < fullStars; i++) {
    starIcons.add(
      const Row(
        children: [
          Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  if (rating - fullStars >= 0.5) {
    starIcons.add(
      const Row(
        children: [
          Icon(FontAwesomeIcons.starHalf, color: Colors.amber),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  int emptyStars = 5 - starIcons.length;
  for (int i = 0; i < emptyStars; i++) {
    starIcons.add(
      const Row(
        children: [
          Icon(FontAwesomeIcons.star, color: Colors.grey),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
  return Row(children: starIcons);
}
