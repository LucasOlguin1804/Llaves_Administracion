class ClassroomModel {
  final int id;
  final String number;
  final String building;
  final String floor;
  final int capacity;
  final bool hasProjector;
  final bool hasComputer;

  ClassroomModel({
    required this.id,
    required this.number,
    required this.building,
    required this.floor,
    required this.capacity,
    required this.hasProjector,
    required this.hasComputer,
  });
}
