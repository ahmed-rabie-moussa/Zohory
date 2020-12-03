import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zohory/providers/auth.dart';
import 'package:zohory/screens/product_screen.dart';
import '../providers/flowers_provider.dart';
import '../widgets/categories_item.dart';
import '../widgets/new_collection_item.dart';
import '../widgets/collection_card.dart';
import '../widgets/custom_searchbar.dart';
import '../widgets/demo_data.dart';
import '../widgets/custom_bottom_appbar.dart';

class MyHomePage extends StatefulWidget {
  static const route = "/homepage";

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isInit = true;
  var _isLoading = false;
  String name = "";
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false).getUserInfo().then((value) => name = value["name"]);
      Provider.of<Flowers>(context, listen: false)
          .fetchAndSetFlowers()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    final flowersData = Provider.of<Flowers>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
          child: Column(
            children: [
              _buildWelcome(),
              CustomSearchBar(),
            ],
          )),
      backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: _isLoading
          ? _buildLoadingShimmer()
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22,
                          ),
                          CustomCollectionsCard(),
                          //Action All of the categories
                          _buildTitleRow("Categories", ()  {
                           final auth =  Provider.of<Auth>(context, listen: false);
                            auth.getUserInfo();
                          }),
                          Container(
                            height:
                                250,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              scrollDirection: Axis.horizontal,
                              itemCount: flowersData.getCategories().length,
                              itemBuilder: (context, index) => CategoriesItem(
                                index,
                                flowersData
                                    .getCategories()
                                    .keys
                                    .elementAt(index),
                                flowersData
                                    .getCategories()
                                    .values
                                    .elementAt(index)
                                    .flowers[2]
                                    .images[2],
                              ),
                            ),
                          ),
                          _buildTitleRow("New Collection", () {
                            Navigator.of(context).pushNamed(ProductScreen.route, arguments: {
                              "name" : "All Collections",
                              "flowers": flowersData.flowers,
                            });
                          }),
                          Container(
                            height:
                                250,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              scrollDirection: Axis.horizontal,
                              itemCount: flowersData.flowers.length,
                              itemBuilder: (context, index) =>
                                  NewCollectionItem(
                                      index,
                                      flowersData.flowers[index].name,
                                      flowersData.flowers[index].images[0],
                                      "${flowersData.flowers[index].price} EGP",
                                      //here to implement Favorite
                                      false),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }

  Widget _buildWelcome() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(fontSize: 18, color: Color(0xFFbabacc)),
              ),
              Text(
                name.split(" ").first,
                style: TextStyle(fontSize: 24, color: Colors.black87),
              ),
            ],
          ),
          Icon(
            Icons.add_alert_outlined,
            color: Theme.of(context).accentColor.withOpacity(0.7),
            size: 38,
          )
        ],
      ),
    );
  }

  Widget _buildTitleRow(String title, Function onTap) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                TextStyle(fontSize: 20, color: Colors.black87.withOpacity(0.7)),
          ),
          GestureDetector(
              onTap: onTap,
              child: Text(
                "All",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    color: Theme.of(context).accentColor.withOpacity(0.9)),
              ))
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
