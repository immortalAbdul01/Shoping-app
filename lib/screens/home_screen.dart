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
  String? _error;
  var _isLoading = true;
  final List<GroceryItem> _finalList = [];
  List<GroceryItem> _newList = [];
  void addItem() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const GroceryItemsScreen()));
    // _loadItems();
    if (newItem == null) {
      return;
    }
    setState(() {
      _newList.add(newItem);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _onRemoveMeal(GroceryItem item) async {
    setState(() {
      _finalList.remove(item);
    });
    final index = _finalList.indexOf(item);
    final url = Uri.https(
        'signal-7900f-default-rtdb.firebaseio.com', 'shooping/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _finalList.remove(item);
      });
    }
  }

  void _loadItems() async {
    try {
      final url = Uri.https(
          'signal-7900f-default-rtdb.firebaseio.com', 'shooping.json');
      final response = await http.get(url);
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }
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
      if (response.statusCode == 404) {
        setState(() {
          _error = 'Try again...';
        });
      }

      setState(() {
        _newList = _finalList;
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _error = 'something went wrong please try again later';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Text(
      'No items here',
      style: Theme.of(context).textTheme.titleLarge,
    ));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_newList.isNotEmpty) {
      content = ListView.builder(
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
              ));
    }
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }
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
