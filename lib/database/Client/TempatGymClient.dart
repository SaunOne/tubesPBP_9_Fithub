import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart'; // Pastikan mengganti dengan path yang sesuai
import 'package:ugd6_b_9/constant/url.dart';

class TempatGymClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.tempatGym;
  String token = '';

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    return token;
  }

  Future<List<TempatGym>> showAllTempatGym() async {
    token = await getToken();
    try {
      print('url : ${Uri.http(url, endpoint)}');
      var response = await http.get(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list.map((e) => TempatGym.fromJson(e)).toList()}');
      return list.map((e) => TempatGym.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<TempatGym> findTempatGymById(int id) async {
    token = await getToken();

    print('url : ${Uri.http(url, "$endpoint/$id")}');
    try {
      var response = await http.get(Uri.http(url, "$endpoint/$id"), headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await TempatGym.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
