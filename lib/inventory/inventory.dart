import 'model.dart';
import 'item.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class InventoryGrid extends StatelessWidget {
  InventoryGrid({super.key, this.padding});

  final double? padding;
  final List<ItemCard> items = Inventory.fromJson(
    jsonDecode(File("assets/inventory.json").readAsStringSync()),
  )
      .items
      .map((item) => ItemCard(
            name: item.name,
            type: item.type,
            partCards: item.parts
                .map((part) => PartCard(
                      itemType: item.type,
                      part: part,
                    ))
                .toList(),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 100,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 10,
          ),
          clipBehavior: Clip.none,
          itemCount: items.length,
          itemBuilder: (BuildContext context, index) {
            return items[index];
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
