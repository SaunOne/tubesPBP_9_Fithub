import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/membership.dart';
import 'package:ugd6_b_9/constant/url.dart';

class MembershipClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.getMember;
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

  Future<Memberships> createMember(int idUser) async {
    token = await getToken();
    try {
      var data = {'id_user': idUser};

      var response = await http.post(
        Uri.parse(url + endpoint),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');

      return Memberships.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<String> checkMember(int idUser) async {
    token = await getToken();

    try {
      var response = await http.get(
        Uri.parse(url + endpoint + '/check/$idUser'),
        headers: _setHeaders(),
      );

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return json.decode(response.body)['data'];
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
