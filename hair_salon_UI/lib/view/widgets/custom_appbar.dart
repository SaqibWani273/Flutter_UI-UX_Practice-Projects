import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/constants/login_page_consts.dart';
import 'package:ui_practice/view_model/auht_data_provider.dart';

const dummyUrl =
    "https://firebasestorage.googleapis.com/v0/b/practice-a07be.appspot.com/o/Build_With_Innovation%2Fuser_pic%2Fdummy_id_123%2F2150771113.jpg?alt=media&token=742cc0bd-b5d4-4272-9ae2-f254eed53a06";

class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key}) : preferredSize = const Size.fromHeight(95);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authDataProvider).user;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalPaddingForDashboard, vertical: 40),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              //     backgroundImage: NetworkImage(currentUser.image),
              backgroundImage: NetworkImage(dummyUrl),
              backgroundColor: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Good Morning'),
              Text(
                currentUser != null ? currentUser.username : 'John Doe',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ])
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.notifications_outlined),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.settings_outlined),
          ],
        )
      ]),
    );
  }
}
