// import 'package:flutter/material.dart';
// import 'package:ugd6_b_9/Entity/User.dart';
//
// import 'package:ugd6_b_9/entity/ResponseDataUser.dart';
//
// class testing_function {
//
//   static Future<ResponseDataUser?> login(String email, String password) async {
//     ResponseDataUser responseDataUser = ResponseDataUser.empty();
//     User user = User(
//       id: 1,
//       fullname: '1',
//       username: '1',
//       email: '1',
//       password: '1',
//       birthdate: '1/1/1',
//       gender: 'male',
//       phone: '1',
//       weight: 1,
//       height: 1,
//       photo: '1',
//     );
//
//     if (email == '1' && password == '1') {
//       responseDataUser.access_token = 'BISAAAAAANJENGG';
//       responseDataUser.message = 'Login Success';
//       responseDataUser.token_type = 'Bearer';
//       responseDataUser.Data = user;
//     }else{
//       responseDataUser.access_token = '';
//       responseDataUser.message = 'Login Failed';
//       responseDataUser.token_type = '';
//       responseDataUser.Data = User.empty();
//     }
//
//     return responseDataUser;
//
//   }
// }