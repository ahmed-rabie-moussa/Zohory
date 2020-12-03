import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final index;
  final String title;
  final String imageURL;
  final String price;
  var quantity;

  ProductItem(this.index, this.title, this.imageURL, this.price, this.quantity);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Image.network(
                    widget.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                        child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 16),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.price,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.8)),
                        ),
                        Container(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    if(widget.quantity > 1)
                                      widget.quantity -=1;
                                  });
                                },
                                child: Icon(Icons.remove_circle,
                                    size: 20,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.8)),
                              ),

                              Text(
                                widget.quantity.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),

                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                      widget.quantity +=1;
                                  });
                                },
                                child: Icon(Icons.add_circle_rounded,
                                    size: 20,
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
              ),
            )
          ],
        ));
  }
}
