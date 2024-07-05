import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          highlightColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerContainer(context, widthFraction: 1 / 3, height: 50),
                    _buildShimmerContainer(context, widthFraction: 1 / 3, height: 50),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: _buildShimmerContainer(context, height: 10),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContainer(BuildContext context, {double widthFraction = 1.0, double? height}) {
    return Container(
      width: MediaQuery.of(context).size.width * widthFraction,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
