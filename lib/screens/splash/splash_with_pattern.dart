import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                            color: Theme.of(context).primaryColor,
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
