import 'dart:convert';

class Presensi {
  int id;
  int userId;
  String tanggal;
  String? codePresensi;

  Presensi({
    required this.id,
    required this.userId,
    required this.tanggal,
    this.codePresensi,
  });

  factory Presensi.fromRawJson(String str) => Presensi.fromJson(json.decode(str));

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      tanggal: json['tanggal'] ?? '',
      codePresensi: json['code_presensi'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "tanggal": tanggal,
        "code_presensi": codePresensi,
      };
}
