import 'dart:convert';
import 'package:http/http.dart';
import 'package:ugd6_b_9/constant/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/scheduleGym.dart';

class ScheduleClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.schedule;
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

  Future<List<ScheduleGym>> showAll() async {
    token = await getToken();
    print('token : ${token}');
    try {
      var response = await get(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print('ini body : ${response.body}');
      Iterable list = json.decode(response.body)['data'];
      print('ini hasilnya');
      print(list);
      return list.map((e) => ScheduleGym.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<ScheduleGym> find(id) async {
    token = await getToken();
    try {
      var response = await get(Uri.http(url, "$endpoint/$id"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return ScheduleGym.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> create(
      {required tanggal,
      required durasi,
      required note,
      required scheduleName}) async {
    token = await getToken();
    try {
      print('masuk kesini');
      var data = {
        'tanggal': tanggal,
        'time': durasi,
        'note': note,
        'schedule_name': scheduleName
      };

      var response = await post(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      print('masuk kesini 2');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('masuk kesini 3');
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> update(
      {required id,
      required tanggal,
      required durasi,
      required note,
      required scheduleName}) async {
    token = await getToken();
    try {
      var data = {
        'id': id,
        'tanggal': tanggal,
        'time': durasi,
        'note': note,
        'schedule_name': scheduleName
      };
      print('ini hasilnya');
      print(data);
      var response = await put(Uri.http(url, '$endpoint/$id'),
          headers: _setHeaders(), body: jsonEncode(data));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> destroy(id) async {
    token = await getToken();
    try {
      token = await getToken();
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
