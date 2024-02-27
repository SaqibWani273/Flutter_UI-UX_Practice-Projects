//use of transform with animatedbuilder

import 'package:flutter/material.dart';

import 'dart:math' show pi;

class TransformContainer extends StatefulWidget {
  const TransformContainer({super.key, required this.title});

  final String title;

  @override
  State<TransformContainer> createState() => _TransformContainerState();
}

class _TransformContainerState extends State<TransformContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final identitityMatrix = Matrix4.identity();
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Durations.extralong4 +
          Durations.extralong3, // 1 second or 1000 milliseconds
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()..rotateZ(_animation.value),
                    alignment: Alignment
                        .center, //it is like where to hold the child for rotation
                    //    origin: Offset(50, 50),//used to manually and more precisely place the pivot point
                    //instead we are using alignment here
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                            20), //fun fact: if we set width to 100
                        //height to 100 and radius to 50 then it will be a circle & animation
                        //won't be visible
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _controller.repeat(),
                  child: Text("start"),
                ),
                TextButton(
                  onPressed: () => _controller.stop(),
                  child: Text("stop"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
