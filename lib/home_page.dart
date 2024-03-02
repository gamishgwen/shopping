import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/dummy_items.dart';
import 'package:shopping/grocery_source.dart';
import 'package:shopping/new_item_Page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return NewItem();
                  },
                ));
              },
              icon: Icon(Icons.add))
        ],
        title: Text('My Grocery Items'),
      ),
      body: FutureBuilder(
        future: GrocerySource().getAllGroceries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                for (GroceryItem groceryitem in snapshot.data!)
                  Dismissible(
                    onDismissed: (direction) {
                      GrocerySource().remove(groceryitem.id);
                    },
                    key: ObjectKey(groceryitem),
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                              width: 12,
                              height: 12,
                              color: groceryitem.category.color),
                          SizedBox(
                            width: 12,
                          ),
                          Text(groceryitem.category.name),
                          SizedBox(
                            width: 12,
                          ),
                          Text(groceryitem.quantity.toString())
                        ],
                      ),
                    ),
                  )
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
