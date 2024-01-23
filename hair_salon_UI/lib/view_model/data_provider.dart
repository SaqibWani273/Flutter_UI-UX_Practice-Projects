import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/models/dashboard_models.dart';
import 'package:ui_practice/services/firestore.dart';

class DashboardDataProvider extends StateNotifier<DashboardModels?> {
  DashboardDataProvider() : super(null);
  Future<void> getDashboardData() async {
    TodaySpecial? todaySpecial;
    List<FeaturedService>? featuredServices;
    List<CategoryModel>? categories;
    List<HairSalon>? hairSalons;

    try {
      todaySpecial = await FirestoreService().getTodaySpecial();
    } catch (e) {
      log("error in getting today special data from firestore $e");
    }

    try {
      featuredServices = await FirestoreService().getFeaturedServices();
    } catch (e) {
      log("error in getting featured services data from firestore $e");
    }

    try {
      categories = await FirestoreService().getCategories();
    } catch (e) {
      log("error in getting categories data from firestore $e");
    }
    try {
      hairSalons = await FirestoreService().getHairSalons();
    } catch (e) {
      log("error in getting hair salons data from firestore $e");
    }

    if (todaySpecial != null && featuredServices != null) {
      state = DashboardModels(
        todaySpecial: todaySpecial,
        featuredServices: featuredServices,
        categories: categories!,
        hairSalons: hairSalons!,
      );
    }
  }
}

final dashboardDataProvider =
    StateNotifierProvider<DashboardDataProvider, DashboardModels?>((ref) {
  return DashboardDataProvider();
});
