import 'dart:convert';

import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
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
  double age;
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
      required this.age,
      this.tempatGym});

  void setTempatGym(TempatGym data) {
    print('data : ');
    this.tempatGym = data;
    print('isi : ${tempatGym!.alamat}');
  }

  factory Trainer.fromRawJson(String str) => Trainer.fromJson(json.decode(str));

  factory Trainer.fromJson(Map<String, dynamic> json) {

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
      rating: (json['rating'] ?? 0.0).toDouble(),
      age: (json['age'] ?? 0.0).toDouble(),
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
        "age" : age,
      };
}
