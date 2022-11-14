import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'item.dart';

class InventoryGrid extends StatelessWidget {
  InventoryGrid({super.key, this.padding});

  final double? padding;
  final Inventory inventory = Inventory.fromJson(
    jsonDecode(File("assets/inventory.json").readAsStringSync()),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 100,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3,
          ),
          clipBehavior: Clip.none,
          itemCount: inventory.items.length,
          itemBuilder: (BuildContext context, index) {
            return ItemCard(
              item: inventory.items[index],
            );
          },
        ),
      ),
    );
  }
}

class Inventory {
  final List<Item> items;

  Inventory({required this.items});
  Inventory.fromJson(List<dynamic> json)
      : items = json.map((itemJson) => Item.fromJson(itemJson)).toList();
}
