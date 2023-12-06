import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/subscription.dart';
import 'package:ugd6_b_9/constant/url.dart';

class SubscriptionClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.subscription;
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

  Future<List<Subscription>> showSubscriptions() async {
    token = await getToken();
    try {
      var response = await http.get(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Subscription.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Subscription> showSubscriptionById(int id) async {
    token = await getToken();
    try {
      var response = await http.get(
        Uri.http(url, "$endpoint/$id"),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Subscription.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> createSubscription(Map<String, dynamic> data) async {
    token = await getToken();
    try {
      var response = await http.post(
        Uri.http(url, endpoint),
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
