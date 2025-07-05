import 'package:flutter/material.dart';

enum TransitionType {
  slideup,
  slideFromLeft,
  slidedown,
  slideFromRight,
  fade,
  scale,
}

Animation<Offset> getSlidePosition(
  Animation<double> animation,
  TransitionType transitionType,
) {
  switch (transitionType) {
    case TransitionType.slideup:
      return Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation);
    case TransitionType.slideFromLeft:
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);
    case TransitionType.slidedown:
      return Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation);
    case TransitionType.slideFromRight:
      return Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

    default:
      return Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation);
  }
}

class TransitionNavigation {
  static push({
    required BuildContext context,
    required Widget page,

    TransitionType transitionType = TransitionType.slideup,
    Curve curve = Curves.ease,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
                transitionType == TransitionType.fade
                    ? FadeTransition(
                      opacity: CurvedAnimation(parent: animation, curve: curve),
                      child: child,
                    )
                    : SlideTransition(
                      position: getSlidePosition(animation, transitionType),
                      child: child,
                    ),
        transitionDuration: duration1,
      ),
    );
  }
}

Duration duration1 = const Duration(milliseconds: 500);
Duration duration2 = const Duration(milliseconds: 800);
Duration duration3 = const Duration(milliseconds: 1000);
