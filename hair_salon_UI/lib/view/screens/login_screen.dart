import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/view/screens/dashboard.dart';
import 'package:ui_practice/view/widgets/custom_card.dart';

import '../../view_model/auht_data_provider.dart';
import '../widgets/overlay_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  final paddingTop = 25.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRef = ref.watch(authDataProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            //  height: MediaQuery.of(context).size.height - paddingTop,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - paddingTop,
                child: Padding(
                  padding: EdgeInsets.only(top: paddingTop),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/avatar.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 15,
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              )),
                              child: Icon(
                                Icons.cancel,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: CustomCard(),
                    )
                  ]),
                ),
              ),
            ),
          ),
          if (authRef.isLoading!) const LoadingOverlay(),
        ],
      ),
    );
  }
}
