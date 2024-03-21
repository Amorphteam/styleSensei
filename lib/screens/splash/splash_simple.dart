import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

import '../body/body_screen.dart';

class SplashSimple extends StatelessWidget {
  final String imagePath;
  final String title;

  SplashSimple({required this.imagePath, required this.title});

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
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.6, // Width is half of the screen
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
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    openStyleScreen(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child:  Center(
                      child: Text(
                        AppLocalizations.of(context).translate('get_started'),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                ),
              )

          )

        ],
      ),
    );
  }

  void openStyleScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyTypeSelectionScreen(),
      ),
    );
  }
}
