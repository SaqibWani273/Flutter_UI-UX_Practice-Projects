import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.indicatorsCount,
    required this.currentIndex,
    this.inActiveColor,
  });
  final int indicatorsCount;
  final int currentIndex;
  final Color? inActiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
        //    mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            indicatorsCount,
            (index) => Container(
                  width: currentIndex == index ? 20 : 5.0,
                  height: 3.0,
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(800),

                    borderRadius:
                        BorderRadius.circular(currentIndex == index ? 8 : 15),
                    color: currentIndex == index
                        ? Colors.blue
                        : inActiveColor ?? Colors.white,
                  ),
                )));
  }
}
