import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/presensi.dart';
import 'package:ugd6_b_9/constant/url.dart';

class PresensiClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.presensi;
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

  Future<Presensi> presensi(String qrCode) async {
    token = await getToken();
    try {
      var response = await http.post(
        Uri.parse(url + endpoint + '/$qrCode'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      return Presensi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Presensi>> getPresensiByUserId(int userId) async {
    token = await getToken();

    try {
      var response = await http.get(
        Uri.parse(url + endpoint + '/user/$userId'),
        headers: _setHeaders(),
      );

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Presensi>> getPresensiByDate(String date) async {
    token = await getToken();

    try {
      var response = await http.get(
        Uri.parse(url + endpoint + '/date/$date'),
        headers: _setHeaders(),
      );

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Presensi> updatePresensi(int id, String tanggal) async {
    token = await getToken();
    var data = {
      "tanggal": tanggal,
    };
    print('tanggal: ${tanggal}');
    try {
      var response = await http.put(
        Uri.parse(url + endpoint + '/update/$id'),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      return Presensi.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> deletePresensi(int presensiId) async {
    token = await getToken();
    try {
      var response = await http.delete(
        Uri.parse(url + endpoint + '/$presensiId'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
