import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    color: Theme.of(context).primaryColor,
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
