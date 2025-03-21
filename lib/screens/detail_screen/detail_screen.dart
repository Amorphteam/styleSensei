import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_sensei/models/ProductsModel.dart';
import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/detail_screen/widgets/chat_widget.dart';
import 'package:style_sensei/screens/detail_screen/widgets/loading_animation.dart';
import 'package:style_sensei/screens/detail_screen/widgets/sekeleton_loading.dart';
import 'package:style_sensei/screens/detail_screen/widgets/single_item_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/Collections.dart';
import '../../models/Rules.dart';
import '../../new_models/attribute.dart';
import '../../new_models/collection_item.dart';
import '../../new_models/product.dart';
import '../../repositories/collection_repository.dart';
import '../../utils/analytics_helper.dart';
import '../../utils/survey_helper.dart';
import '../survey/survey_config.dart';
import '../../utils/untitled.dart';
import '../home_tab/widgets/tab_bar_widget.dart';
import '../survey/survey_multiple_choice.dart';
import 'cubit/detail_state.dart';

class Detail extends StatefulWidget {
  final Collections collection;

  Detail({required this.collection});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, bool> bookmarkedItems = {};
  int sessionCount = 0;
  final SurveyHelper _surveyHelper = SurveyHelper();


  @override
  void initState() {
    super.initState();

    _handleSessionCountAndSurvey();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        // Log 'click_collection_details' event
        AnalyticsHelper.logEvent('click_collection_details', {
          'collection_id': widget.collection.id.toString(),
        });
        context.read<DetailCubit>().fetchCollectionDetail(CollectionRepository(), widget.collection.id);
      } else if (_tabController.index == 1) {
        // Log 'click_collection_items' event
        AnalyticsHelper.logEvent('click_collection_items', {
          'collection_id': widget.collection.id.toString(),
        });
        context.read<DetailCubit>().fetchCollectionItems(CollectionRepository(), widget.collection.id);
      }
    });

    // Load the first tab data initially
    context.read<DetailCubit>().fetchCollectionDetail(CollectionRepository(), widget.collection.id);

    }


  Future<void> _handleSessionCountAndSurvey() async {
    // Increment the session count each time HomeTab is opened
    await _surveyHelper.incrementSessionCountMultipleChoise();

    // Create an instance of SurveyMultistep to access its SurveyConfig
    final surveyConfig = SurveyMultipleChoice(
      onClose: () {},
      onAskMeLater: () {},
      onSend: () {},
    ).surveyConfig;

    // Check if the survey should be shown based on the SurveyConfig's initialDelay
    if (await _surveyHelper.shouldShowSurveyMultipleChoise(surveyConfig)) {
      _surveyHelper.showSurveyMultipleChoise(
        context: context,
        onClose: () async {
          await _surveyHelper.resetNextSurveySessionMultipleChoise(surveyConfig.closeDelay);
        },
        onAskMeLater: () async {
          await _surveyHelper
              .resetNextSurveySessionMultipleChoise(surveyConfig.askMeLaterDelay);
        },
        onSend: () async {
          await _surveyHelper.markSurveyAsCompletedMultipleChoise();
        },
      );
    }
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 600.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: replaceNumbersInUrl(widget.collection.image) ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: AppLocalizations.of(context).translate('collection_detail')),
                    Tab(text: AppLocalizations.of(context).translate('collection_items')),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<DetailCubit, DetailState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loadingDetail: () => SkeletonLoading(),
                            loadedDetail: (collectionDetail) => buildDetailTab(collectionDetail),
                            error: (message) => Center(child: Text(message)),
                            orElse: () => SkeletonLoading(),
                          );
                        },
                      ),
                      BlocBuilder<DetailCubit, DetailState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loadingItems: () => LoadingAnimation(),
                            loadedItems: (items, collectionDetail) => buildItemsTab(items, collectionDetail),
                            error: (message) => Center(child: Text(message)),
                            orElse: () => LoadingAnimation(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


  Widget buildDetailTab(ProductsModel collectionDetail) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16),
      child: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
Text(
            getDesPart(collectionDetail.collection?.description, 'desc', (isArabic) ? 'ar' : 'en'),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(30),
 // Text(
 //            AppLocalizations.of(context).translate('des_title'),
 //            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
 //          ),
 //          Column(
 //            children: listOfChips(collectionDetail, context),
 //          ),
 //          Gap(20),
 Text(
            AppLocalizations.of(context).translate('body_shape_question'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
 Text(
            getDesPart(collectionDetail.collection?.description, 'body_shape', (isArabic) ? 'ar' : 'en'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Gap(20),
 Text(
            AppLocalizations.of(context).translate('situation_question'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
 Text(
            getDesPart(collectionDetail.collection?.description, 'situation', (isArabic) ? 'ar' : 'en'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Gap(20),
 Text(
            AppLocalizations.of(context).translate('design_question'),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
 Text(
            getDesPart(collectionDetail.collection?.description, 'design', (isArabic) ? 'ar' : 'en'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Gap(48),
          ChatWidget(collectionDetail: collectionDetail),
        ],
      ),
    );
  }

  Widget buildItemsTab(List<CollectionItem> items, ProductsModel? collectionDetail) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // Separate items into non-empty and empty lists
    List<CollectionItem> nonEmptyItems = items.where((item) => item.products != null && item.products!.isNotEmpty).toList();
    List<CollectionItem> emptyItems = items.where((item) => item.products == null || item.products!.isEmpty).toList();

    // Combine the lists, with non-empty items first
    List<CollectionItem> sortedItems = [...nonEmptyItems, ...emptyItems];

    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: sortedItems.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCollectionItem(context, sortedItems[index], isArabic, index, collectionDetail);
      },
    );
  }


  Widget buildCollectionItem(BuildContext context, CollectionItem item, bool isArabic, int parentIndex, ProductsModel? collectionDetail) {
    List<Product> orderedProducts = item.products != null ? reorderProducts(item.products!, item.match_count ?? {}) : [];

    String? catName = AppLocalizations.of(context).translate('${item.category?.name}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (catName.length > 3) ? catName : item.category?.name ?? 'Default',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${orderedProducts.length}' + '  ' + AppLocalizations.of(context).translate('alternatives'),
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
        Gap(20),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Text(
        //     AppLocalizations.of(context).translate('attributes'),
        //     style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 16, top: 8),
        //   child: buildAttributes(collectionDetail?.collection?.rules, item.category?.id),
        // ),
        (orderedProducts.length > 0)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16, bottom: 8),
              child: Text(
                AppLocalizations.of(context).translate('products_suggestion_title'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 16, left: 16, bottom: 8),
              child: Opacity(
                opacity: 0.4,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/ai.svg',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context).translate('products_suggestion_des'),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: orderedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  int key = parentIndex * 1000 + index; // Generate unique key for each horizontal item
                  return buildProductItem(context, orderedProducts[index], isArabic);
                },
              ),
            ),
            Gap(40)
          ],
        )
            : buildEmptyItemsContainer(context),
      ],
    );
  }

  Container buildEmptyItemsContainer(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 40, top: 20),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 58),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/ai.svg',
              height: 30,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 16, left: 16, bottom: 8),
              child: Text(
                AppLocalizations.of(context).translate('no_products'),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 16, left: 16, bottom: 8),
              child: Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context).translate('no_products_desc'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      );
  }

  List<Product> reorderProducts(List<Product> products, Map<String, int> matchCount) {
    List<Product> productsCopy = List<Product>.from(products);
    productsCopy.sort((a, b) {
      int aMatch = matchCount[a.id.toString()] ?? 0;
      int bMatch = matchCount[b.id.toString()] ?? 0;
      return bMatch.compareTo(aMatch);
    });
    return productsCopy;
  }

  Widget buildProductItem(BuildContext context, Product productItem, bool isArabic) {
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
                      imageUrl: getSmallImageUrl(productItem.pictures!.split(',')[0]),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width * 0.44,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
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
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
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
                  onPressed: () => showPopupOnce(context, productItem.corresponding_url!),
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
                    ? SvgPicture.asset('assets/images/bookmarked.svg')
                    : SvgPicture.asset('assets/images/bookmark.svg'),
                onPressed: () {
                  setState(() {
                    bookmarkedItems[productItem.id.toString()] = !bookmarkedItems[productItem.id.toString()]!;
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

  List<Widget> listOfChips(ProductsModel? collectionDetail, BuildContext context) {
    List<Widget> tagWidgets = [];

    if (collectionDetail?.collection?.tags != null) {
      collectionDetail!.collection!.tags!.removeWhere((key, value) => key.contains('Hijab'));

      collectionDetail.collection?.tags?.forEach((key, value) {
        List<dynamic> tagValues = value;
        List<Widget> chips = tagValues
            .map((tag) => Chip(
          label: Text(
            AppLocalizations.of(context).translate('$tag'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.0),
          shape: StadiumBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.onBackground, // Color of the border
              width: 0.5, // Width of the border
            ),
          ),
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
                child: Text(AppLocalizations.of(context).translate('$key'),
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              Expanded(
                flex: 2,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 0.0,
                    children: chips,
                  ),
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

  Widget buildAttributes(List<Rules>? rules, String? categoryId) {
    if (rules != null) {
      List<Rules> filteredRules = rules.where((rule) => rule.categoryId == categoryId).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filteredRules.map((rule) {
          String? ruleName = AppLocalizations.of(context).translate('${rule.attribute?.name}');
          String? ruleValue = AppLocalizations.of(context).translate('${rule.attributeValue}');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(
                  (!ruleName.contains('N/A')) ? ' - $ruleName:' : ' - ${rule.attribute?.name}: ',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      '${rule.attributeValue} ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }
    return Container();
  }
}
