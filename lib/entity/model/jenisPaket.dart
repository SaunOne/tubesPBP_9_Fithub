import 'dart:convert';

class JenisPaket {
  int id;
  String namaMembership;
  double harga;
  String image;
  double promo;

  JenisPaket({
    required this.id,
    required this.namaMembership,
    required this.harga,
    required this.image,
    required this.promo
  });

  factory JenisPaket.fromRawJson(String str) => JenisPaket.fromJson(json.decode(str));

  factory JenisPaket.fromJson(Map<String, dynamic> json) {
    return JenisPaket(
      id: json['id'] ?? 0,
      namaMembership: json['nama_membership'] ?? '',
      harga: (json['harga'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      promo:(json['promo'] ?? 0.0).toDouble(),
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_membership": namaMembership,
        "harga": harga,
        "image" : image,
        "promo" : promo
      };
}
