import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/detail_screen/detail_screen.dart';
import 'package:style_sensei/screens/home_tab/widgets/image_card.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
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
  final List<Collections> collections;
  final int index;
  final bool hasSeeDetail;

  const ImageTile({
    Key? key,
    required this.collections,
    required this.index,
    required this.hasSeeDetail,
  }) : super(key: key);

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
          _showNormalPressDialog(context, widget.collections[widget.index]);
        }
        setState(() {
          isLongPressing = false;
        });
      },
      child: CachedNetworkImage(
        imageUrl: replaceNumbersInUrl(widget.collections[widget.index].image),
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          // Light grey color for the base
          highlightColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          // Lighter grey color for the highlight
          child: Container(
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) {
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
              shape: RoundedRectangleBorder(
                // Set the shape with radius 0
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          child: FractionallySizedBox(
            widthFactor: 1.2,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                // Use SingleChildScrollView to allow the AlertDialog to wrap its height
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
  void _showNormalPressDialog(BuildContext context, Collections collection) {
    // Navigate to the Detail Screen with BlocProvider
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => DetailCubit(),
          child: Detail(
            collection: collection,
          ),
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
  ImageItem('assets/images/classic1.jpeg', 405,
      'Classic: Elegant, structured, neutral.', ''),
  ImageItem('assets/images/classic2.jpeg', 405,
      'Classic: Elegant, structured, neutral.', ''),
  ImageItem('assets/images/classic3.jpeg', 405,
      'Classic: Elegant, structured, neutral.', ''),
  ImageItem('assets/images/classic4.jpeg', 405,
      'Classic: Elegant, structured, neutral.', ''),
  ImageItem(
      'assets/images/casual1.jpeg', 411, 'Casual: Relaxed, easy, simple.', ''),
  ImageItem(
      'assets/images/casual2.jpeg', 411, 'Casual: Relaxed, easy, simple.', ''),
  ImageItem(
      'assets/images/casual3.jpeg', 411, 'Casual: Relaxed, easy, simple.', ''),
  ImageItem(
      'assets/images/casual4.jpeg', 411, 'Casual: Relaxed, easy, simple.', ''),
  ImageItem('assets/images/bohemian1.jpeg', 404,
      'Bohemian (Boho): Artistic, textured, earthy.', ''),
  ImageItem('assets/images/bohemian2.jpeg', 404,
      'Bohemian (Boho): Artistic, textured, earthy.', ''),
  ImageItem('assets/images/bohemian3.jpeg', 404,
      'Bohemian (Boho): Artistic, textured, earthy.', ''),
  ImageItem('assets/images/bohemian4.jpeg', 404,
      'Bohemian (Boho): Artistic, textured, earthy.', ''),
  ImageItem('assets/images/rock1.jpeg', 406, 'Rock: Bold, edgy, leather.', ''),
  ImageItem('assets/images/rock2.jpeg', 406, 'Rock: Bold, edgy, leather.', ''),
  ImageItem('assets/images/rock3.jpeg', 406, 'Rock: Bold, edgy, leather.', ''),
  ImageItem('assets/images/rock4.jpeg', 406, 'Rock: Bold, edgy, leather.', ''),
  ImageItem('assets/images/eclectic1.jpeg', 408,
      'Eclectic: Diverse, mixed, unique.', ''),
  ImageItem('assets/images/eclectic2.jpeg', 408,
      'Eclectic: Diverse, mixed, unique.', ''),
  ImageItem('assets/images/eclectic3.jpeg', 408,
      'Eclectic: Diverse, mixed, unique.', ''),
  ImageItem('assets/images/eclectic4.jpeg', 408,
      'Eclectic: Diverse, mixed, unique.', ''),
  ImageItem('assets/images/feminine1.jpeg', 402,
      'Feminine: Soft, ruffled, flowing.', ''),
  ImageItem('assets/images/feminine2.jpeg', 402,
      'Feminine: Soft, ruffled, flowing.', ''),
  ImageItem('assets/images/feminine3.jpeg', 402,
      'Feminine: Soft, ruffled, flowing.', ''),
  ImageItem('assets/images/feminine4.jpeg', 402,
      'Feminine: Soft, ruffled, flowing.', ''),
  ImageItem('assets/images/minimal1.jpeg', 401,
      'Minimal: Sleek, simple, monochromatic.', ''),
  ImageItem('assets/images/minimal2.jpeg', 401,
      'Minimal: Sleek, simple, monochromatic.', ''),
  ImageItem('assets/images/minimal3.jpeg', 401,
      'Minimal: Sleek, simple, monochromatic.', ''),
  ImageItem('assets/images/minimal4.jpeg', 401,
      'Minimal: Sleek, simple, monochromatic.', ''),
  ImageItem('assets/images/tomboy1.jpeg', 409,
      'Tomboy: Masculine, practical, denim.', ''),
  ImageItem('assets/images/tomboy2.jpeg', 409,
      'Tomboy: Masculine, practical, denim.', ''),
  ImageItem('assets/images/tomboy3.jpeg', 409,
      'Tomboy: Masculine, practical, denim.', ''),
  ImageItem('assets/images/tomboy4.jpeg', 409,
      'Tomboy: Masculine, practical, denim.', ''),
  ImageItem('assets/images/vintage1.jpeg', 414,
      'Vintage: Retro, classic, timeless.', ''),
  ImageItem('assets/images/vintage2.jpeg', 414,
      'Vintage: Retro, classic, timeless.', ''),
  ImageItem('assets/images/vintage3.jpeg', 414,
      'Vintage: Retro, classic, timeless.', ''),
  ImageItem('assets/images/vintage4.jpeg', 414,
      'Vintage: Retro, classic, timeless.', ''),
];

final List<ImageItem> bodyTypes = [
  ImageItem('assets/images/fit.jpg', 805, 'Fit', 'رشيق'),
  ImageItem('assets/images/plus_size.jpg', 804, 'Plus Size', 'مقاس كبير'),
  ImageItem('assets/images/expecting.jpg', 806, 'Expecting', 'حامل'),
  ImageItem('assets/images/curvy.jpg', 803, 'Curvy', 'ممتلئ'),
  ImageItem('assets/images/petite.jpg', 802, 'Petite', 'صغير الحجم'),
  ImageItem('assets/images/tall.jpg', 801, 'Tall', 'طويل'),
];

final List<ImageItem> colorTones = [
  ImageItem('assets/images/dark.jpg', 503, 'Dark', 'داكن'),
  ImageItem('assets/images/bright.jpg', 502, 'Bright', 'مشرق'),
  ImageItem('assets/images/pastel.jpg', 501, 'Pastel', 'باستيل'),
  ImageItem('assets/images/neutral.jpg', 504, 'Neutral', 'محايد'),
];

final List<ImageItem> occasionWear = [
  ImageItem('assets/images/dark.jpg', 205, 'Athleisure', 'رياضي'),
  ImageItem('assets/images/bright.jpg', 202, 'Formal Event', 'حدث رسمي'),
  ImageItem('assets/images/pastel.jpg', 206, 'Wedding', 'زفاف'),
  ImageItem('assets/images/neutral.jpg', 201, 'Evening Out', 'خروج مسائي'),
  ImageItem('assets/images/dark.jpg', 203, 'Holiday', 'عطلة'),
  ImageItem('assets/images/bright.jpg', 204, 'Weekend', 'عطلة نهاية الأسبوع'),
  ImageItem('assets/images/pastel.jpg', 103, 'Work Attire - Formal',
      'ملابس العمل - رسمي'),
  ImageItem('assets/images/neutral.jpg', 102, 'Work Attire - Smart casual',
      'ملابس العمل - كاجوال أنيق'),
  ImageItem('assets/images/neutral.jpg', 101, 'Work Attire - Casual',
      'ملابس العمل - كاجوال'),
];

final List<ImageItem> seasonalStyle = [
  ImageItem('assets/images/dark.jpg', 604, 'Fall', 'خريف'),
  ImageItem('assets/images/bright.jpg', 603, 'Spring', 'ربيع'),
  ImageItem('assets/images/pastel.jpg', 601, 'Summer', 'صيف'),
  ImageItem('assets/images/neutral.jpg', 602, 'Winter', 'شتاء'),
];

final List<ImageItem> clothingPreferences = [
  ImageItem('assets/images/dark.jpg', 701, 'Mostly dresses and skirts',
      'غالبًا فساتين وتنانير'),
  ImageItem('assets/images/bright.jpg', 702, 'Mostly jeans and pants',
      'غالبًا جينز وبنطلونات'),
];

final List<ImageItem> hijabPreferences = [
  ImageItem('assets/images/dark.jpg', 301, 'Hijab-friendly styles',
      'أنماط تناسب الحجاب'),
];

class ImageItem {
  final String path;
  final int tag;
  final String des;
  final String arDes;

  ImageItem(this.path, this.tag, this.des, this.arDes);
}

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

Future<void> saveSelections({
  List<int>? styleSelections,
  List<int>? bodyTypeSelections,
  List<int>? colorToneSelections,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Fetch and parse existing selections
  List<int> existingStyleSelections =
      _parseIdsFromString(prefs.getString('styleSelections'));
  List<int> existingBodyTypeSelections =
      _parseIdsFromString(prefs.getString('bodyTypeSelections'));
  List<int> existingColorToneSelections =
      _parseIdsFromString(prefs.getString('colorToneSelections'));

  // Merge existing with new and remove duplicates by converting to set and back to list
  List<int> updatedStyleSelections =
      {...existingStyleSelections, ...?styleSelections}.toList();
  List<int> updatedBodyTypeSelections =
      {...existingBodyTypeSelections, ...?bodyTypeSelections}.toList();
  List<int> updatedColorToneSelections =
      {...existingColorToneSelections, ...?colorToneSelections}.toList();

  // Save merged and deduplicated selections
  await prefs.setString('styleSelections', updatedStyleSelections.join(','));
  await prefs.setString(
      'bodyTypeSelections', updatedBodyTypeSelections.join(','));
  await prefs.setString(
      'colorToneSelections', updatedColorToneSelections.join(','));
}

Future<List<int>> getSelectedIds() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? styleSelectionsString = prefs.getString('styleSelections');
  String? bodyTypeSelectionsString = prefs.getString('bodyTypeSelections');
  String? colorToneSelectionsString = prefs.getString('colorToneSelections');

  List<int> styleSelections = _parseIdsFromString(styleSelectionsString);
  List<int> bodyTypeSelections = _parseIdsFromString(bodyTypeSelectionsString);
  List<int> colorToneSelections =
      _parseIdsFromString(colorToneSelectionsString);

  return [...styleSelections, ...bodyTypeSelections, ...colorToneSelections];
}

List<int> _parseIdsFromString(String? idsString) {
  if (idsString == null || idsString.isEmpty) {
    return [];
  }

  return idsString
      .split(',')
      .map((id) => int.tryParse(id))
      .where((id) => id != null)
      .cast<int>()
      .toList();
}

bool _isNumeric(String s) {
  return int.tryParse(s) != null;
}

class DislikeOverlay extends StatefulWidget {
  final Function(String option) onOptionSelected;
  final VoidCallback onCancel;

  const DislikeOverlay({
    Key? key,
    required this.onOptionSelected,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<DislikeOverlay> createState() => _DislikeOverlayState();
}

class _DislikeOverlayState extends State<DislikeOverlay> {
  String? selectedReason;
  bool dontAskAgain = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54, // Semi-transparent overlay color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context).translate('dislike_title'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: widget.onCancel,
                    child: Text(
                        AppLocalizations.of(context).translate('undo_bu'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  _optionTile(context,
                      AppLocalizations.of(context).translate('style_choice')),
                  _optionTile(context,
                      AppLocalizations.of(context).translate('color_choice')),
                  _optionTile(context,
                      AppLocalizations.of(context).translate('body_choice')),
                  // Add more options here if needed
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextButton(
                onPressed: selectedReason != null
                    ? () => widget.onOptionSelected(selectedReason!)
                    : null,
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: selectedReason != null
                      ? Colors.white.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('send_bu'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Gap(100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                children: [
                  Checkbox(
                    value: dontAskAgain,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          dontAskAgain = value;
                        });
                        setNoShowPreference(value);
                      }
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    side: BorderSide(color: Colors.white), // border color
                  ),
                  Text(
                    AppLocalizations.of(context).translate('dont_show'),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _optionTile(BuildContext context, String option) {
    return ListTile(
      title: Text(
        option,
        style: TextStyle(color: Colors.white),
      ),
      leading: Radio<String>(
        value: option,
        groupValue: selectedReason,
        onChanged: (String? value) {
          setState(() {
            selectedReason = value;
            print('Selected reason: $value');
          });
        },
        activeColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white; // Color when selected
          }
          return Colors.white; // Color when not selected
        }),
      ),
    );
  }
}

Future<void> setNoShowPreference(bool dontShowAgain) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dontShowDislikeDialog', dontShowAgain);
}

Future<bool> getNoShowPreference() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('dontShowDislikeDialog') ?? false;
}

String replaceNumbersInUrl(String url) {
  String updatedUrl = url;
  try {
    RegExp pattern = RegExp(r'\d+x');
    updatedUrl = url.replaceAll(pattern, '564x');
  } catch (e) {
    return updatedUrl;
  }
  return updatedUrl;
}
