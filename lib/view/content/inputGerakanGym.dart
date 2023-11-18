
import 'package:flutter/material.dart';
import 'package:ugd6_b_9/database/datadummyimg.dart';
import 'package:ugd6_b_9/database/sql_helperGym.dart';
import 'package:ugd6_b_9/view/ShowSchedule.dart';
import 'package:ugd6_b_9/view/homePage.dart';

// ignore: must_be_immutable
class InputGerakanGym extends StatefulWidget {
  InputGerakanGym(
      {super.key,
      required this.name,
      required this.id,
      required this.tingkatKesulitan,
      required this.deskripsi,
      required this.gambar});

  int? id;
  String? name, tingkatKesulitan, gambar, deskripsi;
  @override
  State<InputGerakanGym> createState() => _InputGerakanGymState();
}

class _InputGerakanGymState extends State<InputGerakanGym> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerTingkatKesulitan = TextEditingController();
  TextEditingController controllerGambar = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: <Widget>[
      const SizedBox(
        height: 20,
      ),
      TextField(
        controller: controllerName,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Nama Gerakan'),
      ),
      const SizedBox(
        height: 15,
      ),
      TextField(
        controller: controllerTingkatKesulitan,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.bar_chart),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Tingkat Kesulitan'),
      ),
      const SizedBox(
        height: 15,
      ),
      TextField(
        controller: controllerDeskripsi,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.description_sharp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Deskirpsi'),
      ),
      const SizedBox(
        height: 35,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 115, 0, 54),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          elevation: 5,
          padding: const EdgeInsets.all(15),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          print('Masuk pertama');
          if (widget.id == null) {
            print('Masuk');
            await addGerakanGym();
          } else {
            print('edit id : ${widget.id}');
            editGerakanGym(
                widget.id!,
                controllerName.text,
                controllerDeskripsi.text,
                controllerTingkatKesulitan.text,
                '');
            widget.id = null;
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text('Save'),
      ),
    ]);
  }

  int searchIndexImg(int index){
    if(index >= 10){
      return 0;
    } else {
      return ++index;
    }
  }

  Future<void> addGerakanGym() async {
    if(listImg[0]['index'] >= 10){
      listImg[0]['index'] = 0;
    } else {
      listImg[0]['index'] = listImg[0]['index']+1;
    }
    String gambar = listImg[listImg[0]['index']]['img'];
    
    print('alamat gambarnya : $gambar');
    await SQLHelperGym.addGerakanGym(
        controllerName.text,
        controllerDeskripsi.text,
        controllerTingkatKesulitan.text,
        gambar
        );
  }

  Future<void> editGerakanGym(
    int id, name, deskripsi, tingkatKesulitan, gambar) async {
    print('eroro di prosedur id : $id');
    await SQLHelperGym.editGerakanGym(
        id, name, deskripsi, tingkatKesulitan, gambar
      );
  }
}
