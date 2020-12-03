import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final bool isColored;
  final String text;
  final Function onTap;

  CustomButton({this.isColored, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 24, right: 24),
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            color: isColored
                ? Theme.of(context).accentColor.withOpacity(0.8)
                : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            type: MaterialType.transparency,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              splashColor:
                  isColored ? Theme.of(context).accentColor : Colors.white,
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(18),
                child: Center(
                  child: Text(text,
                      // style: TextStyle(fontSize: 24,
                      // ),
                      style: GoogleFonts.quicksand(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 22,
                        color: isColored
                            ? Colors.white.withOpacity(0.8)
                            : Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
