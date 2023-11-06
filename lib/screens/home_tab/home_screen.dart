import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import '../../models/Collections.dart';
import '../splash/splash_screen.dart';
import '../style/cubit/image_selection_cubit.dart';
import '../style/image_selection_screen.dart';
import 'widgets/staggered_grid_view_widget.dart';
import 'widgets/staggered_grid_view2_widget.dart';
import 'widgets/tab_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  final List<int> collectionTags;
  const MyHomePage({super.key, required this.collectionTags});

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
      HomeTab(homeCubit: context.read<HomeCubit>(), collectionTags: widget.collectionTags,),
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
  final List<int> collectionTags;

  HomeTab({Key? key, required this.homeCubit, required this.collectionTags}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.homeCubit.fetchData(CollectionRepository(), widget.collectionTags);
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
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: <Widget>[

                  Container(
                    alignment: Alignment.centerLeft, // Align the text to the right side of the container

                    child: Text(

                      'Hello there!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/circle.png', width: 50, height: 50,),
                      ),
                      Expanded(
                        child: Text(
                          'It looks like your top choices revolve around elegant, monochromatic, and formal attire.',
                          style: Theme.of(context).textTheme.titleSmall
                          ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.0),
                  // Placeholder for images, you would use Image.asset or Image.network instead
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        0.8,
                    child: Row(
                      children: [
                        // Left image
                        Transform.rotate(
                          angle: -0.2, // Adjust the angle to tilt the card to the left
                          child: ImageCard(assetName: 'assets/images/0.png'),
                        ),
                        // Right image

                        // Center image (no rotation)
                        Transform.rotate(
                          angle: 0.0, // Adjust the angle to tilt the card to the right
                          child: ImageCard(assetName: 'assets/images/1.png'),

                        ),
                        Transform.rotate(
                          angle: 0.1, // Adjust the angle to tilt the card to the right
                          child: ImageCard(assetName: 'assets/images/2.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/cards.png', width: 40, height: 40,),
                      ),
                      Expanded(
                        child: Text(
                            'Based on your preferences, you might prefer these styles:',
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: BulletPoint(text: 'Classic Timeless, well-tailored, and formal.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: BulletPoint(text: 'Minimalist Simple and monochromatic.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: BulletPoint(text: 'Chic Sophisticated and refined.'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () async {
                      await Future.delayed(Duration(microseconds: 200));
                      final imageSelectionCubit =
                      ImageSelectionCubit(); // Create an instance of HomeCubit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => imageSelectionCubit,
                            child: ImageSelectionScreen(),
                          ),
                        ),
                      );
                      },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.labelSmall, // Default text style
                        children: [
                          TextSpan(
                            text: 'If the result doesn\'t match your style, ', // Unstyled part
                          ),
                          TextSpan(
                            text: 'Try the test again', // Styled part
                            style: TextStyle(color: Colors.red), // Apply the red color
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Let’s find your signature look',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
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
