import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/new_item_Page.dart';

import 'dummy_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NewItem();
        },));
      }, icon: Icon(Icons.add))],
        centerTitle: false,
        title: Text('My Groceries'),
      ),
      body: ListenableBuilder(
        listenable: context.read<Groce>(),
        builder: (context, child) => Column(
          children: [
            for (GroceryItem groceryItem in context.read<Groce>().groceryItems)
              Row(
                children: [
                  SizedBox(
                      child: ColoredBox(color: groceryItem.category.color),
                      height: 16,
                      width: 16),
                  SizedBox(width: 17),
                  Text(
                    groceryItem.name,
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(width: 17),
                  Text(
                    groceryItem.quantity.toString(),
                    style: TextStyle(fontSize: 19),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
