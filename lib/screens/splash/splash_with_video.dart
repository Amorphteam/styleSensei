import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sensei/screens/splash/splash_screen.dart';
import 'package:style_sensei/screens/splash/splash_simple.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:video_player/video_player.dart';

import '../../utils/user_controller.dart';

class SplashWithVideo extends StatefulWidget {
  final String? title;

  const SplashWithVideo({super.key, this.title});

  @override
  _SplashWithVideoState createState() => _SplashWithVideoState();
}

class _SplashWithVideoState extends State<SplashWithVideo> {
  VideoPlayerController? _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/splash1.mp4')
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
                  width: _controller!.value.size?.width ?? 0,
                  height: _controller!.value.size?.height ?? 0,
                  child: VideoPlayer(_controller!), // Video player widget
                ),
              ),
            ),
            Positioned(
              left: 20, // Add some padding from the left
              bottom: 40,
              right: 160,// Add some padding from the bottom
              child: Text(
                widget.title ?? '',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 34, // Text size
                  fontWeight: FontWeight.bold, // Text weight
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
                    padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust vertical padding as needed
                  ),
                  onPressed: () async {
                    await loginWithGoogle(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                      mainAxisSize: MainAxisSize.max, // Max width within the parent
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/google.svg', // Replace with your asset image path
                          height: 20.0,
                        ),
                        SizedBox(width: 8), // You can adjust spacing as needed
                        Text(
                          AppLocalizations.of(context).translate('google_login'),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final user = await UserController.loginWithGoogle();
      if (user != null && mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SplashSimple(imagePath: "assets/images/splash1.jpg"),
        ));
      }

    } on FirebaseAuthException catch (error){
      debugPrint(error.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? "Something went wrong",)));
    } catch (error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString(),)));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
