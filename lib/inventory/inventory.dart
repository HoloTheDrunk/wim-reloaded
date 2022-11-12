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
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return ItemCard(
              item: Item(
                mainPart: MainPart(
                  owned: 1,
                  path: "assets/items/weapons/main/destreza_prime.png",
                ),
                parts: [],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Inventory {
  List<Item> items = [];

  Inventory({required this.items});
  Inventory.fromJson(List<dynamic> json) {
    items = json
        .map(
          (itemJson) => Item(
            mainPart: MainPart(
              owned: itemJson['main']['owned'],
              path: itemJson['main']['path'],
            ),
            parts: (itemJson['parts'] as List<dynamic>)
                .map(
                  (partJson) => Part(
                    type: PartType.values.byName(partJson['type']),
                    required: partJson['required'],
                    owned: partJson['owned'],
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}
