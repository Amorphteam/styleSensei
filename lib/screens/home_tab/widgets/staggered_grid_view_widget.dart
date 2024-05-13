import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_sensei/models/Collections.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:style_sensei/utils/untitled.dart';

class StaggeredGridView extends StatefulWidget {
  final List<Collections> collections;
  final bool twoColumn;
  const StaggeredGridView({Key? key, required this.collections, required this.twoColumn})
      : super(key: key);

  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView> {
  int? dislikedIndex;
  List<Collections> mutableCollections = [];
  Set<String> likedCollections = {};
  Set<String> dislikedCollections = {};


  @override
  void initState() {
    super.initState();
    mutableCollections = List.from(widget.collections);
    loadPreferences();
  }


  void loadPreferences() async {
    likedCollections = (await getLikedCollectionIds()).toSet();
    dislikedCollections = (await getDesLikedCollectionIds()).toSet();
    if (dislikedCollections.isNotEmpty) {
      setState(() {
        mutableCollections = mutableCollections
            .where((collection) => !dislikedCollections.contains(collection.id.toString()))
            .toList();
      });

    }
  }



  void showDislikeOverlay(int index, int deslikedId) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title:  DislikeOverlay(
            onOptionSelected: (String option) {
              _deleteCollection(index, deslikedId);
            },
            onCancel: (){
              Navigator.of(dialogContext).pop();
            },
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );

  }

  void hideDislikeOverlay() {
    setState(() {
      dislikedIndex = null; // Clear the disliked image index
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (widget.twoColumn) {
      return buildMasonryGrid(isArabic);
    } else {
      return buildStaggeredGrid(isArabic);
    }
  }

  Padding buildMasonryGrid(bool isArabic) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 6,
        itemCount: mutableCollections.length,
        itemBuilder: (context, index) {
          return buildGridItem(index, isArabic, context);
        },
      ),
    );
  }


  Widget buildGridItem(int index, bool isArabic, BuildContext context) {
    final collection = mutableCollections[index];
    final isLiked = likedCollections.contains(collection.id.toString());
    double padding = 4.0;
    double imageSize = 16.0;
    var style = Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.normal);
    if (!widget.twoColumn){
      padding = 16.0;
      imageSize = 24.0;
      style = Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal);
    }

    bool showOverlay = index == dislikedIndex;

    if (index < mutableCollections.length) {
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (!widget.twoColumn)?Expanded(
              child: ImageTile(
                collections: mutableCollections,
                index: index,
                hasSeeDetail: true,
              ),
            ):
            ImageTile(
              collections: mutableCollections,
              index: index,
              hasSeeDetail: true,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: padding, left: padding),
                    child: Text(parseTitle(mutableCollections[index].title, (isArabic)?'ar':'en'),
                        textAlign: TextAlign.left,
                        style: style),
                  ),
                ),
                IconButton(
                    icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),
                        child: SvgPicture.asset((isLiked)?'assets/images/like_full.svg':'assets/images/like.svg' , width: imageSize,)),
                    onPressed: () {
                      toggleLike(collection.id);
                    }),
                IconButton(
                    icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          BlendMode.srcIn,
                        ),

                        child: SvgPicture.asset('assets/images/dislike.svg', width: imageSize,)),
                    onPressed: () {
                      checkToShowDislikeOverlay(index, collection.id);
                    }),
              ],
            ),
            Gap(imageSize)
          ],
        ),

          ]
      );
    } else {
      return Placeholder(); // Return null for indexes beyond the limit to avoid rendering empty spaces
    }
  }

  void showSnackbar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        duration: Duration(seconds: 3),
      ),
    );
  }

  String parseTitle(dynamic title, String language) {

    if (title is String) {
      title = title.replaceAll("@", "");
      try {
        final decoded = json.decode(title);
        if (decoded is Map<String, dynamic> && decoded.containsKey(language)) {
          return decoded[language];
        }
      } catch (e) {
        return title;
      }
    }
    return title;
  }

  void checkToShowDislikeOverlay(int index, int deslikedId) async {
    bool dontShowDialog = await getNoShowPreference();
    if (!dontShowDialog) {
      showDislikeOverlay(index, deslikedId);
    } else {
      _deleteCollection(index, deslikedId);
    }
  }

    void toggleLike(int id) {
      final idStr = id.toString();
      setState(() {
        if (likedCollections.contains(idStr)) {
          likedCollections.remove(idStr);
        } else {
          likedCollections.add(idStr);
        }
        saveLikedCollectionId(idStr);
      });

  }

  void _deleteCollection( int index, int deslikedId) {
    saveDesLikedCollectionId(deslikedId.toString());
    setState(() {
      mutableCollections.removeAt(index);
    });
    showSnackbar(context, AppLocalizations.of(context).translate('dislike_snackbar_title'));
  }

  Widget buildStaggeredGrid(bool isArabic) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 1,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.same,
        pattern: [
          QuiltedGridTile(2, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
          return buildGridItem(index, isArabic, context);
        },
        // Set the childCount to the totalImages
        childCount: mutableCollections.length,
      ),
    );

  }

}
