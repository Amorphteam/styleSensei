import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:visibility_detector/visibility_detector.dart'; // Import the visibility_detector package

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
  bool _showChips = true; // State to track visibility of chips
  Map<int, bool> visibilityMap = {}; // Track visibility of items
  Map<int, bool> horizontalVisibilityMap =
      {}; // Track visibility of horizontal items

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

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                  text: AppLocalizations.of(context)
                      .translate('collection_detail')),
              Tab(
                  text: AppLocalizations.of(context)
                      .translate('collection_items')),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent1(items, collectionDetail, isArabic),
                buildTabContent2(items, collectionDetail, isArabic),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabContent1(List<CollectionItem> items,
      ProductsModel? collectionDetail, bool isArabic) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            collectionDetail?.collection?.title ?? 'Default Title',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(20),
          Column(
            children: listOfChips(collectionDetail),
          ),
          Gap(48),
          ChatScreen()
        ],
      ),
    );
  }

  Widget buildTabContent2(List<CollectionItem> items,
      ProductsModel? collectionDetail, bool isArabic) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return VisibilityDetector(
            key: Key(index.toString()),
            onVisibilityChanged: (VisibilityInfo info) {
              if (info.visibleFraction > 0.5) {
                setState(() {
                  visibilityMap[index] = true;
                });
              }
            },
            child: visibilityMap[index] == true
                ? buildCollectionItem(context, items[index], isArabic, index)
                : Container(
                    height: 200, color: Colors.transparent), // Placeholder
          );
        },
      ),
    );
  }

  Widget buildCollectionItem(BuildContext context, CollectionItem item,
      bool isArabic, int parentIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.category?.name ?? 'Default Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${item.products?.length ?? ' '}' +
                    '  ' +
                    AppLocalizations.of(context).translate('alternatives'),
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.products?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              int key = parentIndex * 1000 +
                  index; // Generate unique key for each horizontal item
              return VisibilityDetector(
                key: Key(key.toString()),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction > 0.5) {
                    setState(() {
                      horizontalVisibilityMap[key] = true;
                    });
                  }
                },
                child: horizontalVisibilityMap[key] == true
                    ? buildProductItem(context, item.products![index], isArabic)
                    : Container(
                        width: 100, color: Colors.transparent), // Placeholder
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductItem(
      BuildContext context, Product productItem, bool isArabic) {
    bookmarkedItems[productItem.id.toString()] ??= false;

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 8.0, bottom: 8.0),
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showImagePopup(context, productItem);
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          getSmallImageUrl(productItem.pictures!.split(',')[0]),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width * 0.44,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        print(error);
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    getBrandName(productItem.attributes) ?? 'Unknown',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(
                      isArabic ? productItem.arabic_name! : productItem.name!,
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      showPopupOnce(context, productItem.corresponding_url!),
                  child: Text(
                    AppLocalizations.of(context).translate('shopping_bu'),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
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
                color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: bookmarkedItems[productItem.id.toString()]!
                    ? SvgPicture.asset(
                        'assets/images/bookmarked.svg',
                      )
                    : SvgPicture.asset(
                        'assets/images/bookmark.svg',
                      ),
                onPressed: () {
                  setState(() {
                    bookmarkedItems[productItem.id.toString()] =
                        !bookmarkedItems[productItem.id.toString()]!;
                    saveBookmarkedItems(bookmarkedItems);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, bool>> loadBookmarkedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, bool> bookmarkedItems = {};
    if (prefs.containsKey('bookmarkedItems')) {
      bookmarkedItems = Map<String, bool>.from(
          json.decode(prefs.getString('bookmarkedItems')!));
    }
    return bookmarkedItems;
  }

  Future<void> saveBookmarkedItems(Map<String, bool> bookmarkedItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmarkedItems', json.encode(bookmarkedItems));
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

  String getTitle(String? titleJson, String language) {
    if (titleJson != null) {
      titleJson = titleJson.replaceAll("@", "");

      try {
        Map<String, dynamic> jsonData = json.decode(titleJson);
        return jsonData[language];
      } catch (error) {
        return titleJson;
      }
    }
    return '';
  }

  void showPopupOnce(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
          onBookmarkUpdated: updateBookmark,
        ),
      ),
    );
  }

  void updateBookmark(String productId, bool isBookmarked) {
    setState(() {
      bookmarkedItems[productId] = isBookmarked;
    });
  }

  List<Widget> listOfChips(ProductsModel? collectionDetail) {
    List<Widget> tagWidgets = [];

    if (collectionDetail?.collection?.tags != null) {
      collectionDetail!.collection!.tags!.forEach((key, value) {
        List<dynamic> tagValues = value;
        List<Widget> chips = tagValues
            .map((tag) => Chip(
                  label: Text(
                    tag.toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withOpacity(0.1),
                  side: BorderSide.none,
                ))
            .toList();

        // Create a row for the category name and its tags
        Widget tagRow = Padding(
          padding: const EdgeInsets.only(right: 0.0, left: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child:
                    Text(key, style: Theme.of(context).textTheme.labelMedium),
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
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuggestions = false;
  bool _showResponse = false;
  String _selectedQuestion = "";

  final List<String> _suggestions = [
    "Is the material comfortable for everyday wear?",
    "Can I wear these pieces to a formal event?",
  ];

  void _onTextChanged(String text) {
    setState(() {
      _showSuggestions = text.isNotEmpty;
      _showResponse = false;
    });
  }

  void _onSuggestionTapped(String suggestion) {
    setState(() {
      _controller.text = suggestion;
      _showSuggestions = false;
      _showResponse = true;
      _selectedQuestion = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate('ask_ai_title'),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).translate('ai_field_hint'),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/ai.svg',
              ),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/arrow_top.svg',
                    ),
                    onPressed: () {
                      setState(() {
                        _showSuggestions = false;
                        _showResponse = true;
                        _selectedQuestion = _controller.text;
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Adjust this value to change the height

          ),
          onChanged: _onTextChanged,
        ),
        if (_showSuggestions) ...[
          for (var suggestion in _suggestions)
            GestureDetector(
              onTap: () => _onSuggestionTapped(suggestion),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey[500],
                child: Text(
                  suggestion,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
        if (_showResponse)
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 16),
            color: Colors.grey[700],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedQuestion,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _showResponse = false;
                          _controller.clear();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Yes, this collection is suitable for evening outings. The sleek, long black dress and chic combat boots create a sophisticated yet edgy look perfect for a night out.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
