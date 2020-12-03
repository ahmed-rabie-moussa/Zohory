import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zohory/widgets/custom_bottom_appbar.dart';
import '../widgets/cart_item.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 128,
        title: Text(
          "Shopping Cart",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Shopping Items",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "3",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (_, index) =>
                    CartItem("assets/photos/${index + 1}.jpg"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
        height: 120,
        color: Colors.transparent,
        child: Column(children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),)),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text(
                      "Total : 180 EGP",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
          CustomBottomAppBar()
        ]));
  }
}
