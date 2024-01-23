import 'package:flutter/material.dart';
import 'package:ui_practice/models/dashboard_models.dart';

class HairSalonsWidget extends StatelessWidget {
  const HairSalonsWidget({super.key, required this.hairSalons});

  final List<HairSalon> hairSalons;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: hairSalons
            .map(
              (hairSalon) => Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                hairSalon.image,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "${hairSalon.name}\n\n",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                      text: "${hairSalon.address}\n",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500)),
                                ]),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black
                                        .withBlue(100)
                                        .withOpacity(0.8),
                                  ),
                                  Text(
                                    "${hairSalon.distance}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_half_rounded,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    " ${hairSalon.rating} | ${hairSalon.totalReviews} Reviews",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Icon(
                          hairSalon.isVerified
                              ? Icons.local_police_sharp
                              : Icons.local_police_outlined,
                          color:
                              hairSalon.isVerified ? Colors.red : Colors.black,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
