import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/models/ProductsModel.dart';

import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/detail_screen/widgets/single_item_screen.dart';
import 'package:style_sensei/screens/home_tab/widgets/staggered_grid_view_widget.dart';
import 'package:style_sensei/screens/detail_screen/widgets/staggered_grid_view_detail_widget.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../models/Collections.dart';
import '../../new_models/attribute.dart';
import '../../new_models/collection_item.dart';
import '../../new_models/product.dart';
import '../../repositories/collection_repository.dart';
import '../../utils/untitled.dart';
import '../home_tab/widgets/tab_bar_widget.dart';

class Detail extends StatefulWidget {
  final Collections collection;

  Detail({required this.collection});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Map<String, bool> bookmarkedItems = {};
  PageController _pageController = PageController();
  int _currentPage = 0;
  VideoPlayerController? _videoController;
  bool _isVideoPlayed = false; // Track if the video has been played
  bool _showChips = false;  // State to track visibility of chips

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/body2.m4v')
      ..initialize().then((_) {
        setState(() {
          _videoController!.setLooping(false); // Ensure the video doesn't loop
        });
      });

    _videoController?.addListener(() {
      if (_videoController!.value.position ==
          _videoController!.value.duration) {
        // Video finished playing
        setState(() {
          _isVideoPlayed =
              true; // Mark video as played to show the text instead
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadBookmarkedItems().then((loadedBookmarkedItems) {
        setState(() {
          bookmarkedItems = loadedBookmarkedItems;
        });
      });
      BlocProvider.of<DetailCubit>(context)
          .fetchData(CollectionRepository(), widget.collection.id);
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailCubit, DetailState>(
      builder: (context, state) {
        if (state is ProductListLoadedState) {
          var collection = state.items;
          var collectionDetail = state.collectionDetail;
          return buildUi(context, collection, collectionDetail);
        } else if (state is DetailLoadingState) {
          return Scaffold(
            body: Center(
              child: Container(
                width: 200,
                height: 100,
                child: Lottie.asset('assets/json/loading.json'),
              ),
            ),
          );
        } else if (state is DetailErrorState) {
          return Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context).translate('error')),
            ),
          );
        } else {
          // This handles DetailInitial and any other unhandled state
          return Scaffold(
            body: Center(child: Text('Loading...')),
          );
        }
      },
    );
  }

  Widget buildUi(BuildContext context, List<CollectionItem> collection,
      ProductsModel? collectionDetail) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 600.0,
              floating: false,
              pinned: true,
              title: innerBoxIsScrolled
                  ? Text(getTitle(collectionDetail?.collection?.title,
                      (isArabic) ? 'ar' : 'en'))
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: replaceNumbersInUrl(widget.collection.image) ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: buildWidget(collection, collectionDetail),
      ),
    );
  }

  Widget buildWidget(
      List<CollectionItem> items, ProductsModel? collectionDetail) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      children: [
        ListTile(
          leading: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset('assets/images/cat.svg')),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 2, right: 10.0),
                  child: Text(
                    AppLocalizations.of(context).translate('collection_detail'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  _showChips
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onSurface,),
              ],
            ),
          ),

          onTap: () {
            setState(() {
              _showChips = !_showChips;  // Toggle the visibility of chips
            });
          },
        ),
        if (_showChips)  // Conditionally display chips
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: listOfChips(collectionDetail),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items[index].category!.name ?? 'Default Name',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${items[index].products?.length ?? ' '}' +
                              '  ' +
                              AppLocalizations.of(context)
                                  .translate('alternatives'),
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (items[index].products != null)
                            ...items[index].products!.map((productItem) {
                              // Initialize the bookmark state for this item if it has not been done yet
                              bookmarkedItems[productItem.id.toString()] ??=
                                  false;
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, top: 8.0, bottom: 8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                showImagePopup(
                                                    context, productItem);
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: productItem.pictures!
                                                    .split(',')[0],
                                                fit: BoxFit.cover,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.34,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: Theme.of(context)
                                                      .colorScheme
                                                      .surface
                                                      .withOpacity(0.5),
                                                  // Light grey color for the base
                                                  highlightColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.2),
                                                  // Lighter grey color for the highlight
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.29,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.33,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  print(
                                                      error); // This will print the error to the console
                                                  return Icon(Icons.error);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 12.0),
                                            child: Text(
                                              getBrandName(
                                                      productItem.attributes) ??
                                                  'Unknown',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0, right: 12.0),
                                              child: Text(
                                                isArabic
                                                    ? productItem.arabic_name!
                                                    : productItem.name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => showPopupOnce(
                                                context,
                                                productItem.corresponding_url!),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('shopping_bu'),
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight
                                                    .bold, // You can choose the color that fits your design
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 8,
                                        right: 16,
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface
                                                .withOpacity(0.2),
                                            shape: BoxShape.circle,
                                            // Circular shape
                                          ),
                                          child: IconButton(
                                            icon: bookmarkedItems[
                                                    productItem.id.toString()]!
                                                ? SvgPicture.asset(
                                                    'assets/images/bookmarked.svg', // Path to your SVG file
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/bookmark.svg', // Path to your SVG file
                                                  ),
                                            onPressed: () {
                                              setState(() {
                                                // Toggle the bookmark state
                                                bookmarkedItems[productItem.id
                                                        .toString()] =
                                                    !bookmarkedItems[productItem
                                                        .id
                                                        .toString()]!;
                                                // Save bookmarked items to SharedPreferences
                                                saveBookmarkedItems(
                                                    bookmarkedItems);
                                              });
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void showImagePopup(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleItemScreen(
            product: product,
            bookmarkedItems: bookmarkedItems,
            loadBookmarkedItems: loadBookmarkedItems,
            saveBookmarkedItems: saveBookmarkedItems,
            onBookmarkUpdated: updateBookmark),
      ),
    );
  }

  void updateBookmark(String productId, bool isBookmarked) {
    setState(() {
      bookmarkedItems[productId] = isBookmarked;
    });
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

  String getBodyShapeText(String? jsonString, String language) {
    if (jsonString != null) {
      try {
        Map<String, dynamic> jsonData = json.decode(jsonString);
        String bodyShapeEn = jsonData['body_shape'][language];
        return bodyShapeEn;
      } catch (error) {
        return jsonString;
      }
    }
    return '';
  }

  String getSuitationText(String? jsonString, String language) {
    if (jsonString != null) {
      try {
        Map<String, dynamic> jsonData = json.decode(jsonString);
        String bodyShapeEn = jsonData['situation'][language];
        return bodyShapeEn;
      } catch (error) {
        return jsonString;
      }
    }
    return '';
  }

  String getTitle(String? titleJson, String language) {
    if (titleJson != null) {
      try {
        Map<String, dynamic> jsonData = json.decode(titleJson);
        String enTitle = jsonData[language];
        return enTitle;
      } catch (error) {
        return titleJson;
      }
    }
    return '';
  }

  List<Widget> listOfChips(ProductsModel? collectionDetail) {
    List<Widget> tagWidgets = [];

    if (collectionDetail?.collection?.tags != null) {
      collectionDetail!.collection!.tags!.forEach((key, value) {
        List<dynamic> tagValues = value;
        List<Widget> chips = tagValues
            .map((tag) => Chip(
          label: Text(tag.toString(), style: Theme.of(context).textTheme.labelSmall,),
          backgroundColor: Theme.of(context)
              .colorScheme
              .inversePrimary
              .withOpacity(0.1),
          side: BorderSide.none,
        ))
            .toList();

        // Create a row for the category name and its tags
        Widget tagRow = Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(key, style: Theme.of(context).textTheme.labelMedium),
              ),
              Expanded(
                flex: 2,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 0.0,
                  children: chips,
                ),
              ),
            ],
          ),
        );
        tagWidgets.add(tagRow);
      });
    }

    return tagWidgets;
  }

// Method to load bookmarked item IDs from SharedPreferences
}
