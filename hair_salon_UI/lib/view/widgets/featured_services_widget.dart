import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ui_practice/models/dashboard_models.dart';
import 'package:ui_practice/view/widgets/custom_indicator.dart';

class FeaturedServicesWidget extends StatefulWidget {
  const FeaturedServicesWidget({
    super.key,
    required this.featuredServices,
  });

  final List<FeaturedService> featuredServices;

  @override
  State<FeaturedServicesWidget> createState() => _FeaturedServicesWidgetState();
}

class _FeaturedServicesWidgetState extends State<FeaturedServicesWidget> {
  final featuredTextStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  var currentIndex = 0;
  //
  late int indicatorsCount;
  //needed for courselider
  var previousIndex = 0;
  @override
  void initState() {
    final lengthInDouble = widget.featuredServices.length / 3.floor().toInt();

    indicatorsCount = lengthInDouble.toInt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Featured Services",
                style: featuredTextStyle,
              ),
              const Spacer(),
              SizedBox(
                  //   width: 20,
                  child: CustomIndicator(
                indicatorsCount: indicatorsCount,
                currentIndex: currentIndex,
                inActiveColor: Colors.grey,
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  viewportFraction: 0.4,
                  padEnds: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (courselIndex, reason) {
                    //Note : Donot try to read it
                    //got the exact feature after hours of hard-coding
                    if (courselIndex % 3 == 1 &&
                        courselIndex != widget.featuredServices.length - 2) {
                      //for every 3rd courselIndex

                      setState(() {
                        previousIndex < courselIndex
                            ? currentIndex++
                            : currentIndex--;
                      });

                      previousIndex = courselIndex;
                      if (courselIndex == previousIndex && previousIndex == 1) {
                        previousIndex = -1;
                      }
                    }
                  }),
              items: widget.featuredServices
                  .map(
                    (featuredService) => Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Card(
                            elevation: 5,
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                child: Image.network(
                                  featuredService.image,
                                  fit: BoxFit.fill,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    if (frame == null) {
                                      return Container(
                                        color: Colors.grey.withOpacity(0.5),
                                      );
                                    }
                                    return child;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
//list of text using richtext

                              RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "${featuredService.name}\n\n",
                                        style: featuredTextStyle),
                                    TextSpan(
                                        text:
                                            "Rs ${featuredService.discountPrice}   ",
                                        style: featuredTextStyle),
                                    TextSpan(
                                        text:
                                            "Rs ${featuredService.originalPrice}",
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                  ]))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ]));
  }
}
// //
// ListView.builder(
//                 itemCount: widget.featuredServices.length,
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   log('listview index =$index');
//                   final featuredService = widget.featuredServices[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 5.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.35,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8.0),
//                         child: Card(
//                           elevation: 5,
//                           child: Column(children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8.0),
//                                   topRight: Radius.circular(8.0)),
//                               child: Image.network(
//                                 featuredService.image,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5.0,
//                             ),
// //list of text using richtext

//                             RichText(
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "${featuredService.name}\n\n",
//                                       style: featuredTextStyle),
//                                   TextSpan(
//                                       text:
//                                           "Rs ${featuredService.discountPrice}   ",
//                                       style: featuredTextStyle),
//                                   TextSpan(
//                                       text:
//                                           "Rs ${featuredService.originalPrice}",
//                                       style: const TextStyle(
//                                           color: Colors.grey,
//                                           decoration:
//                                               TextDecoration.lineThrough)),
//                                 ]))
//                           ]),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
