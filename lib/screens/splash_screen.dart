import 'package:flutter/material.dart';
import '../widgets/backgrounded_screen.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundedScreen(
      child: AppLogo(
        padding: EdgeInsets.only(top: 60),
        logoSize: 35,
      ),
    );
  }
}
