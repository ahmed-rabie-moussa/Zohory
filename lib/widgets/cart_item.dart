import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  var quantity = 10;
  final ImageURL;
  CartItem(this.ImageURL);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.2,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: deviceSize.width * 1 / 3,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.ImageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Morning Flower",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "20 EGP",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 16),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (widget.quantity > 1) widget.quantity -= 1;
                            });
                          },
                          child: Icon(Icons.remove_circle,
                              size: 30,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.8)),
                        ),
                        Text(
                          widget.quantity.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.quantity += 1;
                            });
                          },
                          child: Icon(Icons.add_circle_rounded,
                              size: 30,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).accentColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
