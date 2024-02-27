//chained animation with clippath,customclipper
import 'package:flutter/material.dart';

enum CircleSide { left, right }

class RotationClipPath extends StatefulWidget {
  const RotationClipPath({super.key});

  @override
  State<RotationClipPath> createState() => _RotationClipPathState();
}

class _RotationClipPathState extends State<RotationClipPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipPath(
            clipper: HalfCircleClipper(side: CircleSide.left),
            child: Container(
              height: 200,
              width: 150,
              color: Colors.blue,
            ),
          ),
          ClipPath(
            clipper: HalfCircleClipper(side: CircleSide.right),
            child: Container(
              height: 200,
              width: 150,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    ));
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCircleClipper({super.reclip, required this.side});

  @override
  Path getClip(Size size) => side.getHalfCircle(size);

  //to reclip the path whenever the widget is rebuilt or something changes
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension CircleClipper on CircleSide {
  Path getHalfCircle(Size size) {
    final Path path = Path();
    late bool clockwise;
    late Offset offset;
    switch (this) {
      case CircleSide.left:
        //as we know the origin of the path is at top left, so for left circle
        // we need to move to top right
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      // radius: Radius.circular(size.width / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}
