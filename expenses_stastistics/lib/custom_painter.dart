//custom curve with shapemaker.web.app
import 'dart:ui';

import 'package:flutter/material.dart';

// outline curve
class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0399999618530273;
    //to draw  inner point
    Paint innerPoint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;
    var point = [
      Offset(
        size.width * 0.3662200,
        size.height * 0.4808500,
      )
    ];
    canvas.drawPoints(PointMode.points, point, innerPoint);
    //to draw dashed line

    Paint dashedLine = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.square;
    const dashWidth = 3;
    const dashSpace = 10;
    // initiallly coordinates of the point
    double x = size.width * 0.3662200;
    double startY = size.height * 0.4808500;
    var i = 0;
    //9 dashed lines
    while (i < 9) {
      canvas.drawLine(
        Offset(x, startY),
        Offset(
          x,
          startY + dashWidth,
        ),
        dashedLine,
      );
      //only y coordinate changes ,as we need to draw a vertical
      //line
      startY += dashSpace + dashWidth;
      i++;
    }
    Path path0 = Path();
    path0.moveTo(size.width * 0.0100000, size.height * 0.8550000);
    path0.quadraticBezierTo(size.width * 0.0340000, size.height * 0.6487500,
        size.width * 0.0420000, size.height * 0.5800000);
    path0.cubicTo(
        size.width * 0.0744400,
        size.height * 0.4174000,
        size.width * 0.1377000,
        size.height * 0.6191000,
        size.width * 0.1602000,
        size.height * 0.6216000);
    path0.cubicTo(
        size.width * 0.2025000,
        size.height * 0.6656000,
        size.width * 0.2248200,
        size.height * 0.4178000,
        size.width * 0.2518200,
        size.height * 0.3853000);
    path0.cubicTo(
        size.width * 0.2926000,
        size.height * 0.3118500,
        size.width * 0.3308200,
        size.height * 0.4425500,
        size.width * 0.3662200,
        size.height * 0.4808500);
    path0.cubicTo(
        size.width * 0.4376000,
        size.height * 0.5363500,
        size.width * 0.4481400,
        size.height * 0.3998000,
        size.width * 0.4680800,
        size.height * 0.3513500);
    path0.cubicTo(
        size.width * 0.4932400,
        size.height * 0.2412500,
        size.width * 0.5329600,
        size.height * 0.1647000,
        size.width * 0.5643600,
        size.height * 0.1039500);
    path0.cubicTo(
        size.width * 0.6102800,
        size.height * 0.0022500,
        size.width * 0.7019000,
        size.height * 0.2706500,
        size.width * 0.7352000,
        size.height * 0.3201500);
    path0.cubicTo(
        size.width * 0.7672000,
        size.height * 0.3851500,
        size.width * 0.8093000,
        size.height * 0.4475375,
        size.width * 0.8340000,
        size.height * 0.4900000);
    path0.cubicTo(
        size.width * 0.8848600,
        size.height * 0.5632000,
        size.width * 0.9207400,
        size.height * 0.4865000,
        size.width * 0.9400000,
        size.height * 0.4400000);
    path0.quadraticBezierTo(size.width * 0.9577000, size.height * 0.3667000,
        size.width, size.height * 0.3450000);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//filled paint
class MyCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.green.withOpacity(0.07)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0399999618530273;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0073000, size.height * 0.8550000);
    path0.quadraticBezierTo(size.width * 0.0340000, size.height * 0.6487500,
        size.width * 0.0420000, size.height * 0.5800000);
    path0.cubicTo(
        size.width * 0.0744400,
        size.height * 0.4174000,
        size.width * 0.1377000,
        size.height * 0.6191000,
        size.width * 0.1602000,
        size.height * 0.6216000);
    path0.cubicTo(
        size.width * 0.2025000,
        size.height * 0.6656000,
        size.width * 0.2248200,
        size.height * 0.4178000,
        size.width * 0.2518200,
        size.height * 0.3853000);
    path0.cubicTo(
        size.width * 0.2926000,
        size.height * 0.3118500,
        size.width * 0.3308200,
        size.height * 0.4425500,
        size.width * 0.3662200,
        size.height * 0.4808500);
    path0.cubicTo(
        size.width * 0.4376000,
        size.height * 0.5363500,
        size.width * 0.4481400,
        size.height * 0.3998000,
        size.width * 0.4680800,
        size.height * 0.3513500);
    path0.cubicTo(
        size.width * 0.4932400,
        size.height * 0.2412500,
        size.width * 0.5329600,
        size.height * 0.1647000,
        size.width * 0.5643600,
        size.height * 0.1039500);
    path0.cubicTo(
        size.width * 0.6102800,
        size.height * 0.0022500,
        size.width * 0.7019000,
        size.height * 0.2706500,
        size.width * 0.7352000,
        size.height * 0.3201500);
    path0.cubicTo(
        size.width * 0.7672000,
        size.height * 0.3851500,
        size.width * 0.8093000,
        size.height * 0.4475375,
        size.width * 0.8340000,
        size.height * 0.4900000);
    path0.cubicTo(
        size.width * 0.8848600,
        size.height * 0.5632000,
        size.width * 0.9207400,
        size.height * 0.4865000,
        size.width * 0.9400000,
        size.height * 0.4400000);
    path0.quadraticBezierTo(size.width * 0.9577000, size.height * 0.3667000,
        size.width, size.height * 0.3450000);
    path0.lineTo(size.width * 0.9980000, size.height * 0.9950000);
    path0.lineTo(size.width * 0.0051000, size.height);
    path0.lineTo(size.width * 0.0073000, size.height * 0.8550000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
