import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/models/grocery_items.dart';
import 'package:shopping/screens/grocery_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onRemoveMeal(GroceryItem item) {
    setState(() {
      _newList.remove(item);
    });
  }

  final List<GroceryItem> _newList = [];
  void addItem() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const GroceryItemsScreen()));

    if (newItem == null) {
      return;
    }
    setState(() {
      _newList.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _newList.isNotEmpty
        ? ListView.builder(
            itemCount: _newList.length,
            itemBuilder: (ctx, index) => Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: ValueKey(_newList[index]),
                  child: ListTile(
                    title: Text(_newList[index].name),
                    leading: Container(
                      width: 23,
                      height: 23,
                      color: _newList[index].category.color,
                    ),
                    trailing: Text(_newList[index].quantity.toString()),
                    subtitle: Text(_newList[index].category.title),
                  ),
                  onDismissed: (direction) {
                    _onRemoveMeal(_newList[index]);
                  },
                ))
        : Center(
            child: Text(
            'No items here',
            style: Theme.of(context).textTheme.titleLarge,
          ));

    return (Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(onPressed: addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: content));
  }
}
