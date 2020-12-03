import 'package:flutter/material.dart';
import 'package:zohory/screens/product_details_screen.dart';

class NewCollectionItem extends StatefulWidget {
  final index;
  final String imageURL;
  final String title;
  final String price;
  bool isFavorite;
  NewCollectionItem(this.index, this.title, this.imageURL, this.price, this.isFavorite);

  @override
  _NewCollectionItemState createState() => _NewCollectionItemState();
}

class _NewCollectionItemState extends State<NewCollectionItem> {
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailsScreen.route, arguments: widget.index);
          },
          child: Card(
              elevation: 0,
              color: Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                            child: Hero(
                              tag: widget.title,
                              child: Image.network(
                          widget.imageURL,
                          fit: BoxFit.fill,
                        ),
                            )),
                      ),
                    ),
                    Container(
                      height: 80,
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            widget.price,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 24,
            width: 24,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(6)),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
                });
              },
              child: Icon(widget.isFavorite?Icons.favorite: Icons.favorite_outline,
                  size: 20, color:widget.isFavorite? Theme.of(context).accentColor: Colors.grey.shade500),
            ),
          ),
        )
      ],
    );
  }
}
