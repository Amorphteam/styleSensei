import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sensei/screens/widget/custom_app_bar.dart';
import 'package:style_sensei/screens/widget/custom_bottom_bar.dart';
import 'package:style_sensei/screens/widget/staggered_grid_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          CustomAppBar(),
          StaggeredGridView(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}