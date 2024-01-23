import 'package:flutter/material.dart';

const linkStyle = TextStyle(
  color: Colors.blue,
);
const defaultStyle = TextStyle(color: Colors.black);
//getter function of round rectangular border
RoundedRectangleBorder getRoundRectangleBorder(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

const horizontalPaddingForDashboard = 20.0;
