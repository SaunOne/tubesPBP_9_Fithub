// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ugd6_b_9/view/inputGerakanGym.dart';
import 'package:ugd6_b_9/view/profileView.dart';
import 'package:ugd6_b_9/view/showGym.dart';

//tinar
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key,this.indexD,this.id});
  int? indexD = 0,id;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget content = const showGerakanGym();
  int navindex = 0;
  Widget title = Text('Gerakan Gym');

  void changeContent(int index){
    setState(() {
      if(index == 0){
        content = const showGerakanGym();
        navindex = 0;
      } else if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
        navindex = 0;
      } else if(index == 2){
        content = InputGerakanGym(name: null,id: widget.id,deskripsi: null,gambar: null,tingkatKesulitan: null,);
        title = Text('Add Gerkaan Gym');
        navindex = 2;
      }
    });
  }

  bool trueOrFalse(int a,int b){
    navindex = 0;
    return a == b;
  }
  
  @override
  Widget build(BuildContext context) {
    print("indexnya : ${widget.indexD}");
    if(widget.indexD != null){
      changeContent(widget.indexD!);
      widget.indexD = null;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        automaticallyImplyLeading: trueOrFalse(navindex, 2),
        backgroundColor: const Color.fromARGB(255, 115, 0, 54),
        title: title,
        shadowColor: const Color.fromARGB(226, 85, 2, 2),
        
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(5.0),
        child: content,
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_outlined),label: 'Show'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
      ],
        currentIndex: navindex,
        fixedColor: Color.fromARGB(255, 159, 0, 74),
      onTap: (index){ 
        changeContent(index);

      },
      ),
    );
  }
}