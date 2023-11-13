import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/detail_screen/detail_screen.dart';
import 'package:style_sensei/screens/home_tab/widgets/image_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Collections.dart';
import '../screens/style/style_screen.dart';

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
    required this.collections,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);
  final List<Collections> collections;
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
        // _showLongPressDialog(context, widget.index);
      },
      onTap: () {
        if (!isLongPressing) {
          // Handle normal tap here
          _showNormalPressDialog(context, widget.collections[widget.index].id);
        }
        setState(() {
          isLongPressing = false;
        });
      },
      child:
      CachedNetworkImage(
        imageUrl: widget.collections[widget.index].image,
        width: widget.width.toDouble(),
        height: widget.height.toDouble(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Light grey color for the base
          highlightColor: Colors.grey[100]!, // Lighter grey color for the highlight
          child: Container(
            width: widget.width.toDouble(),
            height: widget.height.toDouble(),
            color: Colors.white,
          ),
        ),        errorWidget: (context, url, error) {
          print(error); // This will print the error to the console
          return Icon(Icons.error);
        },
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
    // Navigate to the Detail Screen with BlocProvider
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => DetailCubit(),
          child: Detail(index: index),
        ),
      ),
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
List<ImageItem> images = [
  ImageItem('assets/images/classic1.jpeg', 405, 'Classic: Elegant, structured, neutral.'),
  ImageItem('assets/images/classic2.jpeg', 405, 'Classic: Elegant, structured, neutral.'),
  ImageItem('assets/images/classic3.jpeg', 405, 'Classic: Elegant, structured, neutral.'),
  ImageItem('assets/images/classic4.jpeg', 405, 'Classic: Elegant, structured, neutral.'),
  ImageItem('assets/images/casual1.jpeg', 411, 'Casual: Relaxed, easy, simple.'),
  ImageItem('assets/images/casual2.jpeg', 411, 'Casual: Relaxed, easy, simple.'),
  ImageItem('assets/images/casual3.jpeg', 411, 'Casual: Relaxed, easy, simple.'),
  ImageItem('assets/images/casual4.jpeg', 411, 'Casual: Relaxed, easy, simple.'),
  ImageItem('assets/images/bohemian1.jpeg', 404, 'Bohemian (Boho): Artistic, textured, earthy.'),
  ImageItem('assets/images/bohemian2.jpeg', 404, 'Bohemian (Boho): Artistic, textured, earthy.'),
  ImageItem('assets/images/bohemian3.jpeg', 404, 'Bohemian (Boho): Artistic, textured, earthy.'),
  ImageItem('assets/images/bohemian4.jpeg', 404, 'Bohemian (Boho): Artistic, textured, earthy.'),
  ImageItem('assets/images/rock1.jpeg', 406, 'Rock: Bold, edgy, leather.'),
  ImageItem('assets/images/rock2.jpeg', 406, 'Rock: Bold, edgy, leather.'),
  ImageItem('assets/images/rock3.jpeg', 406, 'Rock: Bold, edgy, leather.'),
  ImageItem('assets/images/rock4.jpeg', 406, 'Rock: Bold, edgy, leather.'),
  ImageItem('assets/images/eclectic1.jpeg', 408, 'Eclectic: Diverse, mixed, unique.'),
  ImageItem('assets/images/eclectic2.jpeg', 408, 'Eclectic: Diverse, mixed, unique.'),
  ImageItem('assets/images/eclectic3.jpeg', 408, 'Eclectic: Diverse, mixed, unique.'),
  ImageItem('assets/images/eclectic4.jpeg', 408, 'Eclectic: Diverse, mixed, unique.'),
  ImageItem('assets/images/feminine1.jpeg', 402, 'Feminine: Soft, ruffled, flowing.'),
  ImageItem('assets/images/feminine2.jpeg', 402, 'Feminine: Soft, ruffled, flowing.'),
  ImageItem('assets/images/feminine3.jpeg', 402, 'Feminine: Soft, ruffled, flowing.'),
  ImageItem('assets/images/feminine4.jpeg', 402, 'Feminine: Soft, ruffled, flowing.'),
  ImageItem('assets/images/minimal1.jpeg', 401, 'Minimal: Sleek, simple, monochromatic.'),
  ImageItem('assets/images/minimal2.jpeg', 401, 'Minimal: Sleek, simple, monochromatic.'),
  ImageItem('assets/images/minimal3.jpeg', 401, 'Minimal: Sleek, simple, monochromatic.'),
  ImageItem('assets/images/minimal4.jpeg', 401, 'Minimal: Sleek, simple, monochromatic.'),
  ImageItem('assets/images/tomboy1.jpeg', 409, 'Tomboy: Masculine, practical, denim.'),
  ImageItem('assets/images/tomboy2.jpeg', 409, 'Tomboy: Masculine, practical, denim.'),
  ImageItem('assets/images/tomboy3.jpeg', 409, 'Tomboy: Masculine, practical, denim.'),
  ImageItem('assets/images/tomboy4.jpeg', 409, 'Tomboy: Masculine, practical, denim.'),
  ImageItem('assets/images/vintage1.jpeg', 414, 'Vintage: Retro, classic, timeless.'),
  ImageItem('assets/images/vintage2.jpeg', 414, 'Vintage: Retro, classic, timeless.'),
  ImageItem('assets/images/vintage3.jpeg', 414, 'Vintage: Retro, classic, timeless.'),
  ImageItem('assets/images/vintage4.jpeg', 414, 'Vintage: Retro, classic, timeless.'),
];

Future<Map<String, bool>> loadBookmarkedItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, bool> bookmarkedItems = {};
  List<String>? bookmarkedItemIds = prefs.getStringList('bookmarkedItemIds');
  if (bookmarkedItemIds != null) {
    bookmarkedItemIds.forEach((itemId) {
      bookmarkedItems[itemId] = true;
    });
  }
  return bookmarkedItems;
}

// Function to save bookmarked item IDs to SharedPreferences
Future<void> saveBookmarkedItems(Map<String, bool> bookmarkedItems) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> bookmarkedItemIds = bookmarkedItems.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();
  await prefs.setStringList('bookmarkedItemIds', bookmarkedItemIds);
}