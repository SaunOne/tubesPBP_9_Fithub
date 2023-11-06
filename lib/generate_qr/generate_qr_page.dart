import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatelessWidget {
  const GenerateQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('QR Generate'),
      ),
      body: Center(
        child: QrImageView(
          data: QRDATA(randomString(10)),
          version: 6,
          padding: const EdgeInsets.all(50),
        ),
      ),
    );
  }


  String randomString(int strlen) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random();
    final buf = StringBuffer();

    for (var i = 0; i < strlen; i++) {
      buf.write(chars[random.nextInt(chars.length)]);
    }

    return buf.toString();
  }

  String QRDATA(String data) {
    String http = "http://PBP_GYM/";

    return http + data;
 }

}