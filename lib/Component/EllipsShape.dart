import 'package:flutter/material.dart';
import 'package:griding/constant/color.dart';

class EllipsShape extends StatelessWidget {

  final double height;
  final double width;
  final double radius;


  const EllipsShape(this.height, this.width, this.radius, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: CustomPaint(
        painter: CurvePainter(radius),
      ),
    );
  }

}

class CurvePainter extends CustomPainter {

  double radius;

  CurvePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorPallete.primaryColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * radius);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * radius);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}