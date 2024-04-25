import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppLocalizations.dart';
import '../../utils/untitled.dart';
import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ColorTonesScreen extends StatefulWidget {
  final bool isFromSettings;
  ColorTonesScreen({super.key, this.isFromSettings = false});

  @override
  _ColorTonesScreenState createState() => _ColorTonesScreenState();
}

class _ColorTonesScreenState extends State<ColorTonesScreen> {
  List<int> selectedColorTones = [];

  @override
  void initState() {
    super.initState();
    getColorTonesSelected().then((value) {
      if (value != null) {
        setState(() {
          selectedColorTones = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context).translate('color_tone_title'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 68.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 40,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: colorTones.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedColorTones.contains(colorTones[index].tag);
                    String description = isArabic ? colorTones[index].arDes : colorTones[index].des;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedColorTones.remove(colorTones[index].tag);
                          } else {
                            selectedColorTones.add(colorTones[index].tag);
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              colorTones[index].path,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedColorTones.remove(colorTones[index].tag);
                                    } else {
                                      selectedColorTones.add(colorTones[index].tag);
                                    }
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(description),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  saveSelections(colorToneSelections: selectedColorTones);
                  final imageSelectionCubit = ImageSelectionCubit();

                  if (widget.isFromSettings) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => imageSelectionCubit,
                          child: StyleScreen(),
                        ),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey; // Disabled color
                      }
                      return Colors.black; // Enable color changes
                    },
                  ),
                ),
                child: Text(
                  widget.isFromSettings == true
                      ? AppLocalizations.of(context).translate('save')
                      : AppLocalizations.of(context).translate('next'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<int>?> getColorTonesSelected() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bodyTypeSelectionsString = prefs.getString('colorToneSelections');
    if (bodyTypeSelectionsString == null) {
      return null;
    }
    return parseIdsFromString(bodyTypeSelectionsString);
  }
}
