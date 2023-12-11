import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/qMaker.dart';
import 'package:ugd6_b_9/constant/url.dart';

class CreateQrClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.qrGenerate;
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

  Future<QRMaker> createQR() async {
    token = await getToken();
    try {
      var response = await http.post(
        Uri.parse(url + endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      return QRMaker.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
