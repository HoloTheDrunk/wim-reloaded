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
  Price price = Price(lowest: 0, weightedAverage: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
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
          Column(
            children: [
              Expanded(
                flex: 3,
                child: SimpleShadow(
                  color: Colors.lightBlueAccent,
                  offset: const Offset(0, 0),
                  sigma: 5,
                  child: Image.asset(widget.getImagePath()),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.name.replaceAll('_', ' ').toTitleCase(),
                ),
              ),
            ],
          ),

          // Parts and prices
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(children: widget.partCards),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      PriceWidget.unloaded(
                        color: Colors.green,
                        overlay: Icons.keyboard_arrow_down,
                      ),
                      PriceWidget.unloaded(
                        color: Colors.orange,
                        overlay: Icons.functions_rounded,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PartCard extends StatefulWidget {
  const PartCard({
    super.key,
    required this.type,
    required this.required,
    required this.itemType,
  });

  final PartType type;
  final int required;
  final ItemType itemType;

  String getImagePath(ItemType itemType) {
    return "assets/items/${itemType.name}s/parts/${type.name}.png";
  }

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
      child: Image.asset(widget.getImagePath(widget.itemType)),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    required this.color,
    required this.overlay,
  });

  const PriceWidget.unloaded({
    super.key,
    required this.color,
    required this.overlay,
  }) : price = 0;

  final int price;

  final Color color;
  final IconData overlay;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset("assets/platinum.png"),
          Opacity(
            opacity: 0.75,
            child: Icon(overlay, color: color),
          ),
        ]),
      ),
      Text(
        style: TextStyle(color: color),
        price.toString(),
      ),
    ]);
  }
}
