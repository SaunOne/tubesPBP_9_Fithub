import 'dart:convert';

class QRMaker {
  int id;
  String qrCode;
  String start;
  String expired;

  QRMaker({
    required this.id,
    required this.qrCode,
    required this.start,
    required this.expired,
  });

  factory QRMaker.fromRawJson(String str) => QRMaker.fromJson(json.decode(str));

  factory QRMaker.fromJson(Map<String, dynamic> json) {
    return QRMaker(
      id: json['id'] ?? 0,
      qrCode: json['qr_code'] ?? '',
      start: json['start'] ?? '',
      expired: json['expired'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "qr_code": qrCode,
        "start": start,
        "expired": expired,
      };
}
