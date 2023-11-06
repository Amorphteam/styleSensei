import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_tab/cubit/home_cubit.dart';
import '../home_tab/home_screen.dart';


class ImageItem {
  final String path;
  final String tag;

  ImageItem(this.path, this.tag);
}


class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<ImageItem> images = [
    ImageItem('assets/images/0.png', 'Tag0'),
    ImageItem('assets/images/1.png', 'Tag1'),
    ImageItem('assets/images/2.png', 'Tag2'),
    ImageItem('assets/images/3.png', 'Tag3'),
    ImageItem('assets/images/4.png', 'Tag4'),
    ImageItem('assets/images/5.png', 'Tag5'),
  ];

  Set<int> selectedIndexes = {};
  void printSelectedTags() {
    for (var index in selectedIndexes) {
      print(images[index].tag); // Printing the tag of each selected image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(height: 8),
              Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick 4 or more styles you like',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'By understanding your preferences, \nwe can offer you tailored recommendations.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/large_text_logo.png',
                        width: 12,
                      )
                    ],
                  )),
              SizedBox(height: 8),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true, // You won't see infinite size error
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.75,
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
                        children: [
                          Image.asset(images[index].path, fit: BoxFit.cover),
                          if (!isSelected) Container(color: Colors.black38), // Semi-transparent overlay
                        ],
                      ),
                      footer: GridTileBar(
                        title: Text(''), // Empty text widget can be used to push the icon to the right if needed.
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: Colors.red)
                            : Icon(Icons.radio_button_off, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: selectedIndexes.length >= 3
                  ? () {
                printSelectedTags();
                // Your navigation logic here
              }
                  : null, // Button is disabled if less than 4 items are selected
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // Disabled color
                    }
                    return selectedIndexes.length < 3 ? Colors.grey : Colors.black; // Enable color changes
                  },
                ),
              ), // Button is disabled if less than 3 items are selected
              child: Text(
                selectedIndexes.length < 3
                    ? 'Pick ${3 - selectedIndexes.length} more'
                    : 'Get Recommendations',
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
}
