import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd6_b_9/constant/styleText.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: StyleText(color: Colors.black).styleH2bWithColor,
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                for(int i = 0;i<4;i++)
                Container(
                 
                  child: Column(
                    children: [
                      Container(
                        
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey),top: BorderSide(color: Colors.grey))
                        ),
                        child: Text('Today'),
                      ),
                      for(int i = 0; i < 3 ; i++) //perulangan untuk notif di per wkatu 
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              margin: EdgeInsets.only(bottom: 20),
                              child: Icon(FontAwesomeIcons.bell,size: 26,)
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Today You Have a Gym Schedule',style: StyleText().styleH4bWithColor,),
                                    SizedBox(height: 4,),
                                    Text("don't Forget Your Schedule, Today you have to many work, just do it, go straight for your dream and dont never give up",style: StyleText().stylePlWithColor,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
