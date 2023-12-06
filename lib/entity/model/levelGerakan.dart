import 'dart:convert';

class LevelGerakan {
  int id;
  String levelGerakan;

  LevelGerakan({
    required this.id,
    required this.levelGerakan,
  });

  factory LevelGerakan.fromRawJson(String str) => LevelGerakan.fromJson(json.decode(str));

  factory LevelGerakan.fromJson(Map<String, dynamic> json) {
    return LevelGerakan(
      id: json['id'] ?? 0,
      levelGerakan: json['level_gerakan'] ?? '',
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "level_gerakan": levelGerakan,
      };
}
