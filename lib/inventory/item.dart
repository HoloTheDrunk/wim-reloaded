import '../utils.dart';
import 'model.dart';

import 'package:flutter/material.dart';

import 'package:simple_shadow/simple_shadow.dart';

/// A card displaying information about a set and buttons to edit owned
/// quantities and fetch prices from warframe.market
class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.type,
    required this.name,
    required this.partCards,
  });

  final ItemType type;
  final String name;
  final List<PartCard> partCards;

  String getImagePath() {
    return "assets/items/${type.name}s/main/$name.png";
  }

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Price price = Price(current: 0, lowest: 0, weightedAverage: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      // Row(Image, Column(Row(Image), Row(Text)))
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Main part image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleShadow(
              color: Colors.lightBlueAccent,
              offset: const Offset(0, 0),
              sigma: 5,
              child: Image.asset(widget.getImagePath()),
            ),
          ),

          // Parts and prices
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(children: widget.partCards),
              ),
              Center(
                child: Expanded(
                  flex: 1,
                  child: Text(
                    widget.name.replaceAll('_', ' ').toTitleCase(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PartCard extends StatefulWidget {
  const PartCard({super.key, required this.part, required this.itemType});

  final Part part;
  final ItemType itemType;

  @override
  State<PartCard> createState() => _PartCardState();
}

class _PartCardState extends State<PartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Image.asset(widget.part.getImagePath(widget.itemType)),
    );
  }
}
