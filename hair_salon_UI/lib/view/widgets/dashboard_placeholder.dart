import 'package:flutter/material.dart';

class DashboardPlaceholder extends StatelessWidget {
  const DashboardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: SingleChildScrollView(
            child: SizedBox(
          //  height: height,
          child: Column(
              children: List.generate(
                  3,
                  (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                PlaceHolderContainer(
                                  height: height * 0.09,
                                  width: width * 0.15,
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: List.generate(
                                    2,
                                    (index) => PlaceHolderContainer(
                                      height: height * 0.02,
                                      width: width * 0.2,
                                      radius: 10,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: List.generate(
                                    2,
                                    (index) => PlaceHolderContainer(
                                      height: height * 0.03,
                                      width: width * 0.05,
                                      radius: 10.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Center(
                                child: PlaceHolderContainer(
                              height: height * 0.04,
                              width: width * 0.9,
                              radius: 10.0,
                            )),
                            Center(
                              child: PlaceHolderContainer(
                                  height: height * 0.1,
                                  width: width * 0.6,
                                  radius: 10.0),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    3,
                                    (index) => PlaceHolderContainer(
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        radius: 20))),
                            Center(
                                child: PlaceHolderContainer(
                              height: height * 0.04,
                              width: width * 0.9,
                              radius: 10.0,
                            )),
                          ]))),
        )),
      ),
    );
  }
}

class PlaceHolderContainer extends StatelessWidget {
  const PlaceHolderContainer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.grey.withOpacity(0.5)),
    );
  }
}
