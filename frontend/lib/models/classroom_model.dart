class ClassroomModel {
  final int id;
  final String number;
  final int buildingId;
  final int capacity;
  final bool hasProjector;
  final bool hasComputer;

  ClassroomModel({
    required this.id,
    required this.number,
    required this.buildingId,
    required this.capacity,
    required this.hasProjector,
    required this.hasComputer,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['classroom_id'],
      number: json['number'],
      buildingId: json['building_id'],
      capacity: json['capacity'],
      hasProjector: json['has_projector'] == 1,
      hasComputer: json['has_computers'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classroom_id': id,
      'number': number,
      'building_id': buildingId,
      'capacity': capacity,
      'has_projector': hasProjector ? 1 : 0,
      'has_computers': hasComputer ? 1 : 0,
    };
  }
}
