import 'package:flutter/material.dart';
import 'package:food_app/core/app_theme.dart';

import 'view/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appThemeData,
      debugShowCheckedModeBanner: false,
      home: const FoodHome(),
    );
  }
}
