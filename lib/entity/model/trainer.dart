import 'dart:convert';

import 'package:ugd6_b_9/entity/model/tempat_gym.dart';

class Trainer {
  int id;
  int tempatGymId;
  String namaTrainer;
  String experience;
  String imageTrainer;
  String jamMulai;
  String jamSelesai;
  String phoneNumber;
  String status;
  double rating;
  TempatGym? tempatGym;

  Trainer(
      {required this.id,
      required this.tempatGymId,
      required this.namaTrainer,
      required this.experience,
      required this.imageTrainer,
      required this.jamMulai,
      required this.jamSelesai,
      required this.phoneNumber,
      required this.status,
      required this.rating,
      this.tempatGym});

  void setTempatGym(TempatGym data){
    print('data : ${data}');
    this.tempatGym = data;
  }

  factory Trainer.fromRawJson(String str) => Trainer.fromJson(json.decode(str));

  factory Trainer.fromJson(Map<String, dynamic> json) {
    var tempatGym = TempatGym(
        id: json['id'] ?? 0,
        namaTempat: json['nama_tempat'] ?? '',
        codeZip: json['code_zip'] ?? '',
        imageGym: json['image_gym'] ?? '',
        jamBuka: json['jam_buka'] ?? '',
        jamTutup: json['jam_tutup'] ?? '',
        rating: json['rating'] ?? 2.2,
        alamat: json['alamat'] ?? '',
        domisili: json['domisili'] ?? '',
        phoneNumber: json['phone_number'] ?? '' );

    return Trainer(
      id: json['id'] ?? 0,
      tempatGymId: json['tempat_gym_id'] ?? 0,
      namaTrainer: json['nama_trainer'] ?? '',
      experience: json['experience'] ?? '',
      imageTrainer: json['image_trainer'] ?? '',
      jamMulai: json['jam_mulai'] ?? '',
      jamSelesai: json['jam_selesai'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      status: json['status'] ?? '',
      rating: json['rating'] ?? 0.0,
      tempatGym: tempatGym.id == 0? null : tempatGym
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "tempat_gym_id": tempatGymId,
        "nama_trainer": namaTrainer,
        "experience": experience,
        "image_trainer": imageTrainer,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "phone_number": phoneNumber,
        "status": status,
        "rating": rating,
      };
}
