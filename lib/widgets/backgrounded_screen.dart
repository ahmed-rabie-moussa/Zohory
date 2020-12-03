import 'package:flutter/material.dart';

class BackgroundedScreen extends StatelessWidget {
  final Widget child;
  BackgroundedScreen({this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFf7f1f3),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Image.asset(
                    "assets/images/background.png",
                    fit: BoxFit.fill,
                  ),
                )),
            child,
          ],
        ),
      ),
    );
  }
}
