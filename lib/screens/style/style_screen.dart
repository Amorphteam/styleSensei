import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/waiting/cubit/waiting_cubit.dart';
import 'package:style_sensei/screens/waiting/waiting_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart'; // Firebase Analytics

import '../../utils/untitled.dart';
import '../home_tab/cubit/home_cubit.dart';
import '../home_tab/home_screen.dart';

class StyleScreen extends StatefulWidget {
  final bool isFromSettings;

  StyleScreen({super.key, this.isFromSettings = false});

  @override
  _StyleScreenState createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen> {
  Set<int> selectedIndexes = {};
  FirebaseAnalytics _analytics = FirebaseAnalytics.instance; // Firebase Analytics instance

  @override
  void initState() {
    super.initState();
    images.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: ListView(
            children: [
              SizedBox(height: 8),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('style_title'),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('style_des'),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  )),
              SizedBox(height: 8),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndexes.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndexes.remove(index);
                        } else {
                          selectedIndexes.add(index);
                          // Log the style selection event
                          _logSelectEvent(images[index].tag);
                        }
                      });
                    },
                    child: GridTile(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            images[index].path,
                            fit: BoxFit.cover,
                          ),
                          if (isSelected) Container(color: Colors.black54), // Semi-transparent overlay
                        ],
                      ),
                      footer: GridTileBar(
                        title: Text(''),
                        trailing: isSelected
                            ? Icon(Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary)
                            : Icon(Icons.radio_button_off),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: selectedIndexes.length >= 4
                  ? () {
                List<int> collectionTags = getTagsSelected();
                saveSelections(styleSelections: collectionTags);
                // Log the final style selection
                _logFinalSelection(collectionTags);

                final waitingCubit = WaitingCubit();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => waitingCubit,
                      child: WaitingScreen(),
                    ),
                  ),
                      (Route<dynamic> route) => false,
                );
              }
                  : null, // Disable button if less than 4 items are selected
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return selectedIndexes.length < 4 ? Colors.grey : Colors.black;
                  },
                ),
              ),
              child: Text(
                selectedIndexes.length < 4
                    ? AppLocalizations.of(context).translate('pick') +
                    '${4 - selectedIndexes.length}' +
                    AppLocalizations.of(context).translate('more')
                    : AppLocalizations.of(context).translate('recommendation'),
                style: TextStyle(
                  color: Colors.white, // Change color conditionally
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<int> getTagsSelected() {
    List<int> collectionTags = [];
    for (var index in selectedIndexes) {
      if (!collectionTags.contains(images[index].tag)) {
        collectionTags.add(images[index].tag);
      }
    }
    return collectionTags;
  }

  // Log an event when a user selects a style
  Future<void> _logSelectEvent(int styleTag) async {
    await _analytics.logEvent(
      name: 'select_favorite_style',
      parameters: <String, dynamic>{
        'style_tag': styleTag,
      },
    );
  }

  // Log an event when the user confirms their final selection
  Future<void> _logFinalSelection(List<int> selectedStyles) async {
    await _analytics.logEvent(
      name: 'final_style_selection',
      parameters: <String, dynamic>{
        'selected_styles': selectedStyles.join(','), // Send selected styles as a parameter
      },
    );
  }
}
