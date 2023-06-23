import 'package:flutter/material.dart';

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
        title: const Text('Grocery items'),
      ),
      body: const Text('Grocery Items here'),
    );
  }
}
