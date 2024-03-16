import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final String des;

  SplashPage(this.backgroundColor, this.imagePath, this.title, this.des);

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
      ],
    );
  }
}
