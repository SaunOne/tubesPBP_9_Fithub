import 'dart:convert';

class Subscription {
  int id;
  int bankId;
  int jenisPaketId;
  int userId;
  int membershipId;
  DateTime tanggalPembayaran;

  Subscription({
    required this.id,
    required this.bankId,
    required this.jenisPaketId,
    required this.userId,
    required this.membershipId,
    required this.tanggalPembayaran,
  });

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] ?? 0,
      bankId: json['bank_id'] ?? 0,
      jenisPaketId: json['jenis_paket_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      membershipId: json['membership_id'] ?? 0,
      tanggalPembayaran: DateTime.parse(json['tanggal_pembayaran'] ?? ''),
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_id": bankId,
        "jenis_paket_id": jenisPaketId,
        "user_id": userId,
        "membership_id": membershipId,
        "tanggal_pembayaran":
            tanggalPembayaran.toIso8601String().split('T')[0],
      };
}
