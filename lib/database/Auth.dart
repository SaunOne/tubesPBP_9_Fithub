import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart';
import 'package:ugd6_b_9/Entity/User.dart';
import 'package:ugd6_b_9/Entity/ResponseDataUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/url.dart';

class Authentication {

  var token;

  getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!);
  }


  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<ResponseDataUser> authenticate(String username, String password) async {
    var data = {
      'email': username,
      'password': password,
    };

    var url = Uri.http(networkUrl.prefix, networkUrl.login);
    var response = await post(url, body: jsonEncode(data), headers: _setHeaders());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      ResponseDataUser responseDataUser = ResponseDataUser.fromJson(jsonDecode(response.body));
      return responseDataUser;
    } else {
      print(response.body);
      return ResponseDataUser.fromJson(jsonDecode(response.body));
    }
  }

  Future<ResponseDataUser> Register(
      String fullname, String username, String email,
      String password, String birthdate, String gender
      ) async {
    try {
      var data = {
        'fullname': fullname,
        'username': username,
        'email': email,
        'password': password,
        'birthdate': birthdate, 
        'gender': gender,
      };

      var url = Uri.http(networkUrl.prefix, networkUrl.register);
      var response = await post(url, body: jsonEncode(data), headers: _setHeaders());

      print(response.statusCode);

      if (response.statusCode == 201) {
        // Registration successful
        print(response.body);
        return ResponseDataUser.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 409) {
        // Bad Request. The server rejected the registration data.
        print('Bad Request: ${response.body}');

       return ResponseDataUser.fromJson(jsonDecode(response.body));
      } else {
        // Registration failed
        print('Error during registration: ${response.body}');
        return ResponseDataUser.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      // Handle exceptions not related to HTTP requests
      print('Error during registration: $e');
      throw Exception('Failed to register. Check your internet connection.');
    }
  }




  //check connection to the server
  static Future<bool> checkConnection() async {
    try {
      var url = Uri.http(networkUrl.prefix);
      var response = await get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}


