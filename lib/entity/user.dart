import 'package:ugd6_b_9/entity/photo.dart';

class User {
  final int? id;
  final String PathPhoto;


  String? name, email, gender,password, tanggalLahir;

  User(this.id, this.PathPhoto, this.name, this.email, this.gender,
      this.password, this.tanggalLahir);
}