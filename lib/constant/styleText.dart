import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
  Color? color;
  StyleText({this.color});
  
  TextStyle styleT1b = GoogleFonts.poppins(
    fontSize: 30, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleT1l = GoogleFonts.poppins(
    fontSize: 30, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH1b = GoogleFonts.poppins(
    fontSize: 24, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH1l = GoogleFonts.poppins(
    fontSize: 24, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH2b = GoogleFonts.poppins(
    fontSize: 20, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH2l = GoogleFonts.poppins(
    fontSize: 20, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH3b = GoogleFonts.poppins(
    fontSize: 16, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH3l = GoogleFonts.poppins(
    fontSize: 16, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH4b = GoogleFonts.poppins(
    fontSize: 14, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleH4l = GoogleFonts.poppins(
    fontSize: 14, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle stylePb = GoogleFonts.poppins(
    fontSize: 12, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700,
     // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle stylePl = GoogleFonts.poppins(
    fontSize: 12, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );

  TextStyle styleP2b = GoogleFonts.poppins(
    fontSize: 10, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700,
     // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleP2l = GoogleFonts.poppins(
    fontSize: 10, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleP3b = GoogleFonts.poppins(
    fontSize: 8, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w700,
     // Atur berat font sesuai kebutuhan Anda.;
  );
  TextStyle styleP3l = GoogleFonts.poppins(
    fontSize: 8, // Atur ukuran font sesuai kebutuhan Anda.
    fontWeight: FontWeight.w400, // Atur berat font sesuai kebutuhan Anda.;
  );

  TextStyle get styleH1bWithColor => styleH1b.copyWith(color: color);
  TextStyle get styleH1lWithColor => styleH1l.copyWith(color: color);
  TextStyle get styleH2bWithColor => styleH2b.copyWith(color: color);
  TextStyle get styleH2lWithColor => styleH2l.copyWith(color: color);
  TextStyle get styleH3bWithColor => styleH3b.copyWith(color: color);
  TextStyle get styleH3lWithColor => styleH3l.copyWith(color: color);
  TextStyle get styleH4bWithColor => styleH4b.copyWith(color: color);
  TextStyle get styleH4lWithColor => styleH4l.copyWith(color: color);
  TextStyle get stylePbWithColor => stylePb.copyWith(color: color);
  TextStyle get stylePlWithColor => stylePl.copyWith(color: color);
  TextStyle get styleP2bWithColor => styleP2b.copyWith(color: color);
  TextStyle get styleP2lWithColor => styleP2l.copyWith(color: color);
  TextStyle get styleP3bWithColor => styleP3b.copyWith(color: color);
  TextStyle get styleP3lWithColor => styleP3l.copyWith(color: color);
  
}
