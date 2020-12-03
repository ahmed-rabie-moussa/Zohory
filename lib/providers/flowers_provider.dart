import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zohory/models/category.dart';
import 'package:zohory/models/flower.dart';
import 'package:http/http.dart' as http;

class Flowers with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Flower> flowers = [];

  Flowers(this.authToken, this.userId, this.flowers);

  List<Flower> get items {
    return [...flowers];
  }

  //This method is used to fetch all the flowers from my API and save it in (flowers) array
  Future<void> fetchAndSetFlowers() async {
    var url =
        'https://firestore.googleapis.com/v1/projects/zohory-59523/databases/(default)/documents/flowers/?key=AIzaSyAU5GlSB6sp7u5IXvSmdG0YmtUG8D_Zo8Y';
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $authToken'});
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<dynamic> loadedFlowers = extractedData["documents"];
      final List<Flower> flowers = [];

      List<String> tags = [];
      loadedFlowers.forEach((element) {
        List categoriesData =
            element["fields"]["categories"]["arrayValue"]["values"];
        List<String> categories = [];
        categoriesData.forEach((element) {
          categories.add(element["stringValue"]);
        });
        List colorsData = element["fields"]["colors"]["arrayValue"]["values"];
        List<String> colors = [];
        colorsData.forEach((element) {
          colors.add(element["stringValue"]);
        });
        List imagesData = element["fields"]["images"]["arrayValue"]["values"];
        List<String> images = [];
        imagesData.forEach((element) {
          images.add(element["stringValue"]);
        });
        List tagsData = element["fields"]["tags"]["arrayValue"]["values"];
        List<String> tags = [];
        tagsData.forEach((element) {
          tags.add(element["stringValue"]);
        });
        flowers.add(Flower(
          flowerId: element["name"].toString().split("/").last,
          name: element["fields"]["name"]["stringValue"],
          description: element["fields"]["description"]["stringValue"],
          brand: element["fields"]["brand"]["stringValue"],
          price: double.parse(
              element["fields"]["price"]["doubleValue"].toString()),
          categories: categories,
          images: images,
          colors: colors,
          tags: tags,
        ));
      });

      this.flowers = flowers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Map<String, Category> getCategories(){
    Map<String, Category> categories = {};
    for (Flower flower in flowers){
      for(String category in flower.categories){
        if (categories.containsKey(category))
        {
          //add the flower to the category object (Value).
          categories[category].flowers.add(flower);
        }
        else {
          //create a new category with the new name and put the flower object into it's list.
          categories.addAll({
            category: Category(name: category, flowers: [flower])
          });
        }
      }
    }
    return categories;
  }


}
