import 'package:flutter/material.dart';

class CategoriesItem extends StatefulWidget {
  final index;
  final String title;
  final String imageUrl;

  CategoriesItem(this.index, this.title, this.imageUrl);

  @override
  _CategoriesItemState createState() => _CategoriesItemState();
}

class _CategoriesItemState extends State<CategoriesItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.only(
            left: widget.index == 0 ? 0 : 10, right: widget.index == 6 ? 0 : 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 1 / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                      child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.fill,
                  )),
                ),
              ),
              Container(
                  height: 30,
                  child: Center(
                      child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 14),
                  )))
            ],
          ),
        ));
  }
}
