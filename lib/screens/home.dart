import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sensei/screens/widget/custom_app_bar.dart';
import 'package:style_sensei/screens/widget/custom_bottom_bar.dart';
import 'package:style_sensei/screens/widget/staggered_grid_view.dart';
import 'package:style_sensei/screens/widget/staggered_grid_view2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            CustomAppBar(),
            StaggeredGridView(),
            SizedBox(height: 8),
            Image.network('https://marketplace.canva.com/EAFWecuevFk/1/0/1600w/canva-grey-brown-minimalist-summer-season-collections-banner-landscape-VXEmg9V800o.jpg'),
            SizedBox(height: 28),
            StaggeredGridView2(),
            SizedBox(height: 28),
            Center(child: Text('ITEM BASED', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),))
          ],
        ),
      ),
        bottomNavigationBar: CustomBottomBar(),
    );
    // return Scaffold(
    //   body: ListView(
    //     children: [
    //     ],
    //   ),
    // );
  }
}