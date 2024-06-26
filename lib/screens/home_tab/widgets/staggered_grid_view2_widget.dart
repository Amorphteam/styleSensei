import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:style_sensei/utils/untitled.dart';

class StaggeredGridView2 extends StatefulWidget {
  const StaggeredGridView2({super.key});

  @override
  State<StaggeredGridView2> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView2> {
  // Define the total number of images you want to load
  static const int totalImages = 4;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 6,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.same,
        pattern: [
          QuiltedGridTile(4, 3),
          QuiltedGridTile(4, 3),
          QuiltedGridTile(8, 6),
          QuiltedGridTile(3, 6),
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
    );
  }
}
