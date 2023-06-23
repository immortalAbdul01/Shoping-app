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
      body: Column(
        children: [
          for (final item in groceryItems)
            Row(
              children: [
                Text(item.name),
                const SizedBox(
                  width: 20,
                ),
                Text(item.category.title),
                const Spacer(),
                Icon(
                  Icons.square,
                  color: item.category.color,
                )
              ],
            )
        ],
      ),
    ));
  }
}
