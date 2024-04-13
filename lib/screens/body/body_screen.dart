import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

import '../../utils/untitled.dart';
import '../color_tones/color_tones_screen.dart';

class BodyTypeSelectionScreen extends StatefulWidget {
  @override
  _BodyTypeSelectionScreenState createState() =>
      _BodyTypeSelectionScreenState();
}

class _BodyTypeSelectionScreenState extends State<BodyTypeSelectionScreen> {
  int selectedBodyType = -1; // To track the selected body type

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode ==
        'ar'; // Check if the current language is Arabic

    return Scaffold(
      body: Stack(children: [
        Container(
          child: ListView(children: [
            SizedBox(height: 8),
            Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('body_type_title'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('body_type_des'),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context).translate('body_type_guide'),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 68.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                // to disable GridView's scrolling
                shrinkWrap: true,
                // You won't see infinite size error
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 40,
                  childAspectRatio: (0.4),
                ),
                itemCount: bodyTypes.length,
                itemBuilder: (context, index) {
                  String description =
                      isArabic ? bodyTypes[index].arDes : bodyTypes[index].des;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBodyType = bodyTypes[index].tag;
                      });
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            bodyTypes[index].path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Radio<int>(
                          value: bodyTypes[index].tag,
                          groupValue: selectedBodyType,
                          onChanged: (int? value) {
                            if (value != null) {
                              setState(() {
                                selectedBodyType = value;
                              });
                            }
                          },
                        ),
                        Text(description),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: selectedBodyType != -1
                  ? () {
                      List<int> selectedBodyTypes = [];
                      selectedBodyTypes.add(selectedBodyType);
                      saveSelections(bodyTypeSelections: selectedBodyTypes);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorTonesScreen(),
                        ),
                      );
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return selectedBodyType == -1
                        ? Colors.grey
                        : Colors.black; // Enable color changes
                  },
                ),
              ),
              child: Text(
                AppLocalizations.of(context).translate('pick_1'),
                style: TextStyle(
                  color: Colors.white, // Change color conditionally
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
