import 'package:flutter/material.dart';

class SplashSample extends StatelessWidget {
  final String imagePath;
  final String title;

  SplashSample({required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 55, bottom: 100),
              width: MediaQuery.of(context).size.width / 1.6, // Width is half of the screen
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
