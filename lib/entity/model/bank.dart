import 'dart:convert';

class Bank {
  int id;
  String namaBank;

  Bank({
    required this.id,
    required this.namaBank,
  });

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'] ?? 0,
      namaBank: json['nama_bank'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_bank": namaBank,
      };
}
