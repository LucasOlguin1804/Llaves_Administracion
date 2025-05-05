class KeyRequestModel {
  final int id;
  final String professorName;
  final String classroomNumber;
  final String subjectName;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final bool needsDataControl;
  final String status; // pending, approved, completed
  final DateTime requestTime;

  KeyRequestModel({
    required this.id,
    required this.professorName,
    required this.classroomNumber,
    required this.subjectName,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.needsDataControl,
    required this.status,
    required this.requestTime,
  });

  KeyRequestModel copyWith({
    int? id,
    String? professorName,
    String? classroomNumber,
    String? subjectName,
    String? startTime,
    String? endTime,
    String? dayOfWeek,
    bool? needsDataControl,
    String? status,
    DateTime? requestTime,
  }) {
    return KeyRequestModel(
      id: id ?? this.id,
      professorName: professorName ?? this.professorName,
      classroomNumber: classroomNumber ?? this.classroomNumber,
      subjectName: subjectName ?? this.subjectName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      needsDataControl: needsDataControl ?? this.needsDataControl,
      status: status ?? this.status,
      requestTime: requestTime ?? this.requestTime,
    );
  }
}
