import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:style_sensei/utils/untitled.dart';

class StaggeredGridViewDetail extends StatefulWidget {
  const StaggeredGridViewDetail({super.key});

  @override
  State<StaggeredGridViewDetail> createState() => _StaggeredGridViewDetailState();
}

class _StaggeredGridViewDetailState extends State<StaggeredGridViewDetail> {
  // Define the total number of images you want to load
  static const int totalImages = 4;
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Long black women\'s dress', style: Theme.of(context).textTheme.labelLarge,),
              Text('ZARA', style: Theme.of(context).textTheme.caption,)
            ],
          ),
        ),
        GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 12,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.same,
            pattern: [
              QuiltedGridTile(6, 5),
              QuiltedGridTile(3, 3),
              QuiltedGridTile(6, 4),
              QuiltedGridTile(3, 3),


            ],
          ),
          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true, // You won't see infinite size error
          childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
              // Check if the index is within the totalImages range
              if (index < totalImages) {
                // return ImageTile(
                //   index: index,
                //   width: 2000,
                //   height: 2000,
                // );
              } else {
                return null; // Return null for indexes beyond the limit to avoid rendering empty spaces
              }
            },
            // Set the childCount to the totalImages
            childCount: totalImages,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.favorite_outline_outlined),
              onPressed: () {
                // Implement the share functionality here
                _liked(imagePath, context);
              },
            ),

            IconButton(
              icon: Icon(Icons.visibility_off_outlined),
              onPressed: () {
                // Implement the share functionality here
                _disliked(imagePath, context);
              },
            ),
            IconButton(
              icon: Icon(Icons.bookmark_add_outlined),
              onPressed: () {
                // Implement the like functionality here
                _bookmarked(imagePath, context);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _disliked(String imagePath, BuildContext context) {

  }
  void _liked(String imagePath, BuildContext context) {

  }

  void _bookmarked(String imagePath, BuildContext context) {

  }
}
