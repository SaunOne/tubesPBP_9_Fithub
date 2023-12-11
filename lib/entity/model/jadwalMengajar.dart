import 'dart:convert';

class JadwalMengajar {
  int id;
  String hari;
  String jamMulai;
  String jamSelesai;

  JadwalMengajar({
    required this.id,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
  });

  factory JadwalMengajar.fromRawJson(String str) =>
      JadwalMengajar.fromJson(json.decode(str));

  factory JadwalMengajar.fromJson(Map<String, dynamic> json) {
    return JadwalMengajar(
      id: json['id'] ?? 0,
      hari: json['hari'] ?? '',
      jamMulai: json['jam_mulai'] ?? '',
      jamSelesai: json['jam_selesai'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "hari": hari,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
      };
}
