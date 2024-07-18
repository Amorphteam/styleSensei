import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../utils/AppLocalizations.dart';
import '../splash/splash_simple.dart';

class SplashWithVideo extends StatefulWidget {
  final String? title;
  final bool isFromSettings;

  const SplashWithVideo({super.key, this.title, required this.isFromSettings});

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
              right: 160, // Add some padding from the bottom
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
              left: 30,
              right: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      padding: EdgeInsets.all(12.0), // Adjust vertical padding as needed
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedLocale', 'en');
                      Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('en'));
                      if (widget.isFromSettings) {
                        Navigator.pop(context);
                        return;
                      }
                      await openSplash(context);
                    },

                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                        mainAxisSize: MainAxisSize.max, // Max width within the parent
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('get_started_english'),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      padding: EdgeInsets.all(12.0), // Adjust vertical padding as needed
                    ),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedLocale', 'ar');
                      Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('ar'));
                      if (widget.isFromSettings) {
                        Navigator.pop(context);
                        return;
                      }
                      await openSplash(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                        mainAxisSize: MainAxisSize.max, // Max width within the parent
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('get_started_arabic'),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> openSplash(BuildContext context) async {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SplashSimple(imagePath: 'assets/images/splash1.jpg'),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
