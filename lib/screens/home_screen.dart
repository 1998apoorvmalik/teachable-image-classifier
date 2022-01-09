import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(ClassificationTrain.routeName),
                child: Text(
                  'Train a Classification Model',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
