import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/core/app_sizes.dart';
import 'package:food_app/core/app_theme.dart';
import 'package:food_app/core/extensions.dart';

import 'core/app_colors.dart';
import 'view/homepage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appThemeData,
      debugShowCheckedModeBanner: false,

      home: const FoodHome(drawerWidget: FoodDrawer()),
      // home: FoodDrawer(),
    );
  }
}

class FoodDrawer extends StatelessWidget {
  const FoodDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        width: context.drawerWidth,
        // color: const Color.fromARGB(255, 225, 70, 22),
        padding: EdgeInsets.only(
          left: AppSizes.drawerLeftPdding,
          right: 20,
          bottom: 50,
        ),

        child: SizedBox(
          child: Column(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizes.xLargeHeight,
              ...drawerItems.map((item) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(item.icon, color: Colors.white),
                      title: Text(
                        item.title,
                        style: context.th.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // Handle navigation
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 50, right: 20),

                      child: const Divider(
                        color: Colors.white,
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                  ],
                );
              }),
              const Spacer(),
              Row(
                children: [
                  Text(
                    signOut.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  AppSizes.mediumWidth,
                  Icon(signOut.icon, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem({required this.title, required this.icon});
}

final drawerItems = [
  DrawerItem(title: 'orders', icon: Icons.shopping_cart_checkout_outlined),
  DrawerItem(title: 'Profile', icon: Icons.person),
  DrawerItem(title: 'offer & promo', icon: Icons.local_offer_outlined),
  DrawerItem(title: 'Privacy policy', icon: Icons.privacy_tip_outlined),
  DrawerItem(title: 'Security', icon: Icons.security_outlined),
];
final signOut = DrawerItem(title: 'Sign out', icon: Icons.arrow_forward);
