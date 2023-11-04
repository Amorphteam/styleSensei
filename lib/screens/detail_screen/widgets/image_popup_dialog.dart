import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/Products.dart';

class ImagePopupDialog extends StatefulWidget {
  final Products product;

  ImagePopupDialog({Key? key, required this.product}) : super(key: key);

  @override
  _ImagePopupDialogState createState() => _ImagePopupDialogState();
}

class _ImagePopupDialogState extends State<ImagePopupDialog> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String>? imageUrls = widget.product.pictures?.split(',');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // This provides sharp corners.
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top bar with title, bookmark and shopping cart icons
          ListTile(
            title: Text('Test name for product', style: Theme.of(context).textTheme.titleMedium),
            trailing: Wrap(
              spacing: 8, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset('assets/images/bookmark.svg'),
                  onPressed: (){},
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/images/basket.svg'),
                  onPressed: (){},
                ),
              ],
            ),
          ),
          // Large Image Display
          Expanded(
            child: Image.network(
              imageUrls![selectedIndex],
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          // Thumbnails Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: isSelected
                          ? BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(0),
                      )
                          : null,
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}