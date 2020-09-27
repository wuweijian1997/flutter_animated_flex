import 'package:animated_flex/animated_flex.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> list = [Demo1(), Demo2(), Demo3(), Demo4()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Animated flex'),
          bottom: TabBar(
            tabs: [
              const Text('Demo1'),
              const Text('Demo2'),
              const Text('Demo3'),
              const Text('Demo4'),
            ],
          ),
        ),
        body: TabBarView(
          children: [for (Widget widget in list) widget],
        ),
      ),
    );
  }
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: AnimatedFlex(
          children: [
            Container(
              color: Colors.red,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.green,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.blue,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: AnimatedFlex(
          animationWidgetBuilder: (Animation animation, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: Transform(
                transform: Matrix4.translationValues(
                    20 * (1.0 - animation.value),
                    20 * (1.0 - animation.value),
                    0.0),
                child: child,
              ),
            );
          },
          children: [
            Container(
              color: Colors.red,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.green,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.blue,
              height: 200,
              margin: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Demo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: AnimatedFlex(
                animationWidgetBuilder: (Animation animation, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          20 * (1.0 - animation.value), 0, 0.0),
                      child: child,
                    ),
                  );
                },
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    color: Colors.green,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    color: Colors.blue,
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: AnimatedFlex(
                delayed: Duration(milliseconds: 1000),
                animationWidgetBuilder: (Animation animation, Widget child) {
                  return Opacity(
                    opacity: animation.value,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          20 * (1.0 - animation.value),
                          20 * (1.0 - animation.value),
                          0.0),
                      child: child,
                    ),
                  );
                },
                children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    color: Colors.green,
                    height: 100,
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      // height: 100,
                      margin: EdgeInsets.only(top: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Demo4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: AnimatedFlex(
          animationWidgetBuilder: (Animation animation, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.scale(
                  scale: 0.8 + animation.value * .2,
                  child: child),
            );
          },
          children: [
            Container(
              color: Colors.red,
              height: 150,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.green,
              height: 150,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              color: Colors.blue,
              height: 150,
              margin: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}
