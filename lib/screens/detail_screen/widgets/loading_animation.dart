import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: Lottie.asset(
                  'assets/json/loading_ai.json', // Ensure the Lottie JSON file is placed in the assets folder and added in pubspec.yaml
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).translate('loading_store'), style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
