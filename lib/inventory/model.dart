/// A set comprised of a main blueprint path and [Part]s, along with nullable
/// price information
class Item {
  final ItemType type;
  final String name;
  final List<Part> parts;

  Item({
    required this.type,
    required this.name,
    required this.parts,
  });

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = ItemType.values.byName(json['type']),
        parts = (json['parts'] as List<dynamic>)
            .map((partJson) => Part.fromJson(partJson))
            .toList();
}

/// Type of an [Item]
enum ItemType {
  warframe,
  weapon,
}

/// A weapon or warframe part
class Part {
  /// What type of part this is (used to grab the right image)
  final PartType type;

  /// Required quantity of this [Part] for a set of the [Item] it's a part of
  final int required;

  /// Owned quantity of this [Part]
  int owned;

  Part({required this.type, required this.required, required this.owned});

  Part.fromJson(Map<String, dynamic> json)
      : type = PartType.values.byName(json['type']),
        required = json['required'],
        owned = json['owned'];

  String getImagePath(ItemType itemType) {
    return "assets/items/${itemType.name}s/parts/${type.name}.png";
  }
}

/// Type of a [Part]
enum PartType {
  main,

  // Warframe parts
  chassis,
  neuroptics,
  systems,

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
