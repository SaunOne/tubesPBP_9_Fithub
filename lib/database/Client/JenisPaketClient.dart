import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart'; 
import 'package:ugd6_b_9/constant/url.dart';

class JenisPaketClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.jenisPaket;
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

  Future<List<JenisPaket>> getAllJenisPaket() async {
    token = await getToken();
    try {
      print(Uri.parse(url + endpoint));
      var response = await http.get(
        Uri.parse(url + endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list.map((e) => JenisPaket.fromJson(e)).toList()}');
      return list.map((e) => JenisPaket.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<JenisPaket>> showJenisPaketHome() async {
    token = await getToken();
    try {

      var response = await http.get(
        Uri.parse(url + endpoint + '/_home'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list.map((e) => JenisPaket.fromJson(e)).toList()}');
      return list.map((e) => JenisPaket.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<JenisPaket> getJenisPaketById(int id) async {
    token = await getToken();


    try {
      var response = await http.get(Uri.parse(url + endpoint + '/$id'), headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await JenisPaket.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
