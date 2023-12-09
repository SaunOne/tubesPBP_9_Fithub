import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/entity/model/fasilitas.dart'; // Pastikan mengganti dengan path yang sesuai
import 'package:ugd6_b_9/constant/url.dart';

class FasilitasClient {
  static final String url = networkUrl.prefix;
  static final endpoint = networkUrl.fasilitas;
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

  Future<List<Fasilitas>> showFasilitasByJenisPaket(int idJenisPaket) async {
    token = await getToken();
    try {
      print(Uri.parse(url + endpoint + '/$idJenisPaket'));
      var response = await http.get(
        
        Uri.parse(url + endpoint + '/$idJenisPaket'),
        headers: _setHeaders(),
      );
      
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      print('list : ${list}');
      return list.map((e) => Fasilitas.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
