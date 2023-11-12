import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/Products.dart';
import '../../../utils/untitled.dart';

class ImagePopupDialog extends StatefulWidget {
  final Products product;
  final Map<String, bool> bookmarkedItems;
  final Function() loadBookmarkedItems;
  final Function(Map<String, bool>) saveBookmarkedItems;

  ImagePopupDialog({
    required this.product,
    required this.bookmarkedItems,
    required this.loadBookmarkedItems,
    required this.saveBookmarkedItems,
  });


  @override
  _ImagePopupDialogState createState() => _ImagePopupDialogState();
}

class _ImagePopupDialogState extends State<ImagePopupDialog> {
  int selectedIndex = 0;
  bool isBookmarked = false; // State variable to track bookmark status.

  @override
  Widget build(BuildContext context) {
    // Extract image URLs from the product pictures
    List<String>? imageUrls = widget.product.pictures?.split(',');

    // The dialog layout
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Defines the shape of the dialog.
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top bar with the title and action icons
            ListTile(
              title: Text(widget.product.name ?? '', style: Theme.of(context).textTheme.titleMedium),
              trailing: Wrap(
                spacing: 8, // space between the icons
                children: <Widget>[
                  IconButton(
                    icon: widget.bookmarkedItems[widget.product.id.toString()]!
                        ? SvgPicture.asset(
                      'assets/images/bookmarked.svg', // Path to your SVG file
                    )
                        : SvgPicture.asset(
                      'assets/images/bookmark.svg', // Path to your SVG file
                    ),
                    onPressed: () {
                      // Toggle the bookmark state
                      widget.bookmarkedItems[widget.product.id.toString()] =
                      !widget.bookmarkedItems[widget.product.id.toString()]!;
                      // Save bookmarked items
                      saveBookmarkedItems(widget.bookmarkedItems);
                    },
                  ),                  IconButton(
                    onPressed: () => _openSourceWebsite(widget.product.correspondingUrl!),
                    icon: SvgPicture.asset('assets/images/basket.svg'),
                  ),
                ],
              ),
            ),
            // Image display with a network image and placeholders
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrls![selectedIndex],
                fit: BoxFit.contain,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            // Thumbnail selector
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
                          borderRadius: BorderRadius.circular(8), // Updated for rounded corners
                        )
                            : null,
                        child: CachedNetworkImage(
                          imageUrl: imageUrls[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 100,
                              width: 60,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch a URL
  Future<void> _openSourceWebsite(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
