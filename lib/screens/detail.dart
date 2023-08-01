import 'package:flutter/material.dart';
import 'package:style_sensei/widget/staggered_grid_view.dart';
import 'package:style_sensei/widget/staggered_grid_view_detail.dart';
import '../untitled.dart';
import '../widget/tab_bar.dart';

class Detail extends StatefulWidget {
  final int index;

  Detail({required this.index});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400.0,
              // Set the initial height of the AppBar
              floating: false,
              // Set to true if you want it to be always visible when scrolling
              pinned: true,
              // Set to true if you want it to remain visible at the top when scrolling
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  // Replace this with your large image asset
                  'assets/images/1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            StaggeredGridViewDetail(),
            StaggeredGridViewDetail(),
            StaggeredGridViewDetail(),
            SizedBox(height: 40,),
            Center(child: Text('YOU MAY ALSO LIKE')),
            SizedBox(height: 20,),
            buildImageList(),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildImageList() {
    // Replace the list 'imageUrls' with your own list of image URLs.
    List<String> imageUrls = [
      'assets/images/s1.png',
      'assets/images/s2.png',
      'assets/images/s3.png',
      'assets/images/s4.png',
    ];

    return Column(
      children: [
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(2.0),
                child: Image.asset(
                  imageUrls[index],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
