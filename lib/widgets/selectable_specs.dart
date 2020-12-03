import 'package:flutter/material.dart';

class SelectableSpecificationItem extends StatefulWidget {
  final String title;
  final double fontSize;
  final isClickable;
  bool value = false;

  SelectableSpecificationItem(this.title, this.isClickable, this.fontSize,
      {this.value = false});

  @override
  _SelectableSpecificationItemState createState() =>
      _SelectableSpecificationItemState();
}

class _SelectableSpecificationItemState
    extends State<SelectableSpecificationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.isClickable) widget.value = !widget.value;
        });
      },
      child: AnimatedContainer(
        width: 95,
        duration: Duration (milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
            color: widget.value
                ? Theme.of(context).accentColor
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.value)
               Icon(
                Icons.done,
                color: Colors.white,
                size: widget.fontSize - 2,
              ),
            if (widget.value)
              SizedBox(
                width: 6,
              ),
            Text(
              widget.title,
              style: TextStyle(
                  color: widget.value ? Colors.white : Colors.black87,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
