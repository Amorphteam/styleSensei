import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import '../../models/Collections.dart';
import '../../utils/untitled.dart';
import 'widgets/staggered_grid_view_widget.dart';

class HomeTab extends StatefulWidget {
  final HomeCubit homeCubit;

  HomeTab({Key? key, required this.homeCubit}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<List<int>> collectionTags = [];
  List<ImageItem> imageAssetsUrl = [];
  String styleName = '';
  List<String> styleDescriptions = [];
  List<int> selectedTags = [];
  Map<String, ImageItem> selectedChoices = {};
  String selectedTagsString = '';
  bool _twoColumn = true;
  bool isArabic = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    imageAssetsUrl = searchingTag();
    styleName = getStyleName();
    styleDescriptions = getDesStyle();
  }

  void getData() {
    widget.homeCubit.fetchData(CollectionRepository(), tags: collectionTags);
  }

  void searchForTagName() {
    List<List<ImageItem>> allItems = [
      images,
      bodyTypes,
      colorTones,
      occasionWear,
      seasonalStyle,
      clothingPreferences,
      hijabPreferences
    ];
    Map<int, String> lookupTable = buildLookupTable(allItems);
    List<int> codesToLookup = collectionTags.expand((i) => i).toList();
    List<String> descriptions =
        getDescriptionsFromCodes(codesToLookup, lookupTable);

    String finalDescription = descriptions.map((desc) {
      int colonIndex = desc.indexOf(':');
      return colonIndex != -1 ? desc.substring(0, colonIndex) : desc;
    }).join('\n');

    setState(() {
      selectedTagsString = finalDescription;
    });
  }

  void addTags(List<int> newTags) {
    setState(() {
      collectionTags.add(newTags);
    });
    getData();
  }

  void _showOptions(
      BuildContext context, String title, List<ImageItem> options) {


    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      builder: (BuildContext context) {
        return Padding(
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
        );
      },
    );
  }

  List<int> getSelectedOptionIds() {
    List<int> flattenedTags =
        collectionTags.expand((sublist) => sublist).toList();
    List<int> filteredTags = selectedChoices.values.where((item) {
      return !flattenedTags.contains(item.tag);
    }).map((item) {
      return item.tag;
    }).toList();

    return filteredTags;
  }

  @override
  void dispose() {
    super.dispose();
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
    Locale locale = Localizations.localeOf(context);
    isArabic = locale.languageCode == 'ar';
    imageAssetsUrl.shuffle();
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Column(
                children: [
                  buildAppBarTitle(context),
                  buildChips(context)
                ],
              ),
              floating: true,
              snap: true,
              centerTitle: false,
              toolbarHeight: kToolbarHeight*2,
              pinned: false,
            ),

          ];
        },
        body: buildContent(context),
      ),
    );
  }

  Row buildAppBarTitle(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('home_title'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   AppLocalizations.of(context).translate('home_des'),
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyMedium
                  //       ?.copyWith(fontWeight: FontWeight.normal),
                  // ),

                ],
              ),
            ),
            IconButton(onPressed: (){
              setState(() {
                _twoColumn = !_twoColumn;
              });

            }, icon: SvgPicture.asset(_twoColumn ? 'assets/images/cat.svg' : 'assets/images/full.svg', color: Theme.of(context).colorScheme.onSurface),
            ),

          ]
        );
  }

  Widget buildChips(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            {
              'title':
                  AppLocalizations.of(context).translate('occasion_wear'),
              'options': occasionWear
            },
            {
              'title': AppLocalizations.of(context)
                  .translate('seasonal_style'),
              'options': seasonalStyle
            },
            {
              'title': AppLocalizations.of(context)
                  .translate('hijab_preferences'),
              'options': hijabPreferences
            },
          ].map((Map<String, dynamic> filter) {
            String title = filter['title'];
            List<ImageItem> options = filter['options'];
            bool isSelected = selectedChoices.containsKey(title);

            Widget chipLabel = isSelected
                ? Text((isArabic)?selectedChoices[title]!.arDes:selectedChoices[title]!.des, style: Theme.of(context).textTheme.bodyMedium,)
                : Container(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.bodyMedium,),
                        Icon(Icons.arrow_drop_down, size: 16, color: Theme.of(context).colorScheme.onSurface),
                      ],
                    ),
                );

            return GestureDetector(
              onTap: () => _showOptions(context, title, options),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(
                  label: chipLabel,
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.inversePrimary.withOpacity(0.4)
                      : Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.3),
                  deleteIcon: isSelected
                      ? Icon(
                          Icons.close,
                          size: 16,
                        )
                      : null,
                  onDeleted: isSelected
                      ? () {
                          setState(() {
                            int tagToRemove = selectedChoices[title]!.tag;
                            selectedChoices.remove(title);
                            collectionTags = collectionTags
                                .map((tagsList) {
                                  return tagsList
                                      .where((tag) => tag != tagToRemove)
                                      .toList();
                                })
                                .where((tagsList) => tagsList.isNotEmpty)
                                .toList(); // Remove empty lists
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
    );
  }

  Container buildContent(BuildContext context) {
    return Container(
      // Ensure that no unnecessary padding is added
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SelectedTagLoadedState) {
            collectionTags = state.selectedTags;
            selectedTags = collectionTags.expand((i) => i).toList();
            searchForTagName();
            print('collectionTags: $collectionTags');
          }
        },
        builder: (context, state) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is CollectionListLoadedState) {
                List<Collections> collections = state.collectionModel.collections;
                collections.shuffle(Random());
                return StaggeredGridView(
                  collections: collections,
                  twoColumn: _twoColumn,
                );
              } else if (state is HomeErrorState) {
                return Center( // Center the error message
                  child: Text(AppLocalizations.of(context).translate('error')),
                );
              } else {
                return Center( // Center the loading indicator or empty state
                  child: Text(''),
                );
              }
            },
          );
        },
      ),
    );
  }

  List<ImageItem> searchingTag() {
    List<ImageItem> results = [];
    for (List<int> group in collectionTags) {
      for (int searchId in group) {
        results.addAll(images.where((item) => item.tag == searchId));
      }
    }
    return results;
  }

  String getStyleName() {
    Set<String> uniqueResults = Set();
    for (List<int> group in collectionTags) {
      for (int searchId in group) {
        for (var item in images.where((item) => item.tag == searchId)) {
          String pathWithoutNumber =
              item.path.replaceAll(RegExp(r'\d+\.jpeg$'), '.jpeg');
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
    for (List<int> group in collectionTags) {
      for (int searchId in group) {
        for (var item in images.where((item) => item.tag == searchId)) {
          results.add(item.des);
        }
      }
    }
    results = results.toSet().toList();
    return results;
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay
    getData();
  }

}
