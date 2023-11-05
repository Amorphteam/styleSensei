import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

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
            title: Text(widget.product.name?? '', style: Theme.of(context).textTheme.titleMedium),
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
            child: CachedNetworkImage(
              imageUrl: imageUrls![selectedIndex],
              fit: BoxFit.contain,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!, // Light grey color for the base
                highlightColor: Colors.grey[100]!, // Lighter grey color for the highlight
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),        errorWidget: (context, url, error) {
              print(error); // This will print the error to the console
              return Icon(Icons.error);
            },
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
                      child: CachedNetworkImage(
                        imageUrl: imageUrls[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!, // Light grey color for the base
                          highlightColor: Colors.grey[100]!, // Lighter grey color for the highlight
                          child: Container(
                            height: 100,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),        errorWidget: (context, url, error) {
                        print(error); // This will print the error to the console
                        return Icon(Icons.error);
                      },
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