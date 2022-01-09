import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachable_image_classifier/config/custom_router.dart';
import 'package:teachable_image_classifier/constants.dart';

import 'config/socket_provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const VisionInspectionSystemApp());
}

class VisionInspectionSystemApp extends StatelessWidget {
  const VisionInspectionSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SocketProvider>(
      create: (_) => SocketProvider(),
      child: MaterialApp(
        title: 'Vision Inspection System',
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          accentColor: kSecondaryColor,
          sliderTheme: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 4.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.redAccent,
            overlayColor: Colors.red.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.redAccent,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onGenerateRoute: CustomRouter.onGenerateRoute,
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
