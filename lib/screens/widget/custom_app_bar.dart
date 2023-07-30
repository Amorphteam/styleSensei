import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  final String assetName = 'assets/images/logo.svg';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      height: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Hi Sara', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w600),),
            Text('Here are our suggestions for you', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w200),),
          ],),
          SvgPicture.asset(assetName)
        ],
      ),
    );
  }
}
