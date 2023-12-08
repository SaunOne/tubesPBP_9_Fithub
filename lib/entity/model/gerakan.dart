import 'dart:convert';

import 'package:ugd6_b_9/entity/model/body_part.dart';
import 'package:ugd6_b_9/entity/model/levelGerakan.dart';

class Gerakan {
  int id;
  int? bodyPartId;
  int? levelGerakanId;
  String namaGerakan;
  String imageGerakan;
  String deskripsi;
  String durasi;
  BodyPart? bodyPart;
  LevelGerakan? levelGerakan;

  Gerakan({
    required this.id,
    this.bodyPartId,
    this.levelGerakanId,
    required this.namaGerakan,
    required this.imageGerakan,
    required this.deskripsi,
    required this.durasi,
    this.bodyPart,
    this.levelGerakan
  });

  factory Gerakan.fromRawJson(String str) => Gerakan.fromJson(json.decode(str));

  factory Gerakan.fromJson(Map<String, dynamic> json) {

    LevelGerakan temp = LevelGerakan(id: 1, levelGerakan: json['level_gerakan']?? 'kosong');

    return Gerakan(
      id: json['id'] ?? 0,
      bodyPartId: json['body_part_id'],
      levelGerakanId: json['level_gerakan_id'],
      namaGerakan: json['nama_gerakan'] ?? '',
      imageGerakan: json['image_gerakan'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      durasi: json['durasi'] ?? '',
      levelGerakan: temp
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "body_part_id": bodyPartId,
        "level_gerakan_id": levelGerakanId,
        "nama_gerakan": namaGerakan,
        "image_gerakan": imageGerakan,
        "deskripsi": deskripsi,
        "durasi": durasi,
      };
}
