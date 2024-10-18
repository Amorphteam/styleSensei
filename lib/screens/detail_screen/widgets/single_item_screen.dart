import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/screens/survey/survey_binary_choice.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../new_models/attribute.dart';
import '../../../new_models/product.dart';
import '../../../utils/AppLocalizations.dart';
import '../../../utils/analytics_helper.dart'; // Import the AnalyticsHelper for event logging
import '../../../utils/survey_helper.dart';
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
  final SurveyHelper _surveyHelper = SurveyHelper();

  @override
  void initState() {
    super.initState();
    _handleSessionCountAndSurvey();

    // Log the event when the product details screen is loaded
    AnalyticsHelper.logEvent('view_item_details', {
      'item_id': widget.product.id.toString(),
      'item_name': widget.product.name ?? 'Unknown',
      'category': widget.product.category?.name ?? 'Unknown', // Extract only the name of the category
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

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
                      child: Text(
                        isArabic ? widget.product.arabic_name ?? '' : widget.product.name ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: widget.bookmarkedItems[widget.product.id.toString()]!
                    ? SvgPicture.asset(
                  'assets/images/bookmarked.svg',
                  color: Theme.of(context).colorScheme.onBackground,
                )
                    : SvgPicture.asset(
                  'assets/images/bookmark.svg',
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  setState(() {
                    bool isCurrentlyBookmarked = widget.bookmarkedItems[widget.product.id.toString()]!;
                    widget.bookmarkedItems[widget.product.id.toString()] = !isCurrentlyBookmarked;
                  });
                  widget.onBookmarkUpdated!(widget.product.id.toString(), widget.bookmarkedItems[widget.product.id.toString()]!);
                  saveBookmarkedItems(widget.bookmarkedItems);
                },
              ),
            ],
          )),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrls![selectedIndex],
            fit: BoxFit.contain,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
                            imageUrl: getSmallImageUrl(imageUrls[index]),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                              highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                              child: Container(
                                height: 100,
                                width: 60,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: 0,
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap(8),
                Text(
                  isArabic ? widget.product.arabic_description ?? widget.product.description ?? '' :
                  widget.product.description ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              onPressed: () {
                // Log the event when the user clicks to proceed to the store
                AnalyticsHelper.logEvent('click_proceed_to_store', {
                  'item_id': widget.product.id.toString(),
                  'store_name': getBrandName(widget.product.attributes) ?? 'Unknown',
                });

                showPopupOnce(context, widget.product.corresponding_url!);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate('shopping_bu'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
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
      return 'Unknown';
    }

    for (var attribute in attributes) {
      if (attribute.attribute?.name == 'Brand name') {
        return attribute.value;
      }
    }
    return 'Unknown';
  }

  Future<void> _handleSessionCountAndSurvey() async {

    // Create an instance of SurveyMultistep to access its SurveyConfig
    final surveyConfig = SurveyBinaryChoice(
      onClose: () {},
      onAskMeLater: () {},
      onSend: () {},
    ).surveyConfig;

    // Check if the survey should be shown based on the SurveyConfig's initialDelay
    if (await _surveyHelper.shouldShowSurveyPurchase(surveyConfig)) {
      _surveyHelper.showSurveyPurchase(
        context: context,
        onClose: () async {
          await _surveyHelper.resetNextSurveySessionPurchase(surveyConfig.closeDelay);
        },
        onAskMeLater: () async {
          await _surveyHelper
              .resetNextSurveySessionPurchase(surveyConfig.askMeLaterDelay);
        },
        onSend: () async {
          await _surveyHelper.markSurveyAsCompletedPurchase();
        },
      );
    }
  }
}
