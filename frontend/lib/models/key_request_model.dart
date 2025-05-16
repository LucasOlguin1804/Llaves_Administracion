class KeyRequestModel {
  final int id;
  final int userId;
  final int classroomId;
  final int scheduleId;
  final String professorName;
  final String classroomNumber;
  final String subjectName;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final bool needsDataControl;
  final String status;
  final DateTime requestTime;
  final DateTime? returnTime;
  final int? approvedBy;
  final String notes;

  KeyRequestModel({
    required this.id,
    required this.userId,
    required this.classroomId,
    required this.scheduleId,
    required this.professorName,
    required this.classroomNumber,
    required this.subjectName,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.needsDataControl,
    required this.status,
    required this.requestTime,
    this.returnTime,
    this.approvedBy,
    this.notes = '',
  });

  factory KeyRequestModel.fromJson(Map<String, dynamic> json) {
    return KeyRequestModel(
      id: json['request_id'],
      userId: json['user_id'],
      classroomId: json['classroom_id'],
      scheduleId: json['schedule_id'],
      professorName: json['professor_name'],
      subjectName: json['subject_name'],
      classroomNumber: json['classroom_number'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      dayOfWeek: json['day_of_week'],
      needsDataControl: json['needs_data_control'] == 1,
      status: json['estado'],
      requestTime: DateTime.parse(json['request_time']),
      returnTime: json['return_time'] != null
          ? DateTime.tryParse(json['return_time'])
          : null,
      approvedBy: json['approved_by'],
      notes: json['notes'] ?? '',
    );
  }
}
