import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';

class WaitingScreen extends StatefulWidget {
  final List<int> collectionTags;


  WaitingScreen({required this.collectionTags});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {

  VideoPlayerController? _controller;
  String? _error;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/waiting.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
          _controller!.setLooping(true);
        });
      }).catchError((error) {
        setState(() {
          _error = error.toString();
        });
      });

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
    if (_error != null) {
      return Scaffold(body: Center(child: Text('Error: $_error')));
    }
    return Scaffold(
      body: Center(
        child: _controller != null && _controller!.value.isInitialized
            ? Stack(
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.size.width ?? 0,
                  height: _controller!.value.size.height ?? 0,
                  child: VideoPlayer(_controller!), // Video player widget
                ),
              ),
            ),
            Positioned(
              left: 20, // Add some padding from the left
              bottom: 40,
              right: 160,// Add some padding from the bottom
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 34, // Text size
                  fontWeight: FontWeight.bold, // Text weight
                ),
              ),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );

  }
}
