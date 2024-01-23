import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ui_practice/constants/other_constants.dart';

class MostPopularServicesWidget extends StatelessWidget {
  const MostPopularServicesWidget({
    super.key,
  });

  final chosenMostPopularService = MostPopularServices.All;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Most Popular Services",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        const SizedBox(
          height: 15,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.05,
            viewportFraction: 0.3,
            padEnds: false,
            enableInfiniteScroll: false,
          ),
          items: MostPopularServices.values
              .map((e) => Container(
                    // width: MediaQuery.of(context).size.width * 0.15,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: e == chosenMostPopularService
                            ? Colors.blue.withOpacity(0.8)
                            : Colors.blue.withOpacity(0.1)),
                    child: Center(
                        child: Text(
                      e.name,
                      softWrap: true,
                    )),
                  ))
              .toList(),
        )
      ]),
    );
  }
}
