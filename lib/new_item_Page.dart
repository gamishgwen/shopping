import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/categories.dart';
import 'package:shopping/dummy_items.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _SaveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<Groce>().addNewGrocery(GroceryItem(id: 'id', name: _enteredName, quantity: _enteredQuantity, category: _selectedCategory));
    }
  }

  // TextEditingController nameController = TextEditingController();
  // TextEditingController quantityController = TextEditingController();
  // Category? selectedvalue;
  //
  // @override
  // void dispose() {
  //   nameController.dispose();
  //   quantityController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: context.read<Groce>(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
              title: Text('Add a new item'),
            ),

            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('name'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Must be between 1 and 50 characters';
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
                            // decoration: InputDecoration(
                            //   label: Text('Quantity'),
                            // ),
                            initialValue: _enteredQuantity.toString(),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! <= 0) {
                                return 'Must be valid positive no';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredQuantity = int.parse(value!);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(width: 150,
                          child: DropdownButtonFormField(
                              items: [
                                for (final category in categories.entries)
                                  DropdownMenuItem(
                                      value: category.value,
                                      child: Row(children: [
                                        Container(
                                            width: 16,
                                            height: 16,
                                            color: category.value.color),
                                        SizedBox(width: 6),
                                        Text(category.value.name)
                                      ]
                                      )
                                  )
                              ],
                              onChanged: (value) {
                                _selectedCategory = value!;
                              },validator: (value) {
                          if (value == null ) {
                          return 'select category';
                          }
                          return null;
                          },),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          child: const Text(
                            ('Reset'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _SaveItem();
                          },
                          child: const Text('Add Item'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // body: Column(
            //   children: [
            //     TextField(
            //       controller: nameController,
            //       decoration: InputDecoration(labelText: 'Name'),
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         TextField(),
            //         TextFormField(validator: (value) {
            //
            //         },),
            //         Expanded(
            //             child: TextField(
            //                 controller: quantityController,
            //                 decoration: InputDecoration(labelText: 'Quantity'))),
            //
            //         DropdownButton(
            //           isDense: true,
            //           value: selectedvalue,
            //           items: [
            //             for (MapEntry<Categories, Category> mapEntry in categories.entries)
            //               DropdownMenuItem(
            //                   value: mapEntry.value,
            //                   child: Row(
            //                     children: [
            //                       Container(
            //                         color: mapEntry.value.color,
            //                         height: 20,
            //                         width: 20,
            //                       ),
            //                       Text(mapEntry.value.name)
            //                     ],
            //                   ))
            //           ],
            //           onChanged: (value) {
            //             setState(() {
            //               selectedvalue = value!;
            //             });
            //           },
            //         )
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         TextButton(
            //             onPressed: () {
            //               setState(() {
            //                 nameController.clear();
            //                 quantityController.clear();
            //                 selectedvalue = null;
            //               });
            //             },
            //             child: Text(
            //               'Reset',
            //               style: TextStyle(color: Colors.cyan),
            //             )),
            //         TextButton(
            //             onPressed: () {
            //               GroceryItem groceryItem = GroceryItem(
            //                   id: '9m',
            //                   name: nameController.text,
            //                   quantity: int.parse(quantityController.text),
            //                   category: selectedvalue!);
            //               context.read<Groce>().addNewGrocery(groceryItem);
            //               // context
            //               //     .read<Groce>()
            //               //     .groceryItems
            //               //     .add(groceryItem);
            //               ScaffoldMessenger.of(context)
            //                   .showSnackBar(SnackBar(content: Text('Item added')));
            //             },
            //             child: Text(
            //               'Add Item',
            //               style: TextStyle(color: Colors.cyan),
            //             ))
            //       ],
            //     )
            //   ],
            // ),
          );
        });
  }
}
