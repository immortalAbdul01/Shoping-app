import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/screens/grocery_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const GroceryItemsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(onPressed: addItem, icon: const Icon(Icons.add))
          ],
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
