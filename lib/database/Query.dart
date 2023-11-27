import 'dart:convert';

import 'package:ugd6_b_9/Entity/User.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/url.dart';

class Query {
  String token = '';

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
    return token;
  }

  Future<User> getByUserId(int id) async {
    String token = await getToken();
    String URL = networkUrl.prefix;
    String Endpoint = networkUrl.getUser;

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

  Future<User> resetPassword(String Email, String Password) async {
    String URL = networkUrl.prefix;
    String Endpoint = networkUrl.reset;

    var url = Uri.parse('http://$URL/$Endpoint/$Email');

    var data = {
      'password': Password,
    };

    try {
      var response = await put(url, body: jsonEncode(data), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        print(response.body);
        throw Exception('Failde to reset password');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to authenticate');
    }
  }

  Future<User> updateProfile(int id, String fullname, String username, String email, String birthdate, String gender, String phone, double weight, double height) async {
    String URL = networkUrl.prefix;
    String EndpointUpdate = networkUrl.updateProfile;
    String token = await getToken();
    

    var url = Uri.parse('http://$URL/$EndpointUpdate/$id');

    try {
      var data = {
        'fullname': fullname,
        'username': username,
        'email': email,
        'birthdate': birthdate,
        'gender': gender,
        'phone' : phone,
        'weight': weight,  
        'height': height,
      };
      var response = await put(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
      );
      

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        print(response.body);
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to authenticate');
    }
  }
}
