import 'dart:developer';

import 'package:flutter/material.dart';

import 'widgets/statistics.dart';
import 'models/data.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline3: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          headline4: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          headline2: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.red[400],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Data data = Data();
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 1,
  );
  void changeIndex(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('main.dart build');
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(),
            const Statistics(),
            Container(),
            Container(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 90.0,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.transparent,
            tabs: data.bottomIcons
                .asMap()
                .map(
                  (int index, Map value) => MapEntry(
                    index,
                    IconButton(
                      onPressed: () {
                        changeIndex(index);
                      },
                      icon: Icon(
                        _tabController.index == index
                            ? value['icon_filled']
                            : value['icon_outlined'],
                        size: 40,
                        color: _tabController.index == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ));
  }
}
