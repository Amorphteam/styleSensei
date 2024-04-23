import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../new_models/attribute.dart';
import '../../../new_models/product.dart';
import '../../../utils/AppLocalizations.dart';
import '../../../utils/untitled.dart';

class SingleItemScreen extends StatefulWidget {
  final Product product;
  final Map<String, bool> bookmarkedItems;
  final Function() loadBookmarkedItems;
  final Function(Map<String, bool>) saveBookmarkedItems;
  final Function(String, bool)? onBookmarkUpdated;

  SingleItemScreen({
    required this.product,
    required this.bookmarkedItems,
    required this.loadBookmarkedItems,
    required this.saveBookmarkedItems,
    required this.onBookmarkUpdated,
  });

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  int selectedIndex = 0;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    List<String>? imageUrls = widget.product.pictures?.split(',');
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Text(
                    getBrandName(widget.product.attributes) ?? 'Unknown',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Text(widget.product.name ?? '',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          ),
          IconButton(
            icon: widget.bookmarkedItems[widget.product.id.toString()]!
                ? SvgPicture.asset(
                    'assets/images/bookmarked.svg',
                    color: Colors.white, // Path to your SVG file
                  )
                : SvgPicture.asset(
                    'assets/images/bookmark.svg', // Path to your SVG file
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                bool isCurrentlyBookmarked =
                    widget.bookmarkedItems[widget.product.id.toString()]!;
                widget.bookmarkedItems[widget.product.id.toString()] =
                    !isCurrentlyBookmarked;
              });
              widget.onBookmarkUpdated!(widget.product.id.toString(),
                  widget.bookmarkedItems[widget.product.id.toString()]!);
              saveBookmarkedItems(widget.bookmarkedItems);
            },
          ),
        ],
      )),
      body: ListView(
        children: [
          // Top bar with the title and action icons
          // Image display with a network image and placeholders
          CachedNetworkImage(
            imageUrl: imageUrls![selectedIndex],
            fit: BoxFit.contain,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              // Light grey color for the base
              highlightColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              child: Container(
                width: double.infinity,
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // Thumbnail selector
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              height: 200,
              width: 120,
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
                      padding: EdgeInsets.all(1),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrls[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.5),
                              // Light grey color for the base
                              highlightColor: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.2),
                              child: Container(
                                height: 100,
                                width: 60,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: 0,
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              color: isSelected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2)
                                  : Colors.transparent,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16),
                Text(
                  AppLocalizations.of(context).translate('description'),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(8),
                Text(
                  widget.product.description ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: ElevatedButton(
              onPressed: () => showPopupOnce(context, widget.product.corresponding_url!),
              child: Text(
                AppLocalizations.of(context).translate('shopping_bu'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white, // Choose color that contrasts with the button color
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  String? getBrandName(List<Attribute>? attributes) {
    if (attributes == null) {
      return 'Unknown'; // or any default value you want to return if attributes is null
    }

    for (var attribute in attributes) {
      if (attribute.attribute?.name == 'Brand name') {
        return attribute.value;
      }
    }
    return 'Unknown'; // Default value in case the brand name is not found
  }


}
