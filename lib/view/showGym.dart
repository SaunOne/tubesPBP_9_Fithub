import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd6_b_9/database/sql_helperGym.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:ugd6_b_9/view/ShowSchedule.dart';
import 'package:ugd6_b_9/view/pdf_view.dart';
import 'package:ugd6_b_9/view/preview_screenforPDF.dart';

import 'package:ugd6_b_9/view/home.dart';

class showGerakanGym extends StatefulWidget {
  const showGerakanGym({super.key});

  @override
  State<showGerakanGym> createState() => _showGerakanGymState();
}

class _showGerakanGymState extends State<showGerakanGym> {
  List<Map<String, dynamic>> gerakanGym = [];

  void refresh() async {
    final data = await SQLHelperGym.getGerakanGym();
    setState(() {
      gerakanGym = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 227, 227, 227),
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final doc = await generateDocument(gerakanGym);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc,)));
            },
            backgroundColor: const Color.fromARGB(255, 115, 0, 54),
            child: const Icon(Icons.print),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(indexD: 2,)));
            },
            backgroundColor: const Color.fromARGB(255, 115, 0, 54),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: gerakanGym.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: const SlidableDrawerActionPane(),
            // ignore: sort_child_properties_last
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        gerakanGym[index]['gambar'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 20,),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text('Gerakan : ' + gerakanGym[index]['namaGerakan'],
                        style: const TextStyle(
                            fontFamily: 'Poppins', // Mengatur jenis font ke Poppins
                            fontSize: 16, // Ukuran font
                            fontWeight: FontWeight.bold, // Ketebalan font (opsional)
                            color: Color.fromARGB(255, 141, 0, 59), // Warna font
                        ),
                      ),
                      const SizedBox(height: 5,),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text('Tingkat Kesulitan : ' + gerakanGym[index]['tingkatKesulitan']),
                      const SizedBox(height: 5,),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text('Deskripsi : ' + gerakanGym[index]['deskripsi'],
                        style: const TextStyle(
                            fontFamily: 'Poppins', // Mengatur jenis font ke Poppins
                            fontSize: 14, // Ukuran font
                            fontWeight: FontWeight.normal, // Ketebalan font (opsional)
                            color: Colors.black, // Warna font
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            secondaryActions: [
              IconSlideAction(
              caption: 'Update',
              color: const Color.fromARGB(255, 255, 213, 2),
              icon: Icons.update,
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(indexD: 2,id: gerakanGym[index]['id'],)));
              },
            ),
              IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                await deleteGerakanGym(gerakanGym[index]['id']);
              },
            ),
            ],
          );
        },
      ),
    );
  }

  Future<void> deleteGerakanGym(int id) async{
    await SQLHelperGym.deleteGerakanGym(id);
    refresh();
  }




}
