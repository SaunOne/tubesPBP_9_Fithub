import 'package:flutter/material.dart';
import 'package:ugd6_b_9/database/Client/MengajarClient.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/database/Client/TrainerClient.dart';
import 'package:ugd6_b_9/entity/model/mengajar_trainer.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart';
import 'package:ugd6_b_9/entity/model/trainer.dart';

class TestQuery extends StatelessWidget {
  const TestQuery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              TrainerClient().findTrainerById(2);
            },
            child: Text('Press'),
          ),
          Container(
            height: 400,
            width: 200,
            child: FutureBuilder<Trainer>(
              future: TrainerClient().findTrainerById(2),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
                } else if (snapshot.hasError) {
                  print(snapshot);
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Tidak ada data.');
                } else {
                  Trainer trainer = snapshot.data!;
                  print('isi mengajar : ${trainer.namaTrainer}');
                  return Container(child: Text('${trainer.namaTrainer}'),);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


