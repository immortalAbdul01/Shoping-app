import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';

class GroceryItemsScreen extends StatefulWidget {
  const GroceryItemsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GroceryItemsScreen();
  }
}

class _GroceryItemsScreen extends State<GroceryItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Name')),
                validator: (value) {
                  return 'Testing';
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(label: Text('quantity')),
                      initialValue: '1',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(items: [
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
                    ], onChanged: (value) {}),
                  )
                ],
              )
            ],
          ))),
    );
  }
}
