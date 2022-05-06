import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math' as math;

import 'localization/app_localizations.dart';
import 'screen/home_screen/home_screen.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [Locale('vi', 'VN'), Locale('en', 'US')],
      home: const HomeScreen(),
    );
  }
}

class AnimateOnScrollFlutter extends StatefulWidget {
  @override
  _AnimateOnScrollFlutterState createState() => _AnimateOnScrollFlutterState();
}

class _AnimateOnScrollFlutterState extends State<AnimateOnScrollFlutter> {
  final controller = ScrollController();
  double appBarHeight = 500.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: appBarHeight,
            floating: true,
            // collapsedHeight: 500,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double percent = ((constraints.maxHeight - kToolbarHeight) *
                    100 /
                    (appBarHeight - kToolbarHeight));
                return Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/head-background.jpg",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),

//                    Custom Paint
                    Container(
                      height: kToolbarHeight,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomPaint(
                                size: Size.fromHeight(kToolbarHeight),
                                painter: CirclePainter(100 - percent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

//                    Text and Icon
                    Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Container(
                        height: kToolbarHeight,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Flutter is Awesome ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.animateTo(-appBarHeight,
                                    duration: Duration(seconds: 4),
                                    curve: Curves.fastOutSlowIn);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverList(delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(title: Text("Flutter / $index"));
          }))
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  double overallPercent;

  CirclePainter(this.overallPercent);

  @override
  void paint(Canvas canvas, Size size) {
    double circleSize = 25.0;
    double angle = math.pi / 180.0 * ((overallPercent * 360 / 100));
    double line = overallPercent * (size.width - circleSize) / 100;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final path = Path();
    if (overallPercent < 50) {
      path.addPolygon([
        Offset(0.0, size.height),
        Offset((line * 2), size.height),
      ], false);
    }
    if (overallPercent > 50) {
      path.arcTo(
          Rect.fromLTWH(
              size.width - (circleSize * 2), 0.0, circleSize * 2, size.height),
          math.pi / 2,
          -angle * 2,
          false);
      if (overallPercent < 100) {
        path.addPolygon([
          Offset(overallPercent * (size.width - circleSize) / 100, size.height),
          Offset(size.width - circleSize, size.height),
        ], false);
      }
      if (overallPercent == 100) {
        path.addArc(
            Rect.fromLTWH(size.width - (circleSize * 2), 0.0, circleSize * 2,
                size.height),
            math.pi / 2,
            math.pi * 2);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
