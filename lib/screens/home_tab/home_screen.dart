import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
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
  final List<int> collectionTags;

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
  Map<int, String> selectedChoices = {};

  void _updateSelectedChoice(int tag, String choice) {
    setState(() {
      selectedChoices[tag] = choice;
    });
    // You can also call a method to filter your content based on selectedChoices here
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.homeCubit.fetchData(CollectionRepository(), widget.collectionTags);
    });
    imageAssetsUrl = searchingTag();
    styleName = getStyleName();
    styleDescriptions = getDesStyle();
    selectedTags = List.from(widget.collectionTags);

    super.initState();
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
      color: Colors.white,
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
                  'Here are your personalized picks',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'We refine your collection with each like and dislike.',
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
                children: widget.collectionTags.map((int tag) {
                  // Use the selected choice as the chip label if it exists, otherwise use a default label
                  final tagName = selectedChoices.containsKey(tag)
                      ? '${getTagName(tag)}: ${selectedChoices[tag]!}'
                      : getTagName(tag);

                  // Decide the chip color based on whether an option is selected
                  final chipColor = selectedChoices.containsKey(tag)
                      ? Theme.of(context).colorScheme.inversePrimary // Selected color
                      : Colors.grey[100]; // Default color

                  // Decide the text color based on whether an option is selected
                  final textColor = selectedChoices.containsKey(tag)
                      ? Theme.of(context).colorScheme.onBackground // For selected chip
                      : Theme.of(context).colorScheme.onSurface; // For default chip

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: ActionChip(
                      label: Text(tagName),
                      backgroundColor: chipColor, // Use the dynamic background color
                      labelStyle: TextStyle(color: textColor), // Use the dynamic text color
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Wrap(
                              children: [
                                // Title for the BottomSheet based on the chip that was tapped
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('$tagName',
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),),
                                ...['Option 1', 'Option 2', 'Option 3'].map((String choice) => ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(choice),
                                  ),
                                  onTap: () {
                                    // Update the selected choice when tapped
                                    _updateSelectedChoice(tag, choice);
                                    Navigator.pop(context); // Close the BottomSheet
                                  },
                                )),
                              ],
                            );
                          },
                        );
                      },
                      side: BorderSide.none,
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
    List<ImageItem> results =
        []; // Initialize an empty list to store the results

    for (int searchId in widget.collectionTags) {
      results.addAll(images.where((item) => item.tag == searchId));
    }
    return results; // Return the aggregated results
  }

  String getStyleName() {
    Set<String> uniqueResults = Set(); // Use a set to store unique results.

    for (int searchId in widget.collectionTags) {
      for (var item in images.where((item) => item.tag == searchId)) {
        // Use a regular expression to remove numbers before .jpeg and add the processed path to the set.
        String pathWithoutNumber =
            item.path.replaceAll(RegExp(r'\d+\.jpeg$'), '.jpeg');
        uniqueResults.add(pathWithoutNumber
            .replaceAll('assets/images/', '')
            .replaceAll('.jpeg', ''));
      }
    }

    // Join all the unique results into a string, separated by a comma and a space.
    return uniqueResults.join(', ');
  }

  List<String> getDesStyle() {
    List<String> results = []; // Initialize an empty list to store the results

    for (int searchId in widget.collectionTags) {
      for (var item in images.where((item) => item.tag == searchId)) {
        results.add(item.des);
      }
    }

    // Remove duplicates by converting the list to a set and back to a list
    results = results.toSet().toList();

    return results; // Return the aggregated results without duplicates
  }

  String getTagName(int tag) {
    return 'tag with id $tag';
  }
}
