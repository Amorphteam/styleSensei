import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/waiting/cubit/waiting_cubit.dart';
import 'package:style_sensei/screens/waiting/waiting_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

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
                // to disable GridView's scrolling
                shrinkWrap: true,
                // You won't see infinite size error
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
                        }
                      });
                    },
                    child: GridTile(
                      child: Stack(
                        fit: StackFit.expand,
                        // Ensure the stack fills the parent
                        children: [
                          // Image.asset widget with BoxFit.cover should cover the entire grid tile.
                          Image.asset(
                            images[index].path,
                            fit: BoxFit
                                .cover, // This will cover the entire grid area
                          ),
                          if (isSelected) Container(color: Colors.black54),
                          // Semi-transparent overlay
                        ],
                      ),
                      footer: GridTileBar(
                        title: Text(''),
                        // Empty text widget for alignment purposes
                        trailing: isSelected
                            ? Icon(Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary)
                            : Icon(
                                Icons.radio_button_off,
                              ),
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
                      final waitingCubit =
                          WaitingCubit(); // Create an instance of HomeCubit
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => waitingCubit,
                            child: WaitingScreen(),
                          ),
                        ),
                        (Route<dynamic> route) =>
                            false, // No route will allow return
                      );

                      // Your navigation logic here
                    }
                  : null,
              // Button is disabled if less than 4 items are selected
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return selectedIndexes.length < 4
                        ? Colors.grey
                        : Colors.black; // Enable color changes
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
}
