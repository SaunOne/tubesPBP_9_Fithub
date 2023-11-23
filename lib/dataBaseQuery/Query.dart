import 'dart:convert';

import 'package:griding/Entity/User.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Query {
  static const String URL = "192.168.18.238:8000";
  static const String Endpoint = "api/user";
  String token = '';

  Future<String> getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    return token;
  }


  Future<User> getByUser(int id) async {
    String token = await getToken();

    // Use Uri.parse for a complete URL with the query parameters
    var url = Uri.parse('http://$URL/$Endpoint/$id');

    try {
      var response = await get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        print(response.body);
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to authenticate');
    }
  }

}