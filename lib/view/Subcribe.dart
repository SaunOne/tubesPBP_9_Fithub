import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SubscribePage extends StatefulWidget {
  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Map<String, dynamic>> subscriptionOptions = [
    {
      'type': 'Basic',
      'price': 'IDR 750.000,00',
      'features': ['+ Gym conventional', '+ Sauna'],
      'images': ['assets/img7.jpg', 'assets/img6.jpg'],
    },
    {
      'type': 'Premium',
      'price': 'IDR 1.150.000,00',
      'features': [
        '+ Gym conventional',
        '+ Sauna',
        '+ Powerlifting room',
        '+ Weightlifting room',
        '+ Free refill water'
      ],
      'images': ['assets/img7.jpg', 'assets/img6.jpg', 'assets/img5.jpg'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscribe'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: subscriptionOptions.map((subscription) {
                return Builder(
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CarouselSlider(
                            items: subscription['images'].map<Widget>((image) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(image, fit: BoxFit.cover),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                            ),
                          ),
                        ),
                        Text(subscription['type'],
                            style: const TextStyle(fontSize: 24)),
                        Text(subscription['price'],
                            style: const TextStyle(fontSize: 20)),
                        Column(
                          children: subscription['features'].map((feature) {
                            return Text(feature);
                          }).toList(),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Logika untuk berlangganan
                          },
                          child: const Text('Subscribe'),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: subscriptionOptions[_current]['images']
                .asMap()
                .entries
                .map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == entry.key
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
