import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ugd6_b_9/constant/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/mengajar_trainer.dart';

class MengajarTrainerClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.mengajarTrainer;
  String token = '';

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    return token;
  }

  Future<List<MengajarTrainer>> showAllMengajarTrainer() async {
    token = await getToken();
    print('token : ${token}');
    try {
      var response = await http.get(
        Uri.parse(url + endpoint),
        headers: _setHeaders(),
      );
      print('ini body : ${response.body}');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      var list = json.decode(response.body)['data'];

      print('list : ${list.map((e) => MengajarTrainer.fromJson(e)).toList()}');
      return list.map((e) => MengajarTrainer.fromJson(e)).toList();
      // return json.decode(response.body)['data'];
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<MengajarTrainer>> showMengajarByTrainerID(int trainerId) async {
    token = await getToken();
    try {

      var response = await http.get(
        Uri.parse(url + endpoint + '/$trainerId'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      var a = list.map((e) => MengajarTrainer.fromJson(e)).toList();

      return list.map((e) => MengajarTrainer.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<MengajarTrainer>> showMengajarByJadwalMengajarID(
      int jadwalMengajarId) async {
    token = await getToken();
    try {
      var response = await http.get(
        Uri.parse(url + endpoint + '/$jadwalMengajarId'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return json.decode(response.body)['data'];
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
