import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  EdgeInsetsGeometry padding;
  double logoSize;
  AppLogo({this.padding , this.logoSize = 30});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                "assets/images/rose.png",
                fit: BoxFit.cover,
              ),
            ),
            new RichText(
              text: new TextSpan(
                style: GoogleFonts.quicksand(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: logoSize,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'FL'),
                  new TextSpan(
                      text: '□',
                      style: new TextStyle(
                        fontSize: logoSize + 5,
                        color: Theme.of(context).accentColor,
                      )),
                  new TextSpan(text: 'WER B'),
                  new TextSpan(
                      text: '□',
                      style: new TextStyle(
                        fontSize: logoSize + 5,
                        color: Theme.of(context).accentColor,
                      )),
                  new TextSpan(text: 'X'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
