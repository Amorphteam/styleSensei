import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            child: Column(
              children: [
                Gap(MediaQuery.of(context).size.height/3),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4, top: 20.0, bottom: 20.0, right: 10),
                    child: Text(
                      AppLocalizations.of(context).translate('splash_title2'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Gap(70),
                Container(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/3, left: MediaQuery.of(context).size.width/6),
                  child: Text(
                    AppLocalizations.of(context).translate('splash_title'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  onPressed: () {
                    openBodyTypeScreen(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('next'),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
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
