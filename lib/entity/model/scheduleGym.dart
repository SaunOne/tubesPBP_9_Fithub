import 'dart:convert';

import 'package:flutter/material.dart';

class ScheduleGym {
  int id;
  int idUser;
  String scheduleName;
  String tanggal;
  String durasi;
  String note;

  ScheduleGym(
      {required this.id,
      required this.idUser,
      required this.tanggal,
      required this.scheduleName,
      required this.durasi,
      required this.note});

  ScheduleGym.empty()
      : id = 0,
        idUser = 0,
        scheduleName = '',
        tanggal = '',
        durasi = '',
        note = '';

factory ScheduleGym.fromRawJson(String str) => ScheduleGym.fromJson(json.decode(str));

  factory ScheduleGym.fromJson(Map<String, dynamic> json) {
    json = json['Schedules'] ?? json;

    print('json : ${json}');

    return ScheduleGym(
      id: json['id'] ?? 0,
      scheduleName: json['schedule_name'] ?? 0,
      idUser: json['user_id'] ?? '',
      tanggal: json['tanggal'] ?? '',
      durasi: json['time'] ?? '',
      note: json['note'] ?? '', 
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String,dynamic> toJson() => {
    "id": id,
    "user_id" : idUser,
    "schedule_name": scheduleName,
    "tanggal": tanggal,
    "durasi": durasi,
    "note": note
  };
}
