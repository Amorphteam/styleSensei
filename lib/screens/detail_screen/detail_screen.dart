import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/models/ProductsModel.dart';

import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/detail_screen/widgets/image_popup_dialog.dart';
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
              child: Text('Error is ${state.error}'),
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
              title: innerBoxIsScrolled ? Text(getTitle(collectionDetail?.collection?.title, (isArabic)?'ar':'en')) : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                        if (page == 1) {
                          _videoController?.play();
                        }
                      });
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CachedNetworkImage(
                          imageUrl: widget.collection.image ?? '',
                          fit: BoxFit.cover,
                        );
                      } else if (index == 1) {
                        if (_isVideoPlayed) {
                          return Container(
                            color: Color(0xFFC6C2B8),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Gap(40),
                                  Text(
                                    'Who it’s Best For?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Gap(20),
                                  Text(
                                    getBodyShapeText(collectionDetail?.collection?.description, (isArabic)?'ar':'en'),
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController!.value.size.width,
                              height: _videoController!.value.size.height,
                              child: VideoPlayer(_videoController!),
                            ),
                          );
                        }
                      } else {
                        return Container(
                          color: Color(0xFFC6C2B8),
                          child: Center(
                            child: Text(
                              'Third Slide Content',
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                    Positioned(                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                          );
                        }),
                      ),
                    )
                ]
                ),
              ),
            ),
          ];
        },
        body: buildWidget(collection),
      ),
    );
  }

  Widget buildWidget(List<CollectionItem> items) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/collection.svg'),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 2),
                child: Text(
                  'Collection details',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
                          '${items[index].products?.length ?? ' '} Alternatives',
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
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.grey[100],
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
                                                  baseColor: Colors.grey[300]!,
                                                  // Light grey color for the base
                                                  highlightColor:
                                                      Colors.grey[100]!,
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
                                                left: 12.0),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              productItem.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => _openSourceWebsite(
                                                productItem.corresponding_url!),
                                            child: Text(
                                              AppLocalizations.of(context).translate('shopping_bu'),
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.blue,
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
                                            color: Colors.white,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImagePopupDialog(
          product: product,
          bookmarkedItems: bookmarkedItems,
          loadBookmarkedItems: loadBookmarkedItems,
          saveBookmarkedItems: saveBookmarkedItems,
          onBookmarkUpdated: updateBookmark,
        );
      },
    );
  }

  void updateBookmark(String productId, bool isBookmarked) {
    setState(() {
      bookmarkedItems[productId] = isBookmarked;
    });
  }

  Future<void> _openSourceWebsite(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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

// Method to load bookmarked item IDs from SharedPreferences
}
