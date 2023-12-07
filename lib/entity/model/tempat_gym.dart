import 'dart:convert';

class TempatGym {
  int id;
  String namaTempat;
  int codeZip;
  String imageGym;
  String jamBuka;
  String jamTutup;
  double rating;
  String alamat;
  String phoneNumber;
  String domisili;

  TempatGym({
    required this.id,
    required this.namaTempat,
    required this.codeZip,
    required this.imageGym,
    required this.jamBuka,
    required this.jamTutup,
    required this.rating,
    required this.alamat,
    required this.phoneNumber,
    required this.domisili
  });

  factory TempatGym.fromRawJson(String str) => TempatGym.fromJson(json.decode(str));

  factory TempatGym.fromJson(Map<String, dynamic> json) {
    return TempatGym(
      id: json['id'] ?? 0,
      namaTempat: json['nama_tempat'] ?? '',
      codeZip: json['code_zip'] ?? 0,
      imageGym: json['image_gym'] ?? '',
      jamBuka: json['jam_buka'] ?? '',
      jamTutup: json['jam_tutup'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      alamat: json['alamat'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      domisili: json['domisili'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_tempat": namaTempat,
        "code_zip": codeZip,
        "image_gym": imageGym,
        "jam_buka": jamBuka,
        "jam_tutup": jamTutup,
        "rating": rating,
        "alamat": alamat,
        "phone_number": phoneNumber,
      };
}
