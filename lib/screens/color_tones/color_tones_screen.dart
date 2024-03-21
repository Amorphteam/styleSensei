import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/AppLocalizations.dart';
import '../../utils/untitled.dart';
import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ColorTonesScreen extends StatefulWidget {
  @override
  _ColorTonesScreenState createState() => _ColorTonesScreenState();
}

class _ColorTonesScreenState extends State<ColorTonesScreen> {
  List<int> selectedColorTones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context).translate('color_tone_title'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
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
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedColorTones.contains(colorTones[index].tag)) {
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
                    Checkbox(
                      value: selectedColorTones.contains(colorTones[index].tag),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedColorTones.add(colorTones[index].tag);
                          } else {
                            selectedColorTones.remove(colorTones[index].tag);
                          }
                        });
                      },
                    ),
                    Text(colorTones[index].des),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedColorTones.isNotEmpty
                  ? () {
                saveSelections(colorToneSelections: selectedColorTones);
                final imageSelectionCubit = ImageSelectionCubit();
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
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return selectedColorTones.isEmpty ? Colors.grey : Colors.black; // Enable color changes
                  },
                ),
              ),
              child: Text(
                AppLocalizations.of(context).translate('pick_1'),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
