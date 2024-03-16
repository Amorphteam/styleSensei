import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashWithVideo extends StatefulWidget {
  final String title;

  const SplashWithVideo({super.key, required this.title});

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
                widget.title,
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
