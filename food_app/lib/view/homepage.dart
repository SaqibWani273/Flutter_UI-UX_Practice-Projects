import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:food_app/core/app_sizes.dart';
import 'package:food_app/core/extensions.dart';
import 'package:food_app/view/food_info.dart';

import '../core/navigation.dart';

class FoodHome extends StatefulWidget {
  final Widget drawerWidget;
  const FoodHome({super.key, required this.drawerWidget});

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  bool isDrawerOpen = false;

  // Controls the X/Y offset and scale of the main screen
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  Duration duration = const Duration(milliseconds: 300);

  void openDrawer() {
    setState(() {
      xOffset = context.drawerWidth;
      yOffset = AppSizes.xLargeHeight.height! * 3;
      scaleFactor = 0.75;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            widget.drawerWidget,
            AnimatedContainer(
              curve: Curves.easeOut,
              duration: duration,
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              clipBehavior: Clip.antiAlias,
              padding:
                  isDrawerOpen
                      ? EdgeInsets.only(left: 30, top: 20, bottom: 20)
                      : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withAlpha(50),
                borderRadius:
                    isDrawerOpen
                        ? BorderRadius.circular(30)
                        : BorderRadius.circular(0),
              ),

              child: GestureDetector(
                onTap: isDrawerOpen ? closeDrawer : null,
                child: AbsorbPointer(
                  absorbing: isDrawerOpen,

                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius:
                          isDrawerOpen ? BorderRadius.circular(30) : null,
                    ),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: AppColors.scaffoldBackgroundColor,
                        elevation: 0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: AppColors.scaffoldBackgroundColor,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                        title: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                isDrawerOpen ? closeDrawer() : openDrawer();
                              },
                              child: const Icon(
                                Icons.menu_open,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              child: const Icon(
                                Icons.shopping_cart_checkout,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: FoodHomeWidget(isDrawerOpen: isDrawerOpen),
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

class FoodHomeWidget extends StatefulWidget {
  final bool isDrawerOpen;
  // final VoidCallback toggleDrawer;

  const FoodHomeWidget({
    super.key,
    required this.isDrawerOpen,
    // required this.toggleDrawer,
  });

  @override
  State<FoodHomeWidget> createState() => _FoodHomeWidgetState();
}

class _FoodHomeWidgetState extends State<FoodHomeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: context.deviceWidth,

          decoration: BoxDecoration(
            color: AppColors.scaffoldBackgroundColor,
            borderRadius:
                widget.isDrawerOpen ? BorderRadius.circular(40.0) : null,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // spacing: widget.isDrawerOpen ? 10 : 20.0,
            spacing: 20.0,
            children: <Widget>[
              AppSizes.smallHeight,
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    spacing: 20.0,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Delicious\n food for you',
                              style:
                                  widget.isDrawerOpen
                                      ? context.th.bodyMedium
                                      : context.th.bodyLarge,
                            ),
                          ),
                        ],
                      ),

                      // Text('Delicious food for you', style: context.th.bodyMedium),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon:
                              const Icon(
                                Icons.search,
                                color: Colors.black,
                              ).medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TabBar(
                  labelStyle: context.th.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  unselectedLabelStyle: context.th.bodyMedium?.copyWith(
                    color: AppColors.textGrey,
                  ),

                  controller: _controller,
                  // isScrollable: true,
                  indicatorColor: Colors.deepOrange,
                  indicatorWeight: 4,
                  tabs: const [
                    Tab(text: 'Foods'),
                    Tab(text: 'Drinks'),
                    Tab(text: 'Sauces'),
                    Tab(text: 'Sancks'),
                  ],
                ),
              ),
              Expanded(
                flex: 4, // widget.isDrawerOpen ? 3 : 4,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    FoodsTab(isDrawerOpen: widget.isDrawerOpen),
                    Center(child: Text('Drinks')),
                    Center(child: Text('Sauces')),
                    Center(child: Text('Snacks')),
                  ],
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(40),

                child: BottomNavigationBar(
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  selectedItemColor: AppColors.primaryColor,
                  iconSize: 30,
                  unselectedItemColor: AppColors.textGrey,
                  items: [
                    BottomNavigationBarItem(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      icon: Icon(Icons.home_filled),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline_sharp),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outlined),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.history_outlined),
                      label: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FoodsTab extends StatefulWidget {
  final bool isDrawerOpen;
  const FoodsTab({super.key, this.isDrawerOpen = false});

  @override
  State<FoodsTab> createState() => _FoodsTabState();
}

class _FoodsTabState extends State<FoodsTab>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double scrollOffset = 0.0;
  late AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(duration: duration3, vsync: this)
      ..forward();
    _rotationAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _scrollController =
        ScrollController()..addListener(() {
          _controller.forward(from: 0.3);
        });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            if (!widget.isDrawerOpen)
              Padding(
                padding: EdgeInsets.only(left: context.deviceWidth * 0.5),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "see more",
                    style: context.th.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),

            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(overscroll: false),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(foodList.length, (index) {
                      return GestureDetector(
                        onTap:
                            () => TransitionNavigation.push(
                              transitionType: TransitionType.slideup,
                              context: context,
                              curve: Curves.easeOut,
                              page: FoodInfo(foodModel: foodList[index]),
                            ),
                        child: SizedBox(
                          width: context.deviceWidth * 0.65,

                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 60,
                                bottom: widget.isDrawerOpen ? 40 : 60,
                                left: widget.isDrawerOpen ? 15 : null,
                                right: widget.isDrawerOpen ? 10 : null,

                                child: Card(
                                  elevation: 30.0,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  shadowColor: AppColors.lightShadowColor,
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 40),

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 40,
                                          ),
                                          child: Text(
                                            'Veggie tomato mix',
                                            textAlign: TextAlign.center,
                                            style: context.th.bodyMedium,
                                          ),
                                        ),
                                        AppSizes.mediumHeight,
                                        Text(
                                          '₹120.00',
                                          style: context.th.bodyMedium
                                              ?.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,

                                child: AnimatedBuilder(
                                  animation: _rotationAnimation,

                                  // duration: const Duration(milliseconds: 300),
                                  // curve: Curves.easeInOut,
                                  // tween: Tween<double>(
                                  //   begin: 0,
                                  //   end: (scrollOffset * 0.09).clamp(
                                  //     -0.5,
                                  //     0.5,
                                  //   ), // Larger multiplier
                                  // ),
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle:
                                          _rotationAnimation.value *
                                          2 *
                                          3.14, // Rotate the image
                                      child: child,
                                    );
                                  },
                                  child: Hero(
                                    tag:
                                        foodList[index].images[0] +
                                        foodList[index].id,
                                    child: Image.asset(
                                      width: context.deviceWidth * 0.52,
                                      foodList[index].images[0],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

final List<FoodModel> foodList = [
  FoodModel(
    id: UniqueKey().toString(),

    images: [
      'assets/images/plate_with_shadow.png',

      // 'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
    ],
    title: 'Veggie tomato mix',
    price: '₹120.00',
    deleiveryInfo: "Delivered between 10:00 AM - 12:00 PM",
    returnPolicy:
        "All foods are double checked to make sure they are fresh and safe.If you are not satisfied with the food, you can return it within 30 days.",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
  FoodModel(
    id: UniqueKey().toString(),
    images: [
      'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
    ],
    title: 'Chicken Salad',
    price: '₹120.00',
    deleiveryInfo: "Delivered between 10:00 AM - 12:00 PM",
    returnPolicy:
        "All foods are double checked to make sure they are fresh and safe.If you are not satisfied with the food, you can return it within 30 days.",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
  FoodModel(
    id: UniqueKey().toString(),
    images: [
      'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
    ],
    title: 'Chicken Salad',
    price: '₹120.00',
    deleiveryInfo: "Delivered between 10:00 AM - 12:00 PM",
    returnPolicy:
        "All foods are double checked to make sure they are fresh and safe.If you are not satisfied with the food, you can return it within 30 days.",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
  FoodModel(
    id: UniqueKey().toString(),
    images: [
      'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
      // 'assets/images/plate_with_shadow.png',
    ],
    title: 'Chicken Salad',
    price: '₹120.00',
    deleiveryInfo: "Delivered between 10:00 AM - 12:00 PM",
    returnPolicy:
        "All foods are double checked to make sure they are fresh and safe.If you are not satisfied with the food, you can return it within 30 days.",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
];
