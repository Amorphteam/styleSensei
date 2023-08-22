import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/main/widgets/bottom_bar_widget.dart';
import '../../models/Collections.dart';
import 'widgets/staggered_grid_view_widget.dart';
import 'widgets/staggered_grid_view2_widget.dart';
import 'widgets/tab_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().fetchData(CollectionRepository());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Center(child: Text('StyleSensei')) ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Sara',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Here are our suggestions for you',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is CollectionListLoadedState){
                  List<Collections> collections = state.collectionModel.collections;
                  return StaggeredGridView(collections: collections);
                }else if (state is HomeLoadingState){
                  return Center(child: CircularProgressIndicator());
                }else if (state is HomeErrorState){
                  return Text('error is ${state.error}');
                }else {
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
      ),
      bottomNavigationBar: BottomBarScreen(),
    );
    // return Scaffold(
    //   body: ListView(
    //     children: [
    //     ],
    //   ),
    // );
  }
}
