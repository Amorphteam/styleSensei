import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_sensei/screens/style/style_screen.dart';
import 'package:style_sensei/screens/waiting/waiting_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

import '../body/body_screen.dart';
import '../color_tones/color_tones_screen.dart';

class SplashSimple extends StatelessWidget {
  final String imagePath;

  SplashSimple({required this.imagePath});

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
                AppLocalizations.of(context).translate('splash_title'),
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
                    foregroundColor: Colors.white, backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  onPressed: () {
                    openBodyTypeScreen(context);
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

  Future<void> openBodyTypeScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodyTypeSelectionScreen(),
      ),
    );
  }
}
