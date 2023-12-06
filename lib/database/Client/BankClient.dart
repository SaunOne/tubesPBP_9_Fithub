import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/bank.dart';
import 'package:ugd6_b_9/constant/url.dart';
import 'package:ugd6_b_9/entity/model/bank.dart';

class BankClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.bank;
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

  Future<List<Bank>> showAllBanks() async {
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
      print('list : ${list.map((e) => Bank.fromJson(e)).toList()}');
      return list.map((e) => Bank.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Bank> findBankById(int id) async {
    token = await getToken();

    print('url : ${Uri.http(url, "$endpoint/$id")}');
    try {
      var response = await http.get(Uri.http(url, "$endpoint/$id"), headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      print('response : ${response.body}');
      return await Bank.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
