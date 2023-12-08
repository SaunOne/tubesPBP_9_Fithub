import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/database/Client/TempatGymClient.dart';
import 'package:ugd6_b_9/entity/model/tempat_gym.dart';
import 'package:ugd6_b_9/entity/model/trainer.dart';
import 'package:ugd6_b_9/constant/url.dart';


class TrainerClient{
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.trainer;
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

  Future<List<Trainer>> showAllTrainers() async {
    token = await getToken();
    try {
      print('url : ${Uri.http(url, endpoint)}');
      var response = await http.get(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

   

      Iterable list = json.decode(response.body)['data'];
      
      TempatGym data;
       var listTrainer = list.map((e) => Trainer.fromJson(e)).toList();
        print('length list : ${listTrainer.length}');
  

      return listTrainer;
    } catch (e) {
      return Future.error(e.toString());
    } 
  }
  
  Future<List<Trainer>> showTrainerHome() async {
    token = await getToken();
    try {
      print('url : ${Uri.http(url, endpoint+'_home')}');
      var response = await http.get(
        Uri.http(url, endpoint+'_home'),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    

      Iterable list = json.decode(response.body)['data'];
      print('length list home : ${list.length}');
      var listTrainer = list.map((e) => Trainer.fromJson(e)).toList();

      return listTrainer;
    } catch (e) {
      return Future.error(e.toString());
    } 
  }

  Future<Trainer> findTrainerById(int id) async {
    token = await getToken();

    print("id yang masuk : ${id}");
    print('url : ${Uri.http(url, "$endpoint/$id")}');
    try {
      var response = await http.get(Uri.http(url, "$endpoint/$id"),headers: _setHeaders());

      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

     print('response : ${response.body}');

     var trainer = await Trainer.fromJson(json.decode(response.body)['data']);

     print('tempat gym id : ${trainer.tempatGymId}');

     trainer.setTempatGym(await TempatGymClient().findTempatGymById(trainer.tempatGymId));
      return trainer;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> createTrainer(Trainer trainer) async {
    token = await getToken();
    try {
      var data = trainer.toJson();

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