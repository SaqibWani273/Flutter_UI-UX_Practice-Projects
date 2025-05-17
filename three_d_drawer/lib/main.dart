import 'dart:math' as math;

import 'package:flutter/material.dart';

//to set the max slide value
final double maxSlide = 300.0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
                fontFamily:  "PlaywriteAUSA-Regular",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/* Main widgets used to create the 3d effect in the app
1. AnimatedBuilder
2. GestureDetector
3. Transform.translate
4. Stack
*/
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  bool _canBeDragged = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
 void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();
  void _onDragStart(DragStartDetails details) {
    //Returns true if the animation
    // is at the start position (e.g., a drawer is closed).
    bool isDragOpenFromLeft = animationController.isDismissed;
    //Returns true if the animation
    // is at the end position (e.g., a drawer is fully open).
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
      print(animationController.value);
    }
  }

//did not understand the logic
  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('3D Effect'),
        // ),
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            behavior: HitTestBehavior.translucent,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Material(
                  color: Colors.blueGrey,
                  child: Stack(children: [
                    //drawer widget
                    Transform.translate(
                      /*  initially the drawer is hiden at the left side due to
                        dx = -maxSlide= -300

                        when the animation is completed the dx=0
                        again when the animation is reversed the dx=-300
                        for forward animation, animationController.value increases from 0 to 1
                        for reverse animation, animationController.value decreases from 1 to 0
                        */
                      offset:
                          Offset((animationController.value - 1) * maxSlide, 0),
                      child: Transform(
                        //together rotation & perspective effect makes it appear
                        //as if the drawer is sliding from left to right like a book page
                        transform: Matrix4.identity()
                          /*Mr. ChatGPT->  The perspective transformation is what 
                        makes the rotation look more realistic (adding depth) rather than flat.
                        Matrix4.setEntry(row, column, value) modifies a specific entry in the transformation matrix.
                        setEntry(3, 2, value) adjusts the perspective effect:
                        3: Refers to the 4th row of the matrix.
                        2: Refers to the 3rd column of the matrix.
                        value (0.001): Determines the strength of the perspective effect.
                        Smaller values (e.g., 0.001): Stronger depth effect, more dramatic perspective.
                        Larger values (e.g., 0.01 or higher): Weaker perspective effect, less depth.

                        */
                          ..setEntry(3, 2, 0.001) //perspective effect
                          /*
                        This is the rotation logic that creates the opening/closing effect.
                        */
                          ..rotateY(
                              math.pi / 2 * (1 - animationController.value)),
                        alignment: Alignment.centerRight,
                        child: DrawerPage(),
                      ),
                      // DrawerPage()
                    ),
                    //main widget
                    Transform.translate(
                        offset:
                            Offset((animationController.value) * maxSlide, 0),
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(-math.pi * animationController.value / 2),
                          alignment: Alignment.centerLeft,
                          child: MainPage(),
                        )),
                          Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: toggle,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value *
                      MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Hello Flutter Europe',
                    // style: Theme.of(context).primaryTextTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                  ]),
                );
              },
            ),
          ),
        ),
      );
    
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       
      body:  SizedBox(

      width: double.infinity,
      height: double.infinity,
      child:
      
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Image.asset('assets/car.png'),
       SizedBox(height: 50,),
        Container(
          child: Text("Mohammad Saqib Wani",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),),),

        ],
      )
      
      ),
    );
  }
}

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxSlide,
      // width: double.infinity,
      height: double.infinity,
      child: Material(
        color: Colors.blue,
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [


                ListTile(
                  // leading: Icon(),
                  title: Text('Saqib Wani'),
                ),


                Image.asset(
                  'assets/car.png',
                  width: 200,
                ),
                ListTile(
                  leading: Icon(Icons.new_releases),
                  title: Text('News'),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Favourites'),
                ),
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Map'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
