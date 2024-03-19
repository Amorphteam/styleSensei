import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';

class ColorTonesScreen extends StatefulWidget {
  @override
  _ColorTonesScreenState createState() => _ColorTonesScreenState();
}

class _ColorTonesScreenState extends State<ColorTonesScreen> {
  int selectedBodyType = -1; // To track the selected body type

  final List<ImageItem> bodyTypes = [
    ImageItem('assets/images/dark.jpg', 0, 'Fit'),
    ImageItem('assets/images/bright.jpg', 1, 'Plus Size'),
    ImageItem('assets/images/pastel.jpg', 2, 'Expecting'),
    ImageItem('assets/images/neutral.jpg', 3, 'Curvy'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Choose your favorite color tones.',
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
          itemCount: bodyTypes.length,
          itemBuilder: (context, index) {
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
                      setState(() {
                        selectedBodyType = value!;
                      });
                    },
                  ),
                  Text(bodyTypes[index].des),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: selectedBodyType != -1
                ? () {
              final imageSelectionCubit =
              ImageSelectionCubit(); // Create an instance of HomeCubit
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
                  return selectedBodyType == -1 ? Colors.grey : Colors.black; // Enable color changes
                },
              ),
            ),
            child: Text(
              'Pick 1',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}

class ImageItem {
  final String path;
  final int tag;
  final String des;

  ImageItem(this.path, this.tag, this.des);
}
