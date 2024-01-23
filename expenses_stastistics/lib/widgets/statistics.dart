import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import '../models/data.dart';
import 'curve_part_widget.dart';
import 'top_spendings_widget.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  var data = Data();
  @override
  Widget build(BuildContext context) {
    final mainContainerHeight = MediaQuery.of(context).size.height * 0.9;

    return Scaffold(
      appBar: AppBar(
          //to change the top statusbar color
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
              Text(
                'Statistics',
                style: Theme.of(context).textTheme.headline3,
              ),
              const IconButton(
                color: Colors.black,
                onPressed: null,
                icon: Icon(
                  Icons.download_sharp,
                  color: Colors.black,
                ),
              )
            ],
          )),
      body: Container(
        height: mainContainerHeight,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: CurvePart(),
            ),
            Expanded(
              flex: 5,
              child: TopSpendingPart(),
            )
          ],
        ),
      ),
    );
  }
}
