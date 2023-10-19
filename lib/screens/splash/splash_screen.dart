import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';

import '../home_tab/cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> splashPages = [
    SplashPageWithPattern(Colors.white, "assets/images/splash0.png", "Never stop looking for Inspiration"),
    SplashPage(Colors.white, "assets/images/splash1.png", "Getting to know you", "We can help you develop your personal look, infuse your closet with pieces that feel like YOU and help finding the perfect Outfits for various occasions, daily wear, or special work presentations.", false),
    SplashPage(Colors.white, "assets/images/splash2.png", "Discover your personal style", "We can help you develop your personal look, infuse your closet with pieces that feel like YOU and help finding the perfect Outfits for various occasions, daily wear, or special work presentations.", true),
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
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String des;
  final bool isTheLastSplash;

  SplashPage(this.backgroundColor, this.imagePath, this.title, this.des, this.isTheLastSplash);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Expanded(
                  child: Image.asset(imagePath),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "ــــ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black12,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    des,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
        if (isTheLastSplash)
          Positioned(
            bottom: 20,
            right: 40,
            child: GestureDetector(
              onTap: () {
                final homeCubit = HomeCubit(); // Create an instance of HomeCubit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => homeCubit,
                      child: MyHomePage(),
                    ),
                  ),
                );
              },
              child: SvgPicture.asset("assets/images/arrow_right.svg"),
            ),
          ),
      ],
    );
  }
}
class SplashPageWithPattern extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  SplashPageWithPattern(this.backgroundColor, this.imagePath, this.title);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background with a pattern image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.cover, // You can adjust the fit as needed
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset(
                "assets/logo/logo.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40), // Adjust the padding as needed
                child: Text(
                  "ــــ",
                  style: TextStyle(
                    color: Colors.black12
                  ),
                ),
              ),
              SizedBox(height: 20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40), // Adjust the padding as needed
                child: Text(
                 title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}





