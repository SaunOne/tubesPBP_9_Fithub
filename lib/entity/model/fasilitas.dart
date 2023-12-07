import 'dart:convert';

class Fasilitas {
  int id;
  String namaFasilitas;
  int idJenisPaket;

  Fasilitas({
    required this.id,
    required this.namaFasilitas,
    required this.idJenisPaket,
  });

  factory Fasilitas.fromRawJson(String str) => Fasilitas.fromJson(json.decode(str));

  factory Fasilitas.fromJson(Map<String, dynamic> json) {
    return Fasilitas(
      id: json['id'] ?? 0,
      namaFasilitas: json['nama_fasilitas'] ?? '',
      idJenisPaket: json['id_jenis_paket'] ?? 0,
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_fasilitas": namaFasilitas,
        "id_jenis_paket": idJenisPaket,
      };
}
