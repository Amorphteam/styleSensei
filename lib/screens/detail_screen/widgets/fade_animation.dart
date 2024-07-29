import 'package:flutter/material.dart';

class FadeFromTopAnimation extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  const FadeFromTopAnimation({
    Key? key,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  @override
  _FadeFromTopAnimationState createState() => _FadeFromTopAnimationState();
}

class _FadeFromTopAnimationState extends State<FadeFromTopAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(_fadeAnimation.value),
                Colors.black.withOpacity(_fadeAnimation.value),
                Colors.black.withOpacity(_fadeAnimation.value),
                Colors.black.withOpacity(_fadeAnimation.value),
              ],
              stops: [0.0, 0.0, 1.0, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        );
      },
    );
  }
}
