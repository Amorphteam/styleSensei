import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/screens/body/body_screen.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';
import 'package:style_sensei/screens/splash/splash_simple.dart';
import 'package:style_sensei/screens/splash/splash_with_pattern.dart';
import 'package:style_sensei/screens/splash/splash_with_video.dart';
import 'package:style_sensei/screens/style/cubit/style_cubit.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

import '../home_tab/cubit/home_cubit.dart';
import '../style/style_screen.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> splashPages = [
    SplashWithVideo(),

    SplashSimple(imagePath: "assets/images/splash1.jpg"),
    BodyTypeSelectionScreen(),

  ];

  double pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index.toDouble();
              });
            },
            children: splashPages,
          ),
          Positioned(
            bottom: 20, // Adjust the position as needed
            left: 0,
            right: 0,
            child: Center(
              child: DotsIndicator(
                dotsCount: splashPages.length,
                position: pageIndex.toInt(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  color: Colors.grey, // Color of inactive dots
                  activeSize: const Size(9.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  activeColor: Colors.black, // Color of the active dot
                ),
              ),
            ),
          ),
          // "Prev" Button
          if (pageIndex > 0)
            Positioned(
              bottom: 30, // Adjust the position as needed
              left: 40,
              child: InkWell(
                onTap: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Text(
                  'Prev',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  Colors.grey, // Lighter color if no previous page
                  ),
                ),
              ),
            ),
          // "Next" Button
          Positioned(
            bottom: 30, // Adjust the position as needed
            right: 40,
            child: InkWell(
              onTap: () {
                if (pageIndex < splashPages.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );

                }else {
                  final imageSelectionCubit =
                  ImageSelectionCubit(); // Create an instance of HomeCubit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => imageSelectionCubit,
                        child: StyleScreen(),
                      ),
                    ),
                  );

                }
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );  }
}







