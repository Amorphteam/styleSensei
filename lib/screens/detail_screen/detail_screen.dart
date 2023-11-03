import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DetailCubit>(context).fetchData(CollectionRepository(), widget.index);
    });
  }

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
        body: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state is ProductListLoadedState) {
              var collection = state.productModel.collection?.title;
              return Text(collection.toString());
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
}
