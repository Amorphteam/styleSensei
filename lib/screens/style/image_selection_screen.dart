import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_tab/cubit/home_cubit.dart';
import '../home_tab/home_screen.dart';


class ImageItem {
  final String path;
  final int tag;

  ImageItem(this.path, this.tag);
}


class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<ImageItem> images = [
    // "Boho": 404,
    //             "Casual": 411,
    //             "Chic": 403,
    //             "Classic": 405,
    //             "Eclectic": 408,
    //             "Feminine": 402,
    //             "Formal": 413,
    //             "Minimal": 401,
    //             "Retro": 410,
    //             "Rock": 406,
    //             "Smart Casual": 412,
    //             "Streetwear": 407,
    //             "Tomboy": 409,
    //             "Unisex": 415,
    //             "Wintage": 414
    ImageItem('assets/images/0.png', 401),
    ImageItem('assets/images/1.png', 401),
    ImageItem('assets/images/2.png', 401),
    ImageItem('assets/images/3.png', 401),
    ImageItem('assets/images/4.png', 401),
    ImageItem('assets/images/5.png', 411),
    ImageItem('assets/images/0.png', 411),
    ImageItem('assets/images/6.png', 411),
    ImageItem('assets/images/7.png', 411),
    ImageItem('assets/images/8.png', 411),
    ImageItem('assets/images/1.png', 411),
    ImageItem('assets/images/5.png', 411),
  ];

  Set<int> selectedIndexes = {};


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
                  crossAxisCount: 3,
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
                          if (isSelected) Container(color: Colors.black54), // Semi-transparent overlay
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
              SizedBox(height: 60),

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
                List<int> collectionTags = getTagsSelected();
                print('aaaa $collectionTags');
                final imageSelectionCubit =
                HomeCubit(); // Create an instance of HomeCubit
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => imageSelectionCubit,
                      child: MyHomePage(collectionTags: collectionTags,),
                    ),
                  ),
                      (Route<dynamic> route) => false, // No route will allow return

                );

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

  List<int> getTagsSelected() {
    List<int> collectionTags = [];
    for (var index in selectedIndexes) {
      if (!collectionTags.contains(images[index].tag)){
      collectionTags.add(images[index].tag);
      }
    }
    return collectionTags;
  }
}
