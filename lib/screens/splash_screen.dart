import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/config/socket_provider.dart';
import 'package:teachable_image_classifier/constants.dart';
import 'package:teachable_image_classifier/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) {
        return SplashScreen();
      },
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.doWhile(() => Future.delayed(kSplashScreenDuration,
            () => !context.read<SocketProvider>().isSocketConnected)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen();
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Connecting to the Server...',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
