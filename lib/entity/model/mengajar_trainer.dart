import 'dart:convert';

import 'package:ugd6_b_9/entity/model/jadwalMengajar.dart';

class MengajarTrainer {
  int jadwalMengajarId;
  int trainerId;
  JadwalMengajar? jadwalMengajar;

  MengajarTrainer(
      {required this.jadwalMengajarId,
      required this.trainerId,
      this.jadwalMengajar});

  factory MengajarTrainer.fromRawJson(String str) =>
      MengajarTrainer.fromJson(json.decode(str));

  factory MengajarTrainer.fromJson(Map<String, dynamic> json) {
    
    var jMengajar = JadwalMengajar(
        id: json['id'],
        hari: json['hari'],
        jamMulai: json['jam_mulai'],
        jamSelesai: json['jam_selesai']);
        print('json : ${jMengajar.hari}');

    return MengajarTrainer(
        jadwalMengajarId: json['jadwal_mengajar_id'] ?? 0,
        trainerId: json['trainer_id'] ?? 0,
        jadwalMengajar: jMengajar);
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "jadwal_mengajar_id": jadwalMengajarId,
        "trainer_id": trainerId,
      };
}
