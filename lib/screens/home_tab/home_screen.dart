import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import '../../models/Collections.dart';
import '../../utils/untitled.dart';
import '../splash/splash_screen.dart';
import '../common/widget/image_card.dart';
import 'widgets/bullet_point.dart';
import '../style/cubit/style_cubit.dart';
import '../style/style_screen.dart';
import 'widgets/staggered_grid_view_widget.dart';
import 'widgets/staggered_grid_view2_widget.dart';
import 'widgets/tab_bar_widget.dart';

class HomeTab extends StatefulWidget {
  final HomeCubit homeCubit;
  List<List<int>> collectionTags;



  HomeTab({Key? key, required this.homeCubit, required this.collectionTags})
      : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<ImageItem> imageAssetsUrl = [];
  String styleName = '';
  List<String> styleDescriptions = [];
  List<int> selectedTags = [];
  Map<String, ImageItem> selectedChoices = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
    imageAssetsUrl = searchingTag();
    styleName = getStyleName();
    styleDescriptions = getDesStyle();
    selectedTags = widget.collectionTags.expand((i) => i).toList();
  }

  void getData() {
    // Set<int> uniqueTags = Set.from(widget.collectionTags.expand((i) => i));
    // uniqueTags.addAll(tags.expand((i) => i));
    // widget.collectionTags = [uniqueTags.toList()];
    widget.collectionTags.removeWhere((tags) => tags.isEmpty);
    widget.homeCubit.fetchData(CollectionRepository(), widget.collectionTags);
  }

  void addTags(List<int> newTags) {
    setState(() {
      widget.collectionTags.add(newTags);
    });
    getData();
  }




  void _showOptions(BuildContext context, String title, List<ImageItem> options) {
    Locale locale = Localizations.localeOf(context);
    bool isArabic = locale.languageCode == 'ar';

    showModalBottomSheet(
       backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Wrap(
              children: options.map((ImageItem option) {
                String displayText = isArabic ? option.arDes : option.des;
                return ListTile(
                  title: Text(displayText),
                  onTap: () {
                    setState(() {
                      selectedChoices[title] = option;
                    });
                    addTags(getSelectedOptionIds());
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  List<int> getSelectedOptionIds() {
    return selectedChoices.values.map((item) => item.tag).toList();
  }

  void _handleChipSelection(int tag, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedTags.add(tag);
      } else {
        selectedTags.remove(tag);
      }
      // Call a method to filter your content based on selectedTags
      // For example, you could call a Bloc event to fetch filtered data
    });
  }

  @override
  Widget build(BuildContext context) {

    imageAssetsUrl.shuffle();
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 8),
          // Center(
          //   child: Container(
          //     color: Colors.white,
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         children: <Widget>[
          //           Container(
          //             alignment: Alignment.centerLeft,
          //             // Align the text to the right side of the container
          //
          //             child: Text(
          //               'Hello there!',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .titleMedium
          //                   ?.copyWith(fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Image.asset(
          //                   'assets/images/circle.png',
          //                   width: 50,
          //                   height: 50,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: RichText(
          //                   text: TextSpan(
          //                     style: Theme.of(context).textTheme.titleSmall, // Default text style
          //                     children: <TextSpan>[
          //                       TextSpan(text: 'It looks like your top choices revolve around '),
          //                       TextSpan(
          //                         text: '$styleName',
          //                         style: TextStyle(fontWeight: FontWeight.bold),
          //                       ),
          //                       TextSpan(text: ' attire.'),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //
          //           SizedBox(height: 24.0),
          //           // Placeholder for images, you would use Image.asset or Image.network instead
          //           Container(
          //             width: MediaQuery.of(context).size.width * 0.8,
          //             child: Row(
          //               children: [
          //                 // Left image
          //                 Transform.rotate(
          //                   angle: -0.2,
          //                   // Adjust the angle to tilt the card to the left
          //                   child: ImageCard(assetName: imageAssetsUrl[0].path),
          //                 ),
          //                 // Right image
          //
          //                 // Center image (no rotation)
          //                 Transform.rotate(
          //                   angle: 0.0,
          //                   // Adjust the angle to tilt the card to the right
          //                   child: ImageCard(assetName: imageAssetsUrl[1].path),
          //                 ),
          //                 Transform.rotate(
          //                   angle: 0.1,
          //                   // Adjust the angle to tilt the card to the right
          //                   child: ImageCard(assetName: imageAssetsUrl[2].path),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(height: 24.0),
          //           Row(
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Image.asset(
          //                   'assets/images/cards.png',
          //                   width: 40,
          //                   height: 40,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Text(
          //                     'Based on your preferences, you might prefer these styles:',
          //                     style: Theme.of(context).textTheme.titleSmall),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 16.0),
          //           ListView.builder(
          //             physics: NeverScrollableScrollPhysics(), // Disable scrolling for the nested ListView.builder
          //             shrinkWrap: true, // Use this to fit the ListView into the available space
          //             itemCount: styleDescriptions.length,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(left: 20, right: 20),
          //                 child: BulletPoint(text: styleDescriptions[index]),
          //               );
          //             },
          //           ),
          //           SizedBox(height: 16.0),
          //           TextButton(
          //             onPressed: () async {
          //               await Future.delayed(Duration(microseconds: 200));
          //               final imageSelectionCubit =
          //                   ImageSelectionCubit(); // Create an instance of HomeCubit
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => BlocProvider(
          //                     create: (context) => imageSelectionCubit,
          //                     child: StyleScreen(),
          //                   ),
          //                 ),
          //               );
          //             },
          //             child: RichText(
          //               text: TextSpan(
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .labelSmall, // Default text style
          //                 children: [
          //                   TextSpan(
          //                     text:
          //                         'If the result doesn\'t match your style, ', // Unstyled part
          //                   ),
          //                   TextSpan(
          //                     text: 'Try the test again', // Styled part
          //                     style: TextStyle(
          //                         color: Colors.red), // Apply the red color
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate('home_title'),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context).translate('home_des'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  {'title': AppLocalizations.of(context).translate('occasion_wear'), 'options': occasionWear},
                  {'title': AppLocalizations.of(context).translate('seasonal_style'), 'options': seasonalStyle},
                  {'title': AppLocalizations.of(context).translate('hijab_preferences'), 'options': hijabPreferences},
                ].map((Map<String, dynamic> filter) {
                  String title = filter['title'];
                  List<ImageItem> options = filter['options'];
                  bool isSelected = selectedChoices.containsKey(title);

                  Widget chipLabel = isSelected
                      ? Text(selectedChoices[title]!.des)
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title),
                      Icon(Icons.arrow_drop_down),
                    ],
                  );

                  return GestureDetector(
                    onTap: () => _showOptions(context, title, options),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: chipLabel,
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(context).colorScheme.onInverseSurface,
                        deleteIcon: isSelected ? Icon(Icons.close, size: 16,) : null,
                        onDeleted: isSelected
                            ? () {
                          setState(() {
                            int tagToRemove = selectedChoices[title]!.tag;
                            selectedChoices.remove(title);
                            widget.collectionTags = widget.collectionTags.map((tagsList) {
                              return tagsList.where((tag) => tag != tagToRemove).toList();
                            }).where((tagsList) => tagsList.isNotEmpty).toList(); // Remove empty lists
                          });
                          getData();
                        }
                            : null,
                        side: BorderSide.none,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 8),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is CollectionListLoadedState) {
                List<Collections> collections =
                    state.collectionModel.collections;
                return StaggeredGridView(collections: collections);
              } else if (state is HomeErrorState) {
                return Text('error is ${state.error}');
              } else {
                return Text('');
              }
            },
          ),
          // SizedBox(height: 8),
          // Image.network(
          //     'https://marketplace.canva.com/EAFWecuevFk/1/0/1600w/canva-grey-brown-minimalist-summer-season-collections-banner-landscape-VXEmg9V800o.jpg'),
          // SizedBox(height: 28),
          // StaggeredGridView2(),
          // SizedBox(height: 28),
          // TabBarItemBased(),
          // SizedBox(height: 28),
          // StaggeredGridView2(),
        ],
      ),
    );
  }

  List<ImageItem> searchingTag() {
    List<ImageItem> results = [];
    for (List<int> group in widget.collectionTags) {
      for (int searchId in group) {
        results.addAll(images.where((item) => item.tag == searchId));
      }
    }
    return results;
  }

  String getStyleName() {
    Set<String> uniqueResults = Set();
    for (List<int> group in widget.collectionTags) {
      for (int searchId in group) {
        for (var item in images.where((item) => item.tag == searchId)) {
          String pathWithoutNumber = item.path.replaceAll(RegExp(r'\d+\.jpeg$'), '.jpeg');
          uniqueResults.add(pathWithoutNumber
              .replaceAll('assets/images/', '')
              .replaceAll('.jpeg', ''));
        }
      }
    }
    return uniqueResults.join(', ');
  }


  List<String> getDesStyle() {
    List<String> results = [];
    for (List<int> group in widget.collectionTags) {
      for (int searchId in group) {
        for (var item in images.where((item) => item.tag == searchId)) {
          results.add(item.des);
        }
      }
    }
    results = results.toSet().toList();
    return results;
  }



}
