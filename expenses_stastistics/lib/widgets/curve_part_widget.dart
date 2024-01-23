import 'package:flutter/material.dart';

import '../custom_painter.dart';
import '../models/data.dart';

class CurvePart extends StatelessWidget {
  CurvePart({
    Key? key,
  }) : super(key: key);

  final data = Data();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: data.spendingTime
              .map(
                (spendTime) => TextButton(
                  onPressed: null,
                  style: data.currentSpendingTime == spendTime
                      ? TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          fixedSize: const Size(100, 40),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))))
                      : null,
                  child: Text(
                    spendTime,
                    style: data.currentSpendingTime == spendTime
                        ? const TextStyle(
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              )
              .toList(),
        ),
        //dropdown container
        Container(
          height: 40.0,
          width: 150.0,
          margin: const EdgeInsets.only(
            left: 250.0,
            top: 30.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              //to increase the height
              isExpanded: true,
              icon: const Icon(
                Icons.expand_more,
                color: Colors.black,
              ),
              value: 'Expense',
              items: [
                'Expense',
                'Expense1',
                'Expense2',
                'Expense3',
              ]
                  .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      )))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: MyCustomPainter(),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blueAccent,
                  ),
                ),
                CustomPaint(
                  painter: MyCustomPainter1(),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                    // coordinates of point on curve
                    height: 200 * 0.4808500 - 40,
                    width: MediaQuery.of(context).size.width * 0.3662200 + 180,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.teal,
                              width: 0.5,
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            '\$1,230',
                            style: TextStyle(color: Colors.teal, fontSize: 20),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 47),
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 30,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ))
              ],
            ),

            //months container
            Container(
              margin: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: data.months
                        .map((month) => Row(
                              children: [
                                Text(
                                  month,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(
                                  width: 41,
                                )
                              ],
                            ))
                        .toList()),
              ),
            )
          ],
        ),
      ],
    );
  }
}
