import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/untitled.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<String> bookmarkIds = [];

  @override
  void initState() {
    super.initState();
    loadBookmarkedItems().then((bookmarkedItemIds) {
      bookmarkIds = bookmarkedItemIds.keys.toList();
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
                        'Saved Products',
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
          Lottie.asset('assets/json/large_loading.json', repeat: false),

        ],
      ));
  }
}
