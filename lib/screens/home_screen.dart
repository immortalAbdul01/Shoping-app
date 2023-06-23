import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
import 'package:shopping/data/dummy_items.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (ctx, index) => ListTile(
                  title: Text(groceryItems[index].name),
                  leading: Container(
                    width: 23,
                    height: 23,
                    color: groceryItems[index].category.color,
                  ),
                  trailing: Text(groceryItems[index].quantity.toString()),
                  subtitle: Text(groceryItems[index].category.title),
                ))));
  }
}
