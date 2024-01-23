import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/constants/login_page_consts.dart';
import 'package:ui_practice/constants/other_constants.dart';
import 'package:ui_practice/view/widgets/dashboard_placeholder.dart';
import 'package:ui_practice/view_model/auht_data_provider.dart';

import '../../models/dashboard_models.dart';
// import '../widgets/categories_widget.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/most_popular_services_widget.dart';
import '../../models/user_auth_model.dart';
import '../widgets/categories_widget.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/hair_salons_widget.dart';
import '../widgets/most_popular_services_widget.dart';
import 'categories_screen.dart';
import '../../view_model/data_provider.dart';
import '../widgets/today_special_widget.dart';
import '../widgets/featured_services_widget.dart';

const username = "Saqib Wani";
const imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/practice-a07be.appspot.com/o/Build_With_Innovation%2Fuser_pic%2Fdummy_id_123%2F2150771113.jpg?alt=media&token=742cc0bd-b5d4-4272-9ae2-f254eed53a06';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  late Future<void> _future;
  @override
  void initState() {
    _future = myfutureFunc();
    super.initState();
  }

  Future<void> myfutureFunc() async {
    await ref.read(dashboardDataProvider.notifier).getDashboardData();
    await ref.read(authDataProvider.notifier).getUser();
  }

  late DashboardModels? _dashboardModels;

  final searchFieldHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DashboardPlaceholder();
        }
        _dashboardModels = ref.watch(dashboardDataProvider);
        if (_dashboardModels == null) {
          return const Center(child: Text('No data'));
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppbar(),
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPaddingForDashboard,
              ),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.sort_rounded),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(height: 0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: TodaySpecialWidget(
                        todaySpecial: _dashboardModels!.todaySpecial),
                  ),

                  //featured services
                  FeaturedServicesWidget(
                    featuredServices: _dashboardModels!.featuredServices,
                  ),
//categories
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Category"),
                        const Spacer(),
                        TextButton(
                            onPressed: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CategoriesScreen(
                                      categories: _dashboardModels!.categories),
                                )),
                            child: const Text("View All"))
                      ],
                    ),
                    CategoriesWidget(
                      categories: _dashboardModels!.categories,
                      isWidget: true,
                    )
                  ]),
                  //most popular services
                  MostPopularServicesWidget(),
                  HairSalonsWidget(
                    hairSalons: _dashboardModels!.hairSalons,
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
