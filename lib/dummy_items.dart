import 'categories.dart';

class GroceryItem {
  final String id;
  String name;
  int quantity;
  final Category category;
  GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});

  factory GroceryItem.fromJson(String id, Map<String, dynamic> map) {
    Category category= categories.values.firstWhere((element) => element.name==map['category']);
    return GroceryItem(id: id, name: map['name'], quantity: map['quantity'], category: category);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category.name
    };
  }
}
