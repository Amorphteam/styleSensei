import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SplashPage(Colors.white, "assets/images/splash1.png", "This journey is all about YOU. in this Process we will determine your fashion goals by learning about you."),
          SplashPage(Colors.white, "assets/images/splash2.png", "We can help you develop your personal look, infuse your closet with pieces that feel like YOU and help finding the perfect Outfits for various occasions, daily wear, or special work presentations."),
          SplashPage(Colors.red, "assets/images/2.png", "Welcome to Page 3"),
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String text;

  SplashPage(this.backgroundColor, this.imagePath, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 480, // Adjust the width as needed
              height: 480, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40), // Adjust the padding as needed
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





