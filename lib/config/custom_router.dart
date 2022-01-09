import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Navigating to Route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<Material>(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );

      case SplashScreen.routeName:
        return SplashScreen.route();

      case PreprocessScreen.routeName:
        return PreprocessScreen.route();

      case ClassificationTrain.routeName:
        return ClassificationTrain.route();

      default:
        return _errorRoute();
    }
  }

  static Route<Material> _errorRoute() => MaterialPageRoute<Material>(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Something went wrong!'),
          ),
        ),
      );
}
