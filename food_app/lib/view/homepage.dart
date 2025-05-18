import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:food_app/core/app_sizes.dart';
import 'package:food_app/core/extensions.dart';
import 'package:food_app/view/food_info.dart';

class FoodHome extends StatefulWidget {
  final Widget drawerWidget;
  const FoodHome({super.key, required this.drawerWidget});

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  openDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          isDrawerOpen
              ? AppBar(
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: AppColors.primaryColor,
                  statusBarIconBrightness: Brightness.light,
                ),
              )
              : null,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            widget.drawerWidget,
            Positioned(
              top: isDrawerOpen ? AppSizes.xLargeHeight.height : 0,
              bottom: isDrawerOpen ? AppSizes.xLargeHeight.height : 0,
              left: isDrawerOpen ? context.drawerWidth : 0,
              child: Container(
                decoration:
                    isDrawerOpen
                        ? BoxDecoration(
                          color: AppColors.lightGrey.withAlpha(50),
                          borderRadius: BorderRadius.circular(40.0),
                        )
                        : null,
                padding:
                    isDrawerOpen
                        ? EdgeInsets.only(
                          left: AppSizes.largeWidth.width!,
                          top: 10,
                          bottom: 10,
                        )
                        : null,
                child: FoodHomeWidget(
                  isDrawerOpen: isDrawerOpen,
                  openDrawer: openDrawer, // Pass the function to the widget
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
  final VoidCallback openDrawer;

  const FoodHomeWidget({
    super.key,
    required this.isDrawerOpen,
    required this.openDrawer,
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
            // color: Colors.red,
            borderRadius:
                widget.isDrawerOpen ? BorderRadius.circular(40.0) : null,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: widget.isDrawerOpen ? 10 : 20.0,
            children: <Widget>[
              if (!widget.isDrawerOpen) AppSizes.largeHeight,
              if (widget.isDrawerOpen) AppSizes.xSmallHeight,
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    spacing: 20.0,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: widget.openDrawer,
                            child: const Icon(Icons.menu_open),
                          ),
                          Spacer(),
                          GestureDetector(
                            child: const Icon(
                              Icons.shopping_cart_checkout,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),

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
                flex: widget.isDrawerOpen ? 3 : 4,
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
                borderRadius:
                    widget.isDrawerOpen
                        ? BorderRadius.circular(40)
                        : BorderRadius.zero,

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

class _FoodsTabState extends State<FoodsTab> {
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

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        FoodInfo(foodModel: foodList[0]),
                              ),
                            ),
                        child: SizedBox(
                          width:
                              widget.isDrawerOpen
                                  ? context.deviceWidth * 0.5
                                  : context.deviceWidth * 0.65,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 60,
                                bottom: widget.isDrawerOpen ? 40 : 60,
                                left: widget.isDrawerOpen ? 10 : null,
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
                                child: Image.asset(
                                  width:
                                      widget.isDrawerOpen
                                          ? context.deviceWidth * 0.4
                                          : context.deviceWidth * 0.52,

                                  'assets/images/plate_with_shadow.png',
                                  fit: BoxFit.contain,
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
    images: [
      'assets/images/plate_with_shadow.png',
      'assets/images/plate_with_shadow.png',
      'assets/images/plate_with_shadow.png',
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
    images: [
      'assets/images/plate_with_shadow.png',
      'assets/images/plate_with_shadow.png',
      'assets/images/plate_with_shadow.png',
    ],
    title: 'Veggie tomato mix',
    price: '₹120.00',
    deleiveryInfo: "Delivered between 10:00 AM - 12:00 PM",
    returnPolicy:
        "All foods are double checked to make sure they are fresh and safe.If you are not satisfied with the food, you can return it within 30 days.",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
];
