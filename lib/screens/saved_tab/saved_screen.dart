import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/screens/saved_tab/cubit/saved_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import '../../new_models/attribute.dart';
import '../../new_models/product.dart';
import '../../repositories/collection_repository.dart';
import '../../utils/AppLocalizations.dart';
import '../../utils/analytics_helper.dart'; // Import Analytics Helper
import '../../utils/survey_helper.dart';
import '../../utils/untitled.dart';
import '../detail_screen/widgets/single_item_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<int> bookmarkIds = [];
  Map<String, bool> bookmarkedItems = {};
  List<Product>? products;
  Map<String, List<Product>>? groupedProducts;
  List<String>? categories;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadBookmarkedItems().then((Map<String, bool> bookmarkedItemIds) {
        bookmarkIds = bookmarkedItemIds.keys.map(int.parse).toList();
        setState(() {
          bookmarkedItems = bookmarkedItemIds;
        });
        if (bookmarkIds.isNotEmpty) {
          BlocProvider.of<SavedCubit>(context)
              .fetchData(CollectionRepository(), bookmarkIds);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
        child: ListView(
          children: [
            SizedBox(height: 8),
            Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('saved_title'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            BlocBuilder<SavedCubit, SavedState>(
              builder: (context, state) {
                if (state is ProductListLoadedState) {
                  products = state.products?.products;
                  groupedProducts = groupProductsByCategory(products ?? []);
                  categories = groupedProducts?.keys.toList();

                  // Log the view_saved_items event here
                  _logViewSavedItemsEvent(categories ?? [], products?.length ?? 0);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categories!.map((categoryName) {
                      final productsInCategory = groupedProducts![categoryName]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categoryName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: productsInCategory.map((productItem) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                                    imageUrl: productItem.pictures!.split(',')[0],
                                                    fit: BoxFit.cover,
                                                    height: MediaQuery.of(context).size.height * 0.34,
                                                    width: MediaQuery.of(context).size.width * 0.44,
                                                    placeholder: (context, url) => Shimmer.fromColors(
                                                      baseColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                                      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height * 0.29,
                                                        width: MediaQuery.of(context).size.width * 0.33,
                                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url, error) {
                                                      return Icon(Icons.error);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 12.0),
                                                child: Text(
                                                  getBrandName(productItem.attributes) ?? 'Unknown',
                                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                      fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 12.0),
                                                child: Text(
                                                  isArabic ? productItem.arabic_name! : productItem.name!,
                                                  style: Theme.of(context).textTheme.labelSmall,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                } else if (state is SavedLoadingState) {
                  return Center(
                    child: Container(
                      width: 200,
                      height: 100,
                      child: Lottie.asset('assets/json/loading.json'),
                    ),
                  );
                } else if (state is SavedErrorState) {
                  return Text(AppLocalizations.of(context).translate('error'));
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        isDarkMode ? 'assets/json/large_loading_dark.json' : 'assets/json/large_loading.json',
                        repeat: false,
                      ),
                      SizedBox(height: 20), // Adds some space between the animation and the message
                      Text(
                        AppLocalizations.of(context).translate('no_saved_items_message'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                    ],
                  );

                }
              },
            ),
          ],
        ));
  }

  void showImagePopup(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleItemScreen(
          product: product,
          bookmarkedItems: bookmarkedItems,
          loadBookmarkedItems: loadBookmarkedItems,
          saveBookmarkedItems: saveBookmarkedItems,
          onBookmarkUpdated: null,
        );
      },
    );
  }

  Future<void> _openSourceWebsite(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
    final SurveyHelper _surveyHelper = SurveyHelper();
    await _surveyHelper.incrementSessionCountPurchase();
  }

  Map<String, List<Product>> groupProductsByCategory(List<Product> products) {
    final Map<String, List<Product>> groupedProducts = {};
    for (var product in products) {
      final category = product.category?.name ?? 'Other';
      if (!groupedProducts.containsKey(category)) {
        groupedProducts[category] = [];
      }
      groupedProducts[category]!.add(product);
    }
    return groupedProducts;
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

  // Log the view_saved_items event
  void _logViewSavedItemsEvent(List<String> categories, int itemCount) {
    AnalyticsHelper.logEvent('view_saved_items', {
      'item_count': itemCount,
      'categories': categories.join(', '),  // Join categories into a string
    });
  }
}
