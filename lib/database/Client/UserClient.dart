// ignore: file_names
import 'dart:convert';


import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/url.dart';
import 'package:ugd6_b_9/entity/image.dart';
import 'package:ugd6_b_9/entity/model/Membership.dart';
import 'package:ugd6_b_9/entity/model/User.dart';

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
    var url = Uri.parse(URL + Endpoint + '/$id');

    try {
      var response = await get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);

      if (response.statusCode == 200) {   
 
        User user = await User.fromJson(jsonDecode(response.body));
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

    var url = Uri.parse(URL + Endpoint + '/$Email');

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

  Future<User> updateProfile(int id, String fullname, String username, String email, String birthdate, String gender, String phone, double weight, double height, String photo) async {
    String URL = networkUrl.prefix;
    String EndpointUpdate = networkUrl.updateProfile;
    String token = await getToken();
    

    var url = Uri.parse(URL + EndpointUpdate + '/$id');
 
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
        'photo': photo ?? '',

      };

      var response = await put(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
      );
      
      print("response body : ${response.body}");
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

  Future<User> updateUserMemberships(int id, int idMember) async{
    String URL = networkUrl.prefix;
    String EndpointUpdate = networkUrl.updateProfile;
    String token = getToken() as String;

    var url = Uri.parse(URL + EndpointUpdate + '/$id');

    try{
      var data = {
        'member_id': idMember,
      };

      var response = await put(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: jsonEncode(data));


      print(response.statusCode);

      if(response.statusCode == 200){
        print(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        print(response.body);
        throw Exception('Failed to update user data');
      }
    }catch(e){
      print(e);
      throw Exception('Failed to authenticate');
    }
  }


  Future<User> Logout(int id) async {
    String URL = networkUrl.prefix;
    String EndpointLogout = networkUrl.logout;
    String token = await getToken();

    var url = Uri.parse(URL + EndpointLogout + '/$id');

    try{
      var data = {
        'id' : id,
      };

      var response = await post(url,headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      }, body: jsonEncode(data));

      if(response.statusCode == 200){
        print(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        print(response.body);
        throw Exception('Failed to logout');
      }
    }catch(e){
      print(e);
      throw Exception('Failed to authenticate');
    }


  }

  Future<ImageUser> getPhoto(int id) async {
    String URL = networkUrl.prefix;
    String Endpoint = networkUrl.getPhoto;
    String token = await getToken();

    var url = Uri.parse(URL + Endpoint + '/$id');

    try {
      var response = await get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        ImageUser image = ImageUser.fromJson(jsonDecode(response.body));
        return image;
      } else {
        print(response.body);
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      print(e);
      return ImageUser.empty();
    }
  }


  Future<Memberships> MakeMembership(int id) async { 
    String URL = networkUrl.prefix;
    String Endpoint = networkUrl.getMember;
    String token = await getToken();

    var url = Uri.parse(URL + Endpoint + '/$id');

    var data= {
      "id_user": id,
      
    };


    try{
      var response = await post(url, body: jsonEncode(data), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });


      print(response.statusCode);
      if(response.statusCode == 200){
        print(response.body);
        Memberships membership = Memberships.fromJson(jsonDecode(response.body));
        return membership;
      } else {
        print(response.body);
        throw Exception('Failed to make membership');
      }
    }catch(e){
      print(e);
      throw Exception('Failed to authenticate');
    }
  }

  Future<bool> checkMembership(int id) async {
    String URL = networkUrl.prefix;
    String Endpoint = networkUrl.checkMember;
    String token = await getToken();

    var url = Uri.parse(URL + Endpoint + '/$id');

    try{
      var response = await get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print(response.statusCode);
      if(response.statusCode == 200){
        print(response.body);
        return true;
      } else {
        print(response.body);
        return false;
      }
    }catch(e){
      print(e);
      throw Exception('Failed to authenticate');
    }
  }
}
