import 'package:flutter/material.dart';
import 'package:food_app/core/app_colors.dart';
import 'package:food_app/core/app_sizes.dart';
import 'package:food_app/core/extensions.dart';

class FoodHome extends StatefulWidget {
  const FoodHome({super.key});

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.deviceWidth,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.0,
            children: <Widget>[
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
                          GestureDetector(child: const Icon(Icons.menu_open)),
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
                              style: context.th.bodyLarge,
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
                flex: 4,
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    FoodsTab(),
                    Center(child: Text('Drinks')),
                    Center(child: Text('Sauces')),
                    Center(child: Text('Snacks')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        iconSize: 30,
        unselectedItemColor: AppColors.textGrey,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            icon: Icon(Icons.home_filled),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_sharp),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: "",
          ),
        ],
      ),
    );
  }
}

class FoodsTab extends StatefulWidget {
  const FoodsTab({super.key});

  @override
  State<FoodsTab> createState() => _FoodsTabState();
}

class _FoodsTabState extends State<FoodsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // spacing: 20.0,
      children: [
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

        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return SizedBox(
                  height: context.deviceHeight * 0.45,
                  width: context.deviceHeight * 0.3,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: context.deviceHeight * 0.07,
                        child: Card(
                          elevation: 30.0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          shadowColor: Colors.grey.shade50.withAlpha(150),
                          child: Container(
                            width: context.deviceWidth * 0.55,
                            height: context.deviceHeight * 0.3,
                            padding: EdgeInsets.only(bottom: 40),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    'Veggie tomato mix',
                                    textAlign: TextAlign.center,
                                    style: context.th.bodyMedium,
                                  ),
                                ),
                                AppSizes.medium,
                                Text(
                                  '₹120.00',
                                  style: context.th.bodyMedium?.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Image.asset(
                          width: context.deviceWidth * 0.55,
                          'assets/images/food_img6.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
