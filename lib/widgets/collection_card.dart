import 'dart:async';

import 'package:flutter/material.dart';

class CustomCollectionsCard extends StatefulWidget {
  @override
  _CustomCollectionsCardState createState() => _CustomCollectionsCardState();
}

class _CustomCollectionsCardState extends State<CustomCollectionsCard> {
  var _selectedCollection = 0;
  PageController _pageController;
  Timer timer;
  @override
  void initState() {
    super.initState();
    _pageController =  PageController(initialPage: _selectedCollection, keepPage: true, viewportFraction: 1);
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_selectedCollection < 2) {
        setState(() {
          _selectedCollection++;
          _pageController.animateToPage(
            _selectedCollection,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });

      } else {
        setState(() {
          _selectedCollection = 0;
          _pageController.animateToPage(
            _selectedCollection,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.only(top: 10, right: 24, left: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            PageView.builder(
                itemCount: 3,
                allowImplicitScrolling: true,
                controller: _pageController,
                onPageChanged: (pageIndex){
                  setState(() {
                    _selectedCollection = pageIndex;
                  });
                },
                itemBuilder: (ctx, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/collection/collection${index+1}.jpg",
                        fit: BoxFit.cover,
                      ),
                    )

            ),

            Container(
                height: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Collections",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Theme.of(context).accentColor),
                        ),
                        Text(
                          "Get 20% Discount For A week",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                   __buildIndicator(),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget __buildIndicator() {
    return Container(height: 30,
    width: MediaQuery.of(context).size.width * 0.2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIndicatorItem(_selectedCollection == 0),
        _buildIndicatorItem(_selectedCollection == 1),
        _buildIndicatorItem(_selectedCollection == 2),
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
