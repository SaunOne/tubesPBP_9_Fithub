import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:ugd6_b_9/detailGuide.dart';
import 'package:ugd6_b_9/gridGuide.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ugd6_b_9/routes/routes.dart';
import 'package:ugd6_b_9/test_audio.dart';
import 'package:ugd6_b_9/view/home.dart';
import 'package:ugd6_b_9/view/popUpMenu.dart';

bool isBottom = true;
bool isApp = true;
int noInd = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.isBottomBar = true, this.noIndex = 0});
  final bool isBottomBar;
  final int noIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PersistentTabController(initialIndex: 0);
  int index = HomePage().noIndex;
  bool appBar = isApp, bottomBar = !isBottom;
  bool isPop = false;


  //widget masing masing menu
  List<Widget> onScreen = [
    Home(),
    Text('Chat'),
    Text('Add'),
    Text('Message'),
    GridGuide(), //guide
  ];

  

  List<Widget> _buildScreen() {
    return [
      onScreen[index],
      Text('Chat'),
      Text('Add'),
      Text('Message'),
      GridGuide(), //guide
    ];
  }

  void changeScreen(index, appBar, {hideBottomBar = false}) {
    setState(() {
      this.appBar = appBar;
      this.index = index;
      this.bottomBar = hideBottomBar;
    });
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          FontAwesomeIcons.house,
          size: 20,
        ),
        activeColorPrimary: index == 0 ? ColorC().primaryColor1 : Colors.grey,
        inactiveIcon: Icon(
          Icons.sports_gymnastics,
          color: index == 0 ? ColorC().primaryColor1 : Colors.grey,
        ),
        onPressed: (context) {
          changeScreen(0, true);
        },
        title: 'Home'
      ),
      PersistentBottomNavBarItem(
          
          icon: Icon(FontAwesomeIcons.person),
          inactiveIcon: Icon(
            FontAwesomeIcons.personRunning,
            size: 20,
            color: index == 1 ? ColorC().primaryColor1 : Colors.grey,
          ),
          onPressed: (p1) {
            Navigator.pushNamed(context, Routes.trackPage);
            changeScreen(1, true);
          },
          title: 'Spedometer',
          activeColorPrimary: Color.fromARGB(255, 0, 68, 170)),
          
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: 50,
        ),
        onPressed: (p1){
          Navigator.pushNamed(context, Routes.scanPage);
        },
        activeColorPrimary: Color.fromARGB(255, 0, 68, 170),
        
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.card_membership),
        inactiveIcon: Icon(
          FontAwesomeIcons.clock,
          color: index == 3 ? ColorC().primaryColor1 : Colors.grey,
        ),
        activeColorPrimary: Color.fromARGB(255, 0, 68, 170),
        onPressed: (p1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Guide();
          }));
          changeScreen(3, false);
        },
        title: 'Timer'
      ),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.sports_gymnastics,
          ),
          inactiveIcon: Icon(
            FontAwesomeIcons.dumbbell,
            size: 20,
            color: index == 4 ? ColorC().primaryColor1 : Colors.grey,
          ),
          onPressed: (p1) {
            changeScreen(4, false);
            
          },
          title: 'Guide',
          activeColorPrimary: Color.fromARGB(255, 0, 68, 170)),
          
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: CustomScrollView(
            slivers: [
              if (appBar)
                SliverAppBar(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  title: Text(
                    'HOME',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    Icon(
                      Icons.notification_add,
                      color: Color.fromARGB(255, 0, 68, 170),
                      size: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPop = true;
                        });
                      },
                      color: Color.fromARGB(255, 0, 68, 170),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                  toolbarHeight: 60,
                ),
              if (!appBar)
                SliverAppBar(
                  title: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Colors.black,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Workout Catagories',
                        style: StyleText(color: Colors.black).styleH3bWithColor,
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                ),
              SliverFillRemaining(
                child: PersistentTabView(
                  context,
                  hideNavigationBar: bottomBar,
                  hideNavigationBarWhenKeyboardShows: true,
                  screens: _buildScreen(),
                  items: _navBarItem(),
                  backgroundColor: Colors.white,
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.circular(1),
                    colorBehindNavBar: Color.fromARGB(255, 0, 68, 170),
                  ),
                  navBarStyle: NavBarStyle.style15,
                  navBarHeight: 70,
                ),
              ),
            ],
          ),
        ),
        if (isPop)
          Positioned(
              child: MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                isPop = false;
              });
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color.fromARGB(97, 77, 77, 77),
            ),
          )),
        if (isPop)
          Positioned(
            child: Container(
              height: 420,
              width: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yosa Bagas Brawijaya',
                                style: StyleText(color: Colors.black)
                                    .stylePbWithColor,
                              ),
                              Text('yosabagasya@gmail.com',
                                  style: StyleText(color: Colors.black)
                                      .styleP2lWithColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        Navigator.pushNamed(context, Routes.profilePage);
                        
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Profile', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Schedule', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.sports_gymnastics,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Trainer', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        isPop = false;
                        
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Generate Qr', style: StyleText().styleH4bWithColor),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            isPop = false;
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Logout',
                                  style: StyleText().styleH4bWithColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            right: 40,
            top: 70,
          ),
      ],
    );
  }
  
}
