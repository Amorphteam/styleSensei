import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';

import '../home_tab/cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> splashPages = [
    SplashPageWithPattern(
        Colors.white, "assets/images/splash0.png", "Never stop looking for "),
    SplashPage(
        Colors.white,
        "assets/images/splash1.png",
        "Getting to know you",
        "This journey is all about YOU. in this Process we will determineyour fashion goals by learning about you.",
        false),
    SplashPage(
        Colors.white,
        "assets/images/splash2.png",
        "Discover your personal style",
        "We can help you develop your personal look, infuse your closet with pieces that feel like YOU and help finding the perfect Outfits for various occasions, daily wear, or special work presentations.",
        true),
    LoadingPage(Colors.white, "assets/images/loading.png",
        "We are tailoring your space to YOUR style"),
    ErrorPage(Colors.white, "assets/images/error.png", "Internal Server Error",
        "Oops! Something went wrong on our end."),
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
                  color: Colors.grey,
                  // Color of inactive dots
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

  SplashPage(this.backgroundColor, this.imagePath, this.title, this.des,
      this.isTheLastSplash);

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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: des.substring(0, des.indexOf("YOU")),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "YOU",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: des.substring(des.indexOf("YOU") + 3),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
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
                final homeCubit =
                    HomeCubit(); // Create an instance of HomeCubit
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
                padding: EdgeInsets.symmetric(horizontal: 40),
                // Adjust the padding as needed
                child: Text(
                  "ــــ",
                  style: TextStyle(color: Colors.black12),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  // Adjust the padding as needed
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'I',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'nspiration',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
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

class LoadingPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;

  LoadingPage(this.backgroundColor, this.imagePath, this.title);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: backgroundColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/json/loading.json'),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: title.substring(0, title.indexOf("YOUR")),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: "YOUR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: title.substring(title.indexOf("YOUR") + 4),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(imagePath),
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 40,
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset("assets/images/arrow_left.svg"),
          ),
        ),
      ],
    );
  }
}

class ErrorPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String des;

  ErrorPage(this.backgroundColor, this.imagePath, this.title, this.des);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Image.asset(imagePath, width: 200, height: 200),
                ),
                Positioned(
                  top: 100,
                  right: 20,
                  child: Container(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          des,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: TextButton(
              onPressed: () {
                // Add your action or function to be executed when the button is pressed here
              },
              child: Text(
                'Refresh',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  // Add other text styling properties if needed
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
