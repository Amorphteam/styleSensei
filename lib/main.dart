import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:style_sensei/screens/waiting/waiting_screen.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:style_sensei/utils/AppLocalizationsDelegate.dart';
import 'package:style_sensei/utils/user_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  print('Loaded API Key: ${dotenv.env['OPENAI_API_KEY']}');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Style Sensei',
            locale: provider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFFDC4D28),
                primary: Color(0xFFDC4D28),
                background: Colors.white,
              ),
              fontFamily: 'centrale',
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFFDC4D28),
                primary: Color(0xFFDC4D28),
                brightness: Brightness.dark,
              ),
              fontFamily: 'centrale',
            ),
            builder: (context, child) {
              var locale = Localizations.localeOf(context);
              if (locale.languageCode == 'ar') {
                return Theme(
                  data: Theme.of(context).brightness == Brightness.dark
                      ? ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Color(0xFFDC4D28),
                      primary: Color(0xFFDC4D28),
                      brightness: Brightness.dark,
                    ),
                    fontFamily: 'tajawal',
                    navigationBarTheme: NavigationBarThemeData(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                  )
                      : ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Color(0xFFDC4D28),
                      primary: Color(0xFFDC4D28),
                      background: Colors.white,
                    ),
                    fontFamily: 'tajawal',
                    navigationBarTheme: NavigationBarThemeData(
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
                  child: child!,
                );
              }
              return child!;
            },
            home: checkUserState(),
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  Widget checkUserState() {
    return FutureBuilder<bool>(
      future: UserController.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, prefSnapshot) {
                if (prefSnapshot.connectionState == ConnectionState.done) {
                  String? styleSelectionsString = prefSnapshot.data?.getString('styleSelections');
                  if (styleSelectionsString == null) {
                    return SplashSimple(imagePath: 'assets/images/splash1.jpg');
                  } else {
                    return WaitingScreen();
                  }
                }
                return CircularProgressIndicator();
              },
            );
          }
        }
        return FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, prefSnapshot) {
            if (prefSnapshot.connectionState == ConnectionState.done) {
              String? styleSelectionsString = prefSnapshot.data?.getString('styleSelections');
              if (styleSelectionsString == null) {
                return SplashWithVideo(isFromSettings: false,);
              } else {
                return WaitingScreen();
              }
            }
            return CircularProgressIndicator();
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.onlyShowSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeTab(
        homeCubit: context.read<HomeCubit>(),
      ),
      BlocProvider(
        create: (context) => SavedCubit(),
        child: SavedScreen(),
      ),
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
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/home_bold.svg'),
            ),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/home_light.svg'),
            ),
            label: AppLocalizations.of(context).translate('explorer'),
          ),
          NavigationDestination(
            selectedIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/bookmarked.svg'),
            ),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/bookmark.svg'),
            ),
            label: AppLocalizations.of(context).translate('saved'),
          ),
          NavigationDestination(
            selectedIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/profile_bold.svg'),
            ),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset('assets/images/profile_light.svg'),
            ),
            label: AppLocalizations.of(context).translate('profile_title'),
          ),
        ],
      ),
    );
  }
}
