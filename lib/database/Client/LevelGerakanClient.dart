import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/levelGerakan.dart'; 
import 'package:ugd6_b_9/constant/url.dart';

class LevelGerakanClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.levelGerakan;
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

  Future<List<LevelGerakan>> showAllLevelGerakan() async {
    token = await getToken();
    try {

      var response = await http.get(
        Uri.parse(url + endpoint ),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list.map((e) => LevelGerakan.fromJson(e)).toList()}');
      return list.map((e) => LevelGerakan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<LevelGerakan> showLevelGerakanById(int id) async {
    token = await getToken();

    try {
      var response = await http.get(Uri.parse(url + endpoint + '/$id'), headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await LevelGerakan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> createLevelGerakan(LevelGerakan levelGerakan) async {
    token = await getToken();
    try {
      var data = levelGerakan.toJson();

      var response = await http.post(
        Uri.parse(url + endpoint),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
