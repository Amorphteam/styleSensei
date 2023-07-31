import 'package:flutter/material.dart';

import 'screens/widget/image_card.dart';

const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isLongPressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isLongPressing = true;
        });
        _showLongPressDialog(context, widget.index);
      },
      onTap: () {
        if (!isLongPressing) {
          // Handle normal tap here
          _showNormalPressDialog(context, widget.index);
        }
        setState(() {
          isLongPressing = false;
        });
      },
      child: Image.asset(
        'assets/images/${widget.index}.png',
        width: widget.width.toDouble(),
        height: widget.height.toDouble(),
        fit: BoxFit.cover,
      ),
    );
  }

  // Function to show a dialog for long press (you can customize this as needed)
  void _showLongPressDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder( // Set the shape with radius 0
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          child: FractionallySizedBox(
            widthFactor: 1.2,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView( // Use SingleChildScrollView to allow the AlertDialog to wrap its height
                child: ImageCard(
                  imagePath: 'assets/images/$index.png',
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  // Function to show a dialog for normal press (you can customize this as needed)
  void _showNormalPressDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Special message'),
          content: Text('You tapped image at index $index, So after some hardwork I will show you that, dont worry MEHDI BAHADORI'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}