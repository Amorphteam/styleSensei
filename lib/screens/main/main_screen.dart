import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/screens/home_tab/cubit/home_cubit.dart';
import 'package:style_sensei/screens/home_tab/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:style_sensei/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: 'centrale',
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomeCubit(),
        child: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


