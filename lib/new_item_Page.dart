import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/categories.dart';
import 'package:shopping/dummy_items.dart';
import 'package:shopping/grocery_source.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  Category _selectedCategory = categories[Categories.dairy]!;

  void save() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      GrocerySource source= GrocerySource();
      final newGrocery = GroceryItem(id: 'id', name: _enteredName, quantity: _enteredQuantity, category: _selectedCategory);
    source.postAllGrocery(newGrocery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Add a new item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'words btwn 1 and 50 only';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('quantity')),
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value) <= 0) {
                          return 'enter positive value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 146,
                    child: DropdownButtonFormField(items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                    width: 10,
                                    height: 10,
                                    color: category.value.color),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(category.value.name),
                              ],
                            )
                        )
                    ], onChanged: (value) {
                      _selectedCategory=value!;
                    }, validator: (value){
                      if(value==null){
                        return 'select value';
                      }
                    },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  ElevatedButton(onPressed: () {
                    save();
                  }, child: Text('Add Item'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
