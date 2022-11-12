import 'package:flutter/material.dart';

/// A card displaying information about a set and buttons to edit owned
/// quantities and fetch prices from warframe.market
class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [BoxShadow(blurRadius: 4.0)],
        color: Colors.blueGrey,
      ),
      // Row(Image, Column(Row(Image), Row(Text)))
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.cyan)]),
              child: Image.asset(widget.item.mainPart.path),
            ),
          ),
        ],
      ),
    );
  }
}

/// A set comprised of a main blueprint path and [Part]s, along with nullable
/// price information
class Item {
  final MainPart mainPart;
  final List<Part> parts;
  Price? currentPrice;

  Item({
    required this.mainPart,
    required this.parts,
    this.currentPrice,
  });
}

/// A weapon or warframe part
class Part {
  /// What type of part this is (used to grab the right image)
  PartType type;

  /// Required quantity of this [Part] for a set of the [Item] it's a part of
  final int required;

  /// Owned quantity of this [Part]
  int owned;

  Part({required this.type, required this.required, required this.owned});
  Part.main(int owned) : this(type: PartType.main, required: 1, owned: owned);
}

/// The main [Part] of an item's set
class MainPart extends Part {
  final String path;

  MainPart({
    required Part part,
    required this.path,
  }) : super(
          owned: part.owned,
          required: part.required,
          type: part.type,
        );
}

/// Type of a [Part]
enum PartType {
  main,

  // Gun parts
  barrel,
  receiver,
  stock,

  // Melee parts
  blade,
  handle,

  // Other
  plug,
}

/// Price of an [Item] or [Part]
class Price {
  int current;
  int lowest;

  /// Average of the prices with a decreasing weight starting from the lowest
  /// price down to the 10th lowest (or less if there are less than 10 sell
  /// orders)
  int weightedAverage;

  Price({
    required this.current,
    required this.lowest,
    required this.weightedAverage,
  });
}
