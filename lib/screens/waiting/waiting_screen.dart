import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../../utils/untitled.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen();

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  VideoPlayerController? _controller;
  String? _error;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _fetchAndNavigate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isControllerInitialized) {
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    String videoPath = (Theme.of(context).brightness == Brightness.dark)
        ? 'assets/video/waiting_dark.mp4'
        : 'assets/video/waiting.mp4';

    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {
          _isControllerInitialized = true;
          _controller!.play();
          _controller!.setLooping(true);
        });
      }).catchError((error) {
        setState(() {
          _error = error.toString();
        });
      });
  }

  void _fetchAndNavigate() async {
    Future.delayed(Duration(seconds: 2), () {
      final homeCubit = HomeCubit(); // Create an instance of HomeCubit

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
            opacity: animation,
            child: BlocProvider(
              create: (context) => homeCubit,
              child: MyHomePage(),
            ),
          ),
          transitionDuration: Duration(milliseconds: 1000),
        ),
            (Route<dynamic> route) => false,
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
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.size.width ?? 0,
                    height: _controller!.value.size.height ?? 0,
                    child: VideoPlayer(_controller!), // Video player widget
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40, // Add some padding from the left
              bottom: MediaQuery.of(context).size.height/4,
              right: 40,// Add some padding from the bottom
              child: Text(
                AppLocalizations.of(context).translate('loading_desc'), // 'Loading...
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Positioned(
              left: 40, // Add some padding from the left
              top: MediaQuery.of(context).size.height/4,
              right: 40,// Add some padding from the bottom

              child: Text(
                AppLocalizations.of(context)!.translate('loading_title'), // 'Loading...
                //add alpha or opacity to the color
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
