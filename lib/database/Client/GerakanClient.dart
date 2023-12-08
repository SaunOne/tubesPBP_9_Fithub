import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/url.dart';
import 'package:ugd6_b_9/entity/model/gerakan.dart';

class GerakanClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.gerakan;
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

  Future<List<Gerakan>> getAllGerakan() async {
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
      print('list : ${list.map((e) => Gerakan.fromJson(e)).toList()}');
      return list.map((e) => Gerakan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Gerakan>> showGerkaanHome() async {
    token = await getToken();
    try {
      print('url : ${Uri.http(url, endpoint+'_home')}');
      var response = await http.get(
        Uri.http(url, endpoint+'_home'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list.map((e) => Gerakan.fromJson(e)).toList()}');
      return list.map((e) => Gerakan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Gerakan> getGerakanById(int id) async {
    token = await getToken();

    print('url : ${Uri.http(url, "$endpoint/$id")}');
    try {
      var response = await http.get(Uri.http(url, "$endpoint/$id"), headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await Gerakan.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Gerakan>> getGerakanByLevel(int id) async {
    token = await getToken();
    try {
      var response = await http.get(Uri.http(url, "$endpoint/level/$id"), headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      

      Iterable list = json.decode(response.body)['data'];
      print('success');
      return list.map((e) => Gerakan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Gerakan>> getGerakanByBodyPart(int id) async {
    token = await getToken();
    try {
      var response = await http.get(Uri.http(url, "$endpoint/level/$id"), headers: _setHeaders());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Gerakan.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
