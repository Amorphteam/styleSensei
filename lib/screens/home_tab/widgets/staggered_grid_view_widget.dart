import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:style_sensei/models/Collections.dart';
import 'package:style_sensei/utils/untitled.dart';

class StaggeredGridView extends StatefulWidget {
  final List<Collections> collections;

  const StaggeredGridView({Key? key, required this.collections})
      : super(key: key);

  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

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
      physics: NeverScrollableScrollPhysics(),
      // to disable GridView's scrolling
      shrinkWrap: true,
      // You won't see infinite size error
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < widget.collections.length) {
            return Column(
              children: [
                Expanded(
                  child: ImageTile(
                    collections: widget.collections,
                    index: index,
                    hasSeeDetail: true,
                  ),
                ),
                Row(
                  children: [
                    Gap(10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(parseTitle(widget.collections[index].title, (isArabic)?'ar':'en'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    IconButton(
                        icon: ColorFiltered(
          colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
          ),
          child: SvgPicture.asset('assets/images/like.svg')),
                        onPressed: () {}),
                    IconButton(
                        icon: ColorFiltered(
          colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
          ),
          child: SvgPicture.asset('assets/images/dislike.svg')),
                        onPressed: () {}),
                    Gap(10),
                  ],
                ),
                Gap(20)
              ],
            );
          } else {
            return null; // Return null for indexes beyond the limit to avoid rendering empty spaces
          }
        },
        // Set the childCount to the totalImages
        childCount: widget.collections.length,
      ),
    );
  }

  String parseTitle(dynamic title, String language) {
    if (title is String) {
      try {
        final decoded = json.decode(title);
        if (decoded is Map<String, dynamic> && decoded.containsKey(language)) {
          return decoded[language];
        }
      } catch (e) {
        // If json.decode throws an error, title is not a JSON string.
        return title;
      }
    }
    return title; // Return the original title if it's not a JSON string
  }

}
