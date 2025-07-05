import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  FadeInAnimation({
    required this.child,
    this.curve = Curves.easeIn,
    this.duration = const Duration(seconds: 1),
  });
  @override
  _FadeInExampleState createState() => _FadeInExampleState();
}

class _FadeInExampleState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);

    _controller.forward(); // Start the animation

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fadeAnimation, child: widget.child);
  }
}

class BouncInAnimation extends StatefulWidget {
  final Widget? child;

  const BouncInAnimation({super.key, required this.child});

  @override
  _BouncingIconState createState() => _BouncingIconState();
}

class _BouncingIconState extends State<BouncInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..repeat(reverse: true); // Repeats back and forth

    _animation = Tween<double>(
      begin: 0.0,
      end: -10.0,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class BounceInFromBottom extends StatefulWidget {
  final Widget child;

  const BounceInFromBottom({super.key, required this.child});

  @override
  _BounceInFromBottomState createState() => _BounceInFromBottomState();
}

class _BounceInFromBottomState extends State<BounceInFromBottom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the screen
      end: Offset.zero, // Final position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut, // Gives the "pop-up with bounce" effect
      ),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}

class SlideFromRight extends StatefulWidget {
  final Widget child;

  const SlideFromRight({super.key, required this.child});

  @override
  _SlideFromRightState createState() => _SlideFromRightState();
}

class _SlideFromRightState extends State<SlideFromRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0), // Start off-screen on the right
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(); // Trigger the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}
