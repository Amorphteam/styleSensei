import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/waiting/cubit/waiting_cubit.dart';
import 'package:style_sensei/screens/waiting/waiting_screen.dart';

import '../../utils/untitled.dart';
import '../home_tab/cubit/home_cubit.dart';
import '../home_tab/home_screen.dart';


class ImageItem {
  final String path;
  final int tag;
  final String des;

  ImageItem(this.path, this.tag, this.des);
}


class StyleScreen extends StatefulWidget {
  @override
  _StyleScreenState createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen> {
  //             "Classic": 405,
  //             "Casual": 411,
  // "Boho": 404,
  //             "Rock": 406,
  //             "Eclectic": 408,
  //             "Feminine": 402,
  //             "Minimal": 401,
  //             "Tomboy": 409,
  //             "Wintage": 414


  //             "Chic": 403,
  //             "Formal": 413,
  //             "Retro": 410,
  //             "Smart Casual": 412,
  //             "Streetwear": 407,
  //             "Unisex": 415,




  Set<int> selectedIndexes = {};
  @override
  void initState() {
    super.initState();
    images.shuffle(); // This will shuffle the order of images
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
                        fit: StackFit.expand, // Ensure the stack fills the parent
                        children: [
                          // Image.asset widget with BoxFit.cover should cover the entire grid tile.
                          Image.asset(
                            images[index].path,
                            fit: BoxFit.cover, // This will cover the entire grid area
                          ),
                          if (isSelected) Container(color: Colors.black54), // Semi-transparent overlay
                        ],
                      ),
                      footer: GridTileBar(
                        title: Text(''), // Empty text widget for alignment purposes
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
                final waitingCubit =
                WaitingCubit(); // Create an instance of HomeCubit
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => waitingCubit,
                      child: WaitingScreen(collectionTags: collectionTags,),
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
