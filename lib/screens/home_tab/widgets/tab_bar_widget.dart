import 'package:flutter/material.dart';
class CircleTabIndicator extends Decoration {
  @override
  _CirclePainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(this, onChanged);
  }
}

class _CirclePainter extends BoxPainter {
  final CircleTabIndicator decoration;

  _CirclePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = Color(0xFFDC4D28); // Customize the circle color here
    canvas.drawCircle(Offset(rect.center.dx, rect.center.dy*1.6), 2.0, paint);
  }
}

class TabBarItemBased extends StatelessWidget {
  const TabBarItemBased({super.key});

  @override
  Widget build(BuildContext context) {




    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          child: DefaultTabController(
            initialIndex: 1,
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Center(child: const Text('ITEM BASED')),
                bottom: TabBar(
                  indicator: CircleTabIndicator(),
                  // Use the custom CircleTabIndicator
                  unselectedLabelColor: Colors.grey,
                  // Set the color for unselected tabs
                  dividerColor: Colors.transparent,
                  tabs: <Widget>[

                    Tab(
                      text: 'Jackets',
                    ),
                    Tab(
                      text: 'Blue Jeans',
                    ),
                    Tab(
                      text: 'Dress',
                    ),
                    Tab(
                      text: 'Sneakers',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  buildImageList(),
                  buildImageList(),
                  buildImageList(),
                  buildImageList(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Explore More', style: Theme.of(context).textTheme.bodyLarge,),
            Icon(Icons.arrow_forward)
          ],
        )
      ],
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

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(2.0),
          child: Image.asset(
            imageUrls[index],
            width: 120,
            height: 300,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}





