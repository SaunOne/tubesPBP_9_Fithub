import 'package:flutter/material.dart';
import 'package:ugd6_b_9/database/Client/FasilitasClient.dart';
import 'package:ugd6_b_9/database/Client/JenisPaketClient.dart';
import 'package:ugd6_b_9/database/Client/MengajarClient.dart';
import 'package:ugd6_b_9/database/Client/SubscriptionClient.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/database/Client/TrainerClient.dart';
import 'package:ugd6_b_9/entity/model/fasilitas.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
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
              var data = {
                "bank_id" : 1,
                "jenis_paket_id" : 2,
                "user_id" : 1,
                "membership_id" : 1,
                "tanggal_pembayaran" : '12-12-12' 
              };
              SubscriptionClient().createSubscription(data);
            },
            child: Text('Press'),
          ),
          Container(
            height: 400,
            width: 200,
            child: FutureBuilder<List<JenisPaket>>(
              future: JenisPaketClient().getAllJenisPaket(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
                } else if (snapshot.hasError) {
                  print(snapshot);
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Tidak ada data.');
                } else {
                  List<JenisPaket> jenisPaket = snapshot.data!;
                  // print('isi mengajar : ${trainer[1].namaTrainer}');
                  return Container(child: Text('${jenisPaket[0].namaMembership}'),);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


