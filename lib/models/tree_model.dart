class Tree {
  final int id;
  final int speciesId;
  int stage;
  final DateTime plantedOn;
  final double x;
  final double y;

  Tree({
    required this.id,
    required this.speciesId,
    required this.stage,
    required this.plantedOn,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'speciesId': speciesId,
      'stage': stage,
      'plantedOn': plantedOn.toIso8601String(),
      'x': x,
      'y': y,
    };
  }

  factory Tree.fromMap(Map<String, dynamic> map) {
    return Tree(
      id: map['id'],
      speciesId: map['speciesId'],
      stage: map['stage'],
      plantedOn: DateTime.parse(map['plantedOn']),
      x: map['x'],
      y: map['y'],
    );
  }
}
