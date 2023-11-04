import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_sensei/models/Items.dart';
import 'package:style_sensei/screens/detail_screen/cubit/detail_cubit.dart';
import 'package:style_sensei/screens/home_tab/widgets/staggered_grid_view_widget.dart';
import 'package:style_sensei/screens/detail_screen/widgets/staggered_grid_view_detail_widget.dart';
import '../../repositories/collection_repository.dart';
import '../../utils/untitled.dart';
import '../home_tab/widgets/tab_bar_widget.dart';

class Detail extends StatefulWidget {
  final int index;

  Detail({required this.index});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String mainImageCollectionUrl = '';
  Map<String, bool> bookmarkedItems = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DetailCubit>(context)
          .fetchData(CollectionRepository(), widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 600.0,
              // Set the initial height of the AppBar
              floating: false,
              // Set to true if you want it to be always visible when scrolling
              pinned: true,
              // Set to true if you want it to remain visible at the top when scrolling

              flexibleSpace: FlexibleSpaceBar(
                background: BlocBuilder<DetailCubit, DetailState>(
                  builder: (context, state) {
                    if (state is ProductListLoadedState) {
                      return Image.network(
                        state.productModel.collection!.image!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      // Return a placeholder or empty container if the image URL is not available.
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state is ProductListLoadedState) {
              var collection = state.productModel.collection!.items;
              mainImageCollectionUrl = state.productModel.collection!.image!;

              return buildWidget(collection!);
            } else if (state is DetailLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DetailErrorState) {
              return Text('error is ${state.error}');
            } else {
              return Text('');
            }
          },
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

  Widget buildWidget(List<Items> items) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index].category!.name ?? 'Default Name',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('${items[index].products?.length ?? ' '} Items')
                  ],
                ),
              ),
              Container(
                height: 260,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (items[index].products != null)
                        ...items[index].products!.map((productItem) {
                          // Initialize the bookmark state for this item if it has not been done yet
                          bookmarkedItems[productItem.id.toString()] ??= false;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child:
                                          Image.network(productItem.pictures!),
                                    ),
                                    Text(productItem
                                        .attributes!.last.attribute!.name!),
                                  ],
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
                                      icon: bookmarkedItems[productItem.id.toString()]!
                                          ? SvgPicture.asset(
                                        'assets/images/bookmarked.svg', // Path to your SVG file
                                      )
                                          : SvgPicture.asset(
                                        'assets/images/bookmark.svg', // Path to your SVG file
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // Toggle the bookmark state
                                          bookmarkedItems[
                                                  productItem.id.toString()] =
                                              !bookmarkedItems[
                                                  productItem.id.toString()]!;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
