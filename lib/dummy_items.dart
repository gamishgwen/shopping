// import 'package:shopping_list/models/grocery_item.dart';
// import 'package:shopping_list/data/categories.dart';

import 'package:flutter/material.dart';

import 'categories.dart';

class Groce with ChangeNotifier {
  final groceryItems = [
    GroceryItem(
        id: 'a',
        name: 'Milk',
        quantity: 1,
        category: categories[Categories.dairy]!),
    GroceryItem(
        id: 'b',
        name: 'Bananas',
        quantity: 5,
        category: categories[Categories.fruit]!),
    GroceryItem(
        id: 'c',
        name: 'Beef Steak',
        quantity: 1,
        category: categories[Categories.meat]!),
  ];

  void addNewGrocery(GroceryItem newGrocery){
    groceryItems.add(newGrocery);
    notifyListeners();
  }
}

class GroceryItem{
  final String id;
  final String name;
  final int quantity;
  final Category category;
  const GroceryItem({required this.id, required this.name, required this.quantity, required this.category});
}

