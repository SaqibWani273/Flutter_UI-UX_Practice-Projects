import 'package:flutter/material.dart';

const linkStyle = TextStyle(
  color: Colors.blue,
);
const defaultStyle = TextStyle(color: Colors.black);
RoundedRectangleBorder getRoundRectangleBorder(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}
