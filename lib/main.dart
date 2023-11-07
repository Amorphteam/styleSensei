import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_sensei/screens/profile_tab/profile_screen.dart';
import 'package:style_sensei/screens/saved_tab/saved_screen.dart';
import 'package:style_sensei/screens/splash/cubit/splash_cubit.dart';
import 'package:style_sensei/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Sensei',
      theme: ThemeData(
        fontFamily: 'centrale',
        useMaterial3: true,

      ),
      home: BlocProvider(
        create: (context) => SplashCubit(),
        child: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
      HomeTab(
        homeCubit: context.read<HomeCubit>(),
        collectionTags: widget.collectionTags,
      ),
      // Pass the HomeCubit to the first screen
      SavedScreen(),
      ProfileScreen(),
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
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}



