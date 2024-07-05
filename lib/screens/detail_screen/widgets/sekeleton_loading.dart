import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          highlightColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: 50,
                      decoration: BoxDecoration(
                        color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),                  ),
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: 50,
                      decoration: BoxDecoration(
                        color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),                  ),
                  ],),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 20, left: 60),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 20, left: 30),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(right: 20, left: 120),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 10,
                color:  Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}