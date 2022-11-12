import 'package:flutter/material.dart';

import 'item.dart';

class Inventory extends StatelessWidget {
  Inventory({super.key, this.padding});

  final double? padding;
  final List<Item> items = [];

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
