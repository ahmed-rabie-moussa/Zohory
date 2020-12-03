import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/flower.dart';
import '../widgets/custom_searchbar.dart';
import '../widgets/demo_data.dart';
import '../widgets/product_item.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/backgrounded_screen.dart';

class ProductScreen extends StatelessWidget {
  static const route = "/productScreen";
  List<Flower> flowers = [];
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    flowers = data["flowers"];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    data["name"],
                    style: TextStyle(fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: () {
                      _modalBottomSheetMenu(context);
                    },
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                      size: 36,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            CustomSearchBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sort By: ",
                    style: TextStyle(color: Color(0xFFbabacc), fontSize: 16),
                  ),
                  Text(
                    "New",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 30,
                    color: Color(0xFFbabacc),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //implementing the grid View for products
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top +
                      MediaQuery.of(context).padding.bottom +
                      200),
              child: GridView(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 11 / 12,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  ...List.generate(
                      flowers.length,
                      (index) => ProductItem(
                          index,
                          flowers[index].name,
                          flowers[index].images[0],
                          "${flowers[index].price} EGP",
                          1))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Container(
            height: 300,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 3,
                  endIndent: MediaQuery.of(context).size.width * 0.42,
                  indent: MediaQuery.of(context).size.width * 0.42,
                  color: Theme.of(context).accentColor.withOpacity(0.8),
                  height: 48,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Filter", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                ExpansionTile(
                  title: Text("Category"),
                ),
                ExpansionTile(
                  title: Text("Colors"),
                ),
                ExpansionTile(
                  title: Text("Brand"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Clear All",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.8),
                            fontSize: 18),
                      ),
                      RaisedButton(
                        color: Theme.of(context).accentColor.withOpacity(0.8),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Filter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
