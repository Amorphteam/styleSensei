import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../color_tones/color_tones_screen.dart';

class BodyTypeSelectionScreen extends StatefulWidget {
  @override
  _BodyTypeSelectionScreenState createState() =>
      _BodyTypeSelectionScreenState();
}

class _BodyTypeSelectionScreenState extends State<BodyTypeSelectionScreen> {
  int selectedBodyType = -1; // To track the selected body type

  // Sample data structure for body types. You would replace these with your actual data.
  final List<ImageItem> bodyTypes = [
    ImageItem('assets/images/fit.jpg', 0, 'Fit'),
    ImageItem('assets/images/plus_size.jpg', 1, 'Plus Size'),
    ImageItem('assets/images/expecting.jpg', 2, 'Expecting'),
    ImageItem('assets/images/curvy.jpg', 3, 'Curvy'),
    ImageItem('assets/images/petite.jpg', 4, 'Petite'),
    ImageItem('assets/images/tall.jpg', 5, 'Tall'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
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
                            'Tell us more about your appearance and preferences.',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'You can easily edit this information at any time within the app.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/large_text_logo.png',
                      width: 12,
                    )
                  ],
                )),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Choose the body type that best aligns with yours.',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
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
                      Text(bodyTypes[index].des),
                    ],
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: selectedBodyType != -1
                    ? () {
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
                  'Pick 1',
                  style: TextStyle(
                    color: Colors.white, // Change color conditionally
                  ),
                ),
              ),
            ),
          ]),
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
