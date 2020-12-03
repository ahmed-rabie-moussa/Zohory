import 'package:flutter/material.dart';

class Category {
  final String imageURL;
  final String title;

  Category({
    this.imageURL,
    this.title
  });
}

class DemoData {
  List<Category> _categories = [
    Category(imageURL : "assets/photos/8.jpg",
    title : "Bouquets"
    ),
    Category(imageURL : "assets/photos/2.jpg",
        title : "Home Flowers"
    ),
    Category(imageURL : "assets/photos/3.jpg",
        title : "Birthday"
    ),
    Category(imageURL : "assets/photos/4.jpg",
        title : "Morning Flower"
    ),
    Category(imageURL : "assets/photos/5.jpg",
        title : "Title5"
    ),
    Category(imageURL : "assets/photos/6.jpg",
        title : "Title6"
    ),
    Category(imageURL : "assets/photos/7.jpg",
        title : "Title7"
    ),
    Category(imageURL : "assets/photos/8.jpg",
        title : "Title8"
    ),
    Category(imageURL : "assets/photos/9.jpg",
        title : "Title8"
    ),
    Category(imageURL : "assets/photos/10.jpg",
        title : "Title9"
    ),
    Category(imageURL : "assets/photos/11.jpg",
        title : "Title10"
    ),
    Category(imageURL : "assets/photos/12.jpg",
        title : "Title11"
    ),
  ];

  List<Category> getCategories() => _categories;
}