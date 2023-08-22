import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;

  ImageCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0), // Set the border radius to your desired value
          child: Image.asset(imagePath),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Add your action for when the user clicks "See Details"
                // For example, navigate to another screen or show more information.
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0), // You can adjust the border radius as needed
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text('See Details', style: Theme.of(context).textTheme.bodySmall,),
              ),
            )

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

