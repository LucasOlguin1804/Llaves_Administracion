class ScheduleModel {
  final int id;
  final String subjectName;
  final String classroomNumber;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final String professorName;

  ScheduleModel({
    required this.id,
    required this.subjectName,
    required this.classroomNumber,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.professorName,
  });
}
