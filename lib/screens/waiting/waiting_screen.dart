import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';

import '../../main.dart';

class WaitingScreen extends StatefulWidget {
  final List<int> collectionTags;


  WaitingScreen({required this.collectionTags});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Future.delayed(Duration(seconds: 2), () {
      final homeCubit = HomeCubit(); // Create an instance of HomeCubit

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
            opacity: animation,
            child: BlocProvider(
              create: (context) => homeCubit,
              child: MyHomePage(collectionTags: widget.collectionTags),
            ),
          ),
          transitionDuration: Duration(milliseconds: 1000), // Transition duration
        ),
            (Route<dynamic> route) => false, // No route will allow return
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    String title = 'We are tailoring your space to YOUR style';
    String path = 'assets/images/loading.png';
    return Stack(
      children: [
        Container(
          color: Colors.white,
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
                child: Image.asset(path),
              ),
              SizedBox(width: 30),
            ],
          ),
        ),

      ],
    );
  }
}
