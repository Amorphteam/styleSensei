import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.labelMedium, // default text style
              children: [
                TextSpan(
                  text: text.substring(0, text.indexOf(':') + 1), // text before the colon
                  style: TextStyle(fontWeight: FontWeight.bold), // make it bold
                ),
                TextSpan(
                  text: text.substring(text.indexOf(':') + 1), // text after the colon
                  // The style is inherited from the default if not specified
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
