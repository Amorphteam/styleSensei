import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:style_sensei/screens/saved_tab/cubit/saved_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../new_models/attribute.dart';
import '../../new_models/product.dart';
import '../../repositories/collection_repository.dart';
import '../../utils/AppLocalizations.dart';
import '../../utils/untitled.dart';
import '../detail_screen/widgets/image_popup_dialog.dart';

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
    return Container(
        color: Colors.white,
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
                    Image.asset(
                      'assets/images/large_text_logo.png',
                      width: 12,
                    )
                  ],
                )),
            BlocBuilder<SavedCubit, SavedState>(
              builder: (context, state) {
                if (state is ProductListLoadedState) {
                  products = state.products?.products;
                  groupedProducts = groupProductsByCategory(products ?? []);
                   categories = groupedProducts?.keys.toList();

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
                                  // Initialize the bookmark state for this item if it has not been done yet

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
                                                icon: SvgPicture.asset(
                                                  'assets/images/remove.svg', // Path to your SVG file
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    final productIdString = productItem.id.toString();
                                                    // Toggle the bookmark state
                                                    bool isBookmarked = bookmarkedItems[productIdString] ?? false;
                                                    bookmarkedItems[productIdString] = !isBookmarked;

                                                    if (!isBookmarked) {
                                                      // Remove the product from the bookmark list
                                                      bookmarkedItems.remove(productIdString);
                                                      bookmarkIds.remove(productItem.id);
                                                    }

                                                    products?.remove(productItem);
                                                    groupedProducts = groupProductsByCategory(products ?? []);
                                                    categories = groupedProducts?.keys.toList();
                                                    saveBookmarkedItems(bookmarkedItems);

                                                  });
                                                },
                                              ),

                                            )),
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
                        child: Lottie.asset('assets/json/loading.json')),
                  );
                } else if (state is SavedErrorState) {
                  return Text('error is ${state.error}');
                } else {
                  return Lottie.asset('assets/json/large_loading.json',
                      repeat: false);
                }
              },
            )
          ],
        ));
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
