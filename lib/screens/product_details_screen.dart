import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flowers_provider.dart';
import '../widgets/selectable_specs.dart';

class ProductDetailsScreen extends StatefulWidget {
  int index;
  bool isFavorite = false;
  var quantity = 1;
  static const route = "/productDetailsScreen";
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    widget.index = ModalRoute.of(context).settings.arguments as int;
    final flowersData = Provider.of<Flowers>(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.55,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: flowersData.flowers[widget.index].name,
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: flowersData.flowers[widget.index].images.length,
                            itemBuilder: (context, index) => Image.network(
                              flowersData.flowers[widget.index].images[index],
                              fit: BoxFit.cover,
                            ),
                            onPageChanged: (index){
                              setState(() {
                                selectedImage = index;
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 128),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  List.generate(
                                      flowersData.flowers[widget.index].images.length,
                                          (index) =>
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 6),
                                      child: _buildIndicatorItem(index == selectedImage))),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(top: 60, left: 16),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(6)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.keyboard_backspace,
                              size: 30, color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.only(top: 60, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(6)),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.isFavorite = !widget.isFavorite;
                                  });
                                },
                                child: Icon(
                                    widget.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    size: 30,
                                    color: widget.isFavorite
                                        ? Theme.of(context).accentColor
                                        : Colors.grey.shade500),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(6)),
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.share_outlined,
                                    size: 30, color: Colors.grey.shade500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                padding: EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: _buildProductDetails(
                  name: flowersData.flowers[widget.index].name,
                  price: flowersData.flowers[widget.index].price,
                  brand: flowersData.flowers[widget.index].brand,
                  description: flowersData.flowers[widget.index].description,
                  colors: flowersData.flowers[widget.index].colors,
                  tags: flowersData.flowers[widget.index].tags,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildProductDetails({String name, double price, String brand,
      String description, List<String> colors, List<String> tags}) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  "$price EGP",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black87,
                    ),
                    child: Text(
                      brand,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )),
                Container(
                  width: 85,
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
                            color:
                                Theme.of(context).accentColor.withOpacity(0.8)),
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
                            color:
                                Theme.of(context).accentColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Description",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              description,
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Colors Available",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 6,
              runSpacing: 6,
              children: List.generate(
                  colors.length,
                  (index) =>
                      SelectableSpecificationItem(colors[index], true, 16)),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Tags",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 10,
              children: List.generate(tags.length, (index) => _buildTags(tags[index])),
            ),
            SizedBox(height: 36,)
          ],
        ),
      ),
    );
  }

  Widget _buildTags(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6)),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      width: double.infinity,
      height: 65,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton.icon(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            label: Text(
              "Add To Cart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {},
          ),
          RaisedButton(
            onPressed: () {},
            color: Colors.white10,
            highlightColor: Colors.transparent,
            splashColor: Colors.white24,
            focusColor: Colors.transparent,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text(
              "30 EGP",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIndicatorItem(bool selected){
    return AnimatedContainer(
      height: selected ? 28 : 20,
      width: selected ? 28 : 20,
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(border: Border.all(
          color: selected ? Theme.of(context).accentColor : Colors.white),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: AnimatedContainer(
          height: selected ? 15 : 20,
          width: selected ? 15 : 20,
          decoration: BoxDecoration(color: selected? Theme.of(context).accentColor: Colors.white, borderRadius: BorderRadius.circular(16)),
          duration: Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
