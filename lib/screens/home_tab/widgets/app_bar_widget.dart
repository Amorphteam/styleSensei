import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  final String assetName = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Hi Sara', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),),
            Text('Here are our suggestions for you', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w200),),
          ],),
          Image.asset(assetName)
        ],
      ),
    );
  }
}
