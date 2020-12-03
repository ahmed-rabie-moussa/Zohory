import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class CustomBottomAppBar extends StatefulWidget {
  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  var _selectedItem = 0;


  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 30,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Container(
          height: 64,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem("assets/images/home.png",
                  "assets/images/home_gray.png", "Home", (_selectedItem == 0), onTap: (){setState(() {
                    _selectedItem = 0;
                  });}),
              _buildItem("assets/images/gift.png",
                  "assets/images/gift_gray.png", "Gifts", (_selectedItem == 1), onTap: (){setState(() {
                    _selectedItem = 1;
                  });}),
              _buildItem("assets/images/list.png",
                  "assets/images/list_gray.png", "List", (_selectedItem == 2), onTap: (){setState(() {
                    _selectedItem = 2;
                  });}),
              _buildItem("assets/images/more.png",
                  "assets/images/more_gray.png", "More", (_selectedItem == 3), onTap: (){setState(() {
                    Provider.of<Auth>(context, listen: false).logout();
                    _selectedItem = 3;
                  });}),
            ],
          ),
        ));
  }

  Widget _buildItem(String coloredImagePath, String grayedImagPath, String text,
      bool selected,
      {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).accentColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(6)),
        child: (selected)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Tab(
                    icon: Container(
                      height: 18,
                      width: 18,
                      child: Image.asset(coloredImagePath),
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(color: Theme.of(context).accentColor
                        // : Color(0xFFbabacc)
                        ),
                  )
                ],
              )
            : Tab(
                icon: Container(
                  height: 28,
                  width: 28,
                  child: Image.asset(grayedImagPath),
                ),
              ),
      ),
    );
  }
}
