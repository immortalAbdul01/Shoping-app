import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/data/categories.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/grocery_items.dart';
import 'package:shopping/screens/grocery_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GroceryItem> _newList = [];
  void addItem() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const GroceryItemsScreen()));
    _loadItems();
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _onRemoveMeal(GroceryItem item) {
    setState(() {
      _newList.remove(item);
    });
  }

  void _loadItems() async {
    final List<GroceryItem> _finalList = [];
    final url =
        Uri.https('signal-7900f-default-rtdb.firebaseio.com', 'shooping.json');
    final response = await http.get(url);
    final Map<String, dynamic> _loadedList = await json.decode(response.body);
    for (final item in _loadedList.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      _finalList.add(GroceryItem(
          category: category,
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity']));
    }

    setState(() {
      _newList = _finalList;
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
