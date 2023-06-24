import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
import 'package:shopping/models/categories.dart';
import 'package:shopping/models/grocery_items.dart';

class GroceryItemsScreen extends StatefulWidget {
  const GroceryItemsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceryItemsScreen();
  }
}

class _GroceryItemsScreen extends State<GroceryItemsScreen> {
  final _formkey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQT = 1;
  var _enteredCategory = categories[Categories.dairy];
  void _saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
    }
    Navigator.of(context).pop(GroceryItem(
        category: _enteredCategory!,
        id: DateTime.now.toString(),
        name: _enteredName,
        quantity: _enteredQT));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Name')),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Name should be in 1 to 50 length';
                      }
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
                          decoration:
                              const InputDecoration(label: Text('quantity')),
                          initialValue: _enteredQT.toString(),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value)! <= 0 ||
                                int.tryParse(value) == null) {
                              return 'quantity should be positive integer';
                            }
                          },
                          onSaved: (value) {
                            _enteredQT = int.parse(value!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                            value: _enteredCategory,
                            items: [
                              for (final category in categories.entries)
                                DropdownMenuItem(
                                    value: category.value,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 23,
                                          height: 23,
                                          color: category.value.color,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(category.value.title)
                                      ],
                                    ))
                            ],
                            onChanged: (value) {
                              setState(() {
                                _enteredCategory = value;
                              });
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            _formkey.currentState!.reset();
                          },
                          child: const Text('Reset')),
                      ElevatedButton(
                          onPressed: _saveItem, child: const Text('Add Item'))
                    ],
                  )
                ],
              ))),
    );
  }
}
