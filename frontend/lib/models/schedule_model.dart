class ScheduleModel {
  final int id;
  final String subjectName;
  final String classroomNumber;
  final int classroomId;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final String professorName;

  ScheduleModel({
    required this.id,
    required this.subjectName,
    required this.classroomNumber,
    required this.classroomId, 
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.professorName,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['schedule_id'],
      subjectName: json['subjectName'],
      classroomNumber: json['classroomNumber'],
      classroomId: json['classroom_id'], 
      startTime: json['start_time'],
      endTime: json['end_time'],
      dayOfWeek: json['day_of_week'],
      professorName: json['professorName'] ?? '',
    );
  }
}
