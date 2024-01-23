import 'dart:developer';

import 'package:flutter/material.dart';

class Data {
  List<Map<String, dynamic>> bottomIcons = [
    {
      'icon_outlined': Icons.home_outlined,
      'icon_filled': Icons.home_filled,
    },
    {
      'icon_outlined': Icons.bar_chart_outlined,
      'icon_filled': Icons.bar_chart_sharp,
    },
    {
      'icon_outlined': Icons.save_as_outlined,
      'icon_filled': Icons.save_as_sharp,
    },
    {
      'icon_outlined': Icons.account_box_outlined,
      'icon_filled': Icons.account_box_rounded,
    }
  ];
  List<Map<String, dynamic>> listTileData = [
    {
      'title': 'StarBucks',
      'subtitle': 'Jan 12 2022',
      'image': 'assets/images/starbucks.png',
      'trailingText': '- \$ 150.00',
      'isSelected': false,
    },
    {
      'title': 'Transfer',
      'subtitle': 'Yesterday',
      'image': 'assets/images/transfer.png',
      'trailingText': '-\$ 85.00',
      'isSelected': true,
    },
    {
      'title': 'Youtube',
      'subtitle': 'Jan 16,2022',
      'image': 'assets/images/youtube.png',
      'trailingText': '-\$ 11.99',
      'isSelected': false,
    },
  ];
  String currentSpendingTime = 'Day';
  List spendingTime = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  List months = [
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}
