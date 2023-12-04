import 'package:flutter/material.dart';
import 'package:ugd6_b_9/Entity/User.dart';

import 'package:ugd6_b_9/entity/ResponseDataUser.dart';
import 'package:ugd6_b_9/view/login.dart';

class testing_function {

  static Future<ResponseDataUser?> login(String email, String password) async {
    ResponseDataUser responseDataUser = ResponseDataUser.empty();
    User user = User(
      id: 1,
      fullname: '1',
      username: '1',
      email: '1',
      password: '1',
      birthdate: '1/1/1',
      gender: 'male',
      phone: '1',
      weight: 1,
      height: 1,
      photo: '1',
    );

    if (email == '1' && password == '1') {
      responseDataUser.access_token = 'BISAAAAAANJENGG';
      responseDataUser.message = 'Login Success';
      responseDataUser.token_type = 'Bearer';
      responseDataUser.Data = user;
    }else{
      responseDataUser.access_token = '';
      responseDataUser.message = 'Login Failed';
      responseDataUser.token_type = '';
      responseDataUser.Data = User.empty(); 
    }

    return responseDataUser;

  }

  static Future<User?> register({required String fullname,required String username,required String email,
      required String password,required String birthdate,required String gender}) async {
    User user = User(
      id: 1,
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      birthdate: birthdate,
      gender: gender,
      phone: '1',
      weight: 1,
      height: 1,
      photo: '1',
    );
    
    if (user.fullname == '' ||
        user.username == '' ||
        user.email == '' ||
        user.birthdate == '' ||
        user.password == '' ||
        user.gender == '') {
        print('masuk sini ${user.fullname}');
      return User.empty();
    } else {
      print('masuk ketempat yang benar');
      return user;
    }
  }   
  
}