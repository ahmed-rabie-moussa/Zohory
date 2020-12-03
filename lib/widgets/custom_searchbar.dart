import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 64,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft:Radius.circular(8), )),
            child: Icon(
              Icons.search,
              size: 32,
              color: Color(0xFFbabacc),
            ),
          ),
          Expanded(child: Container(child: TextField(
            decoration: InputDecoration(hintText: "Search On Flowers",
                hintStyle: TextStyle(fontSize: 18, color: Color(0xFFbabacc))),
            style: TextStyle(fontSize: 22, color: Colors.black87),))),
          Container(
            height: double.infinity,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.25,
            decoration: BoxDecoration(color: Theme
                .of(context)
                .accentColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight:Radius.circular(8), )
            ),

            child: Center(child: Text(
              "Search", style: TextStyle(fontSize: 18, color: Colors.white),)),
          ),
        ],
      ),
    );
  }
}
