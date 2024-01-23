import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../models/dashboard_models.dart';

class TodaySpecialWidget extends StatefulWidget {
  const TodaySpecialWidget({
    super.key,
    required this.todaySpecial,
  });

  final TodaySpecial? todaySpecial;

  @override
  State<TodaySpecialWidget> createState() => _TodaySpecialWidgetState();
}

class _TodaySpecialWidgetState extends State<TodaySpecialWidget> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.3,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) => setState(() {
            currentIndex = index;
          }),
        ),
        items: widget.todaySpecial!.images
            .map(
              (imageUrl) => ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (frame == null) {
                        return Container(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      }
                      return child;
                    },
                  ),
                ),
              ),
            )
            .toList(),
      ),
      Positioned(
        bottom: 20,
        child: SizedBox(
          //  height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.todaySpecial!.images.asMap().entries.map((entry) {
              return Container(
                width: currentIndex == entry.key ? 20 : 5.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(800),

                  borderRadius:
                      BorderRadius.circular(currentIndex == entry.key ? 8 : 15),
                  color: currentIndex == entry.key ? Colors.blue : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ),
      Positioned(
        left: 10,
        bottom: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: 80,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade800.withOpacity(0.8)),
              child: Text(
                "30% OFF",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text("\nToday's Special\n ",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
            Text(
              "${widget.todaySpecial!.text} \nonly valid for today!",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      )
    ]);
  }
}
