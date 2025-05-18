import 'package:flutter/material.dart';

extension TextThemeExtensions on BuildContext {
  TextTheme get th => Theme.of(this).textTheme;
}

extension SizeExtensions on double {
  SizedBox get h => SizedBox(height: this);
  SizedBox get w => SizedBox(width: this);
}

extension DeviceSizeExtensions on BuildContext {
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;
  double get drawerWidth => deviceWidth * 0.5;
}

extension IconsExtensions on Icon {
  Icon get medium => Icon(icon, size: 28.0, color: color);
  Icon get small => Icon(icon, size: 24.0, color: color);
}
