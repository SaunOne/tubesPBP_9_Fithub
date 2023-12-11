import 'dart:convert';

class BodyPart {
  int id;
  String nameBodyPart;

  BodyPart({
    required this.id,
    required this.nameBodyPart,
  });

  factory BodyPart.fromRawJson(String str) => BodyPart.fromJson(json.decode(str));

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(
      id: json['id'] ?? 0,
      nameBodyPart: json['name_body_part'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_body_part": nameBodyPart,
      };
}
