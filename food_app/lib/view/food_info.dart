// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/core/app_sizes.dart';
import 'package:food_app/core/extensions.dart';

import '../core/animation/animations.dart';
import '../core/navigation.dart';

class FoodInfo extends StatelessWidget {
  final FoodModel foodModel;
  const FoodInfo({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        leading: FutureBuilder(
          future: Future.delayed(duration3),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            return FadeInAnimation(
              child: IconButton(
                icon:
                    const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ).small,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        actions: [
          FutureBuilder(
            future: Future.delayed(duration3),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BounceInFromBottom(
                  child: IconButton(
                    icon:
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ).small,
                    onPressed: () {
                      // Handle shopping cart action
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          20.0.w,
        ],
      ),
      body: SizedBox(
        height: context.deviceHeight * 0.85,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 30.0,
                  children: [
                    ImagesWithIndicator(
                      imgList: foodModel.images,
                      id: foodModel.id,
                    ),
                    AppSizes.largeHeight,
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        spacing: 10.0,
                        children: [
                          Text(
                            foodModel.title,
                            style: context.th.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            foodModel.price,
                            style: context.th.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Info",
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSizes.xSmallHeight,
                        Text(
                          foodModel.deleiveryInfo,
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Return Policy",
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSizes.xSmallHeight,
                        Text(
                          foodModel.returnPolicy,
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSizes.xSmallHeight,
                        Text(
                          foodModel.description,
                          style: context.th.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey1,
                          ),
                        ),
                      ],
                    ),
                    AppSizes.xxLargeHeight,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: context.deviceWidth * 0.8,
                height: context.deviceHeight * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Add to Cart",
                    style: context.th.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagesWithIndicator extends StatefulWidget {
  final String id;
  final List<String> imgList;
  const ImagesWithIndicator({
    super.key,
    required this.imgList,
    required this.id,
  });

  @override
  State<ImagesWithIndicator> createState() => _ImagesWithIndicatorState();
}

class _ImagesWithIndicatorState extends State<ImagesWithIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  @override
  void initState() {
    //rotation animation
    _controller = AnimationController(duration: duration2, vsync: this)
      ..forward();
    _rotationAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    super.initState();
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imgList.length,
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIdx) {
            return Hero(
              tag: widget.imgList[index] + widget.id,
              child: AnimatedBuilder(
                animation: _rotationAnimation,

                child: Image.asset(widget.imgList[index], fit: BoxFit.cover),
                builder: (context, child) {
                  return Transform.rotate(
                    angle:
                        _rotationAnimation.value * 2 * 3.14, // Rotate the image
                    child: child,
                  );
                },
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => Dots(isCurrent: index == 0)),
          // widget.imgList.asMap().entries.map((entry) {
          //   return GestureDetector(
          //     onTap: () => setState(() => _current = entry.key),
          //     child: Dots(current: _current),
          //   );
          // }).toList(),
        ),
      ],
    );
  }
}

class Dots extends StatelessWidget {
  const Dots({super.key, required bool isCurrent}) : _current = isCurrent;

  final bool _current;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current ? Colors.deepOrange : Colors.grey.withOpacity(0.4),
      ),
    );
  }
}

class FoodModel {
  final List<String> images;
  final String title;
  final String price;
  final String deleiveryInfo;
  final String returnPolicy;
  final String description;
  final String id;
  FoodModel({
    required this.images,
    required this.title,
    required this.price,
    required this.deleiveryInfo,
    required this.returnPolicy,
    required this.description,
    required this.id,
  });
}
