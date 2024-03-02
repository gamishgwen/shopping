import 'dart:convert';

import 'package:shopping/categories.dart';
import 'package:shopping/dummy_items.dart';
import 'package:http/http.dart' as http;

class GrocerySource {
  Future<List<GroceryItem>> getAllGroceries() async {
    final url = Uri.https(
        'flutter-new-b94a6-default-rtdb.firebaseio.com', 'shopping-list.json');
    final http.Response response = await http.get(url);
    Map<String, dynamic> map = jsonDecode((response.body));
    List<GroceryItem> groceryItems = map.entries
        .map((mapValue) => GroceryItem.fromJson(mapValue.key, mapValue.value))
        .toList();
    return groceryItems;
  }

  Future<void> postAllGrocery(GroceryItem groceryItem) async {
    final url = Uri.https(
        'flutter-new-b94a6-default-rtdb.firebaseio.com', 'shopping-list.json');
    final http.Response response = await http.post(url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(groceryItem.toJson()));
  }
  Future<void> remove(String id) async{
    final updatedUrl= Uri.https(
        'flutter-new-b94a6-default-rtdb.firebaseio.com', 'shopping-list/$id.json');
    final http.Response response= await http.delete(updatedUrl);
  }
}
