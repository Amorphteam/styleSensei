import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:style_sensei/firebase_options.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_sensei/screens/login_screen/login_screen.dart';
import 'package:style_sensei/screens/profile_tab/profile_screen.dart';
import 'package:style_sensei/screens/saved_tab/cubit/saved_cubit.dart';
import 'package:style_sensei/screens/saved_tab/saved_screen.dart';
import 'package:style_sensei/screens/splash/cubit/splash_cubit.dart';
import 'package:style_sensei/screens/splash/splash_screen.dart';
import 'package:style_sensei/utils/AppLocalizationsDelegate.dart';
import 'package:style_sensei/utils/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Sensei',
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Arabic
      ],
      theme: ThemeData(
        fontFamily: 'centrale',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, // Pick a seed color
          brightness: Brightness.light, // Choose Brightness.light or Brightness.dark
        ),
      ),
      home: SplashScreen(),
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
      BlocProvider(
        create: (context) => SavedCubit(), // Create an instance of SavedCubit
        child: SavedScreen(),
      ),
      ProfileScreen(),
    ];

    return Scaffold(
        body: _screens[currentPageIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // This will change the background color of the NavigationBar
            // no matter what theme you are using.
            bottomAppBarColor: Colors.white,
            // If you are using material3, you might need to set the color scheme
            // and use surfaceVariant or surfaceTint color for NavigationBar
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  background: Colors.white,
                  surfaceVariant: Colors.white,
                  surfaceTint: Colors.white,
                ),
          ),
          child: NavigationBar(
            labelBehavior: labelBehavior,
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            backgroundColor: Colors.white,
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: SvgPicture.asset('assets/images/home_bold.svg'),
                icon: SvgPicture.asset('assets/images/home_light.svg'),
                label: 'Explore',
              ),
              NavigationDestination(
                selectedIcon: SvgPicture.asset('assets/images/bookmarked.svg'),
                icon: SvgPicture.asset('assets/images/bookmark.svg'),
                label: 'Saved',
              ),
              NavigationDestination(
                selectedIcon:
                    SvgPicture.asset('assets/images/profile_bold.svg'),
                icon: SvgPicture.asset('assets/images/profile_light.svg'),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}
