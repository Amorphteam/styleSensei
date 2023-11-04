import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
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
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeTab(homeCubit: context.read<HomeCubit>()),
      // Pass the HomeCubit to the first screen
      Container(
        color: Colors.orangeAccent,
      ),
      Container(
        color: Colors.red,
      ),
    ];

    return Scaffold(
      body: _screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  final HomeCubit homeCubit;

  HomeTab({Key? key, required this.homeCubit}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.homeCubit.fetchData(CollectionRepository());
    });
    super.initState();
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
                        'Hello there!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Let’s find your signature look',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/large_text_logo.png',
                    width: 12,
                  )
                ],
              )),
          SizedBox(height: 8),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is CollectionListLoadedState) {
                List<Collections> collections =
                    state.collectionModel.collections;
                return StaggeredGridView(collections: collections);
              } else if (state is HomeLoadingState) {
                return Center(child: Container(
                    width: 200,
                    height: 100,
                    child: Lottie.asset('assets/json/loading.json')),);
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
}
