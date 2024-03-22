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
import 'package:style_sensei/screens/splash/splash_simple.dart';
import 'package:style_sensei/screens/splash/splash_with_video.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
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
      ),
      darkTheme: ThemeData(
        fontFamily: 'centrale',
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      builder: (context, child) {
        var locale = Localizations.localeOf(context);
        if (locale.languageCode == 'ar') {
          return Theme(
            data: ThemeData(
              useMaterial3: true,
              // Define the font for Arabic text
              fontFamily: 'tajawal',
            ),
            child: child!,
          );
        }
        return child!;
      },
      home: SplashWithVideo(),
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
            // If you are using material3, you might need to set the color scheme
          ),
          child: NavigationBar(
            labelBehavior: labelBehavior,
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: <Widget>[
              NavigationDestination(
                selectedIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      child: SvgPicture.asset('assets/images/home_bold.svg')),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/images/home_light.svg')),
                label: AppLocalizations.of(context).translate('explorer'),
              ),
              NavigationDestination(
                selectedIcon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/images/bookmarked.svg')),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/images/bookmark.svg')),
                label: AppLocalizations.of(context).translate('saved'),
              ),
              NavigationDestination(
                selectedIcon:
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/images/profile_bold.svg')),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/images/profile_light.svg')),
                label: AppLocalizations.of(context).translate('profile_title'),
              ),
            ],
          ),
        ));
  }
}
