class ExternalLoanModel {
  final int id;
  final String personName;
  final String personType; // cleaning, maintenance, guest, other
  final String classroomNumber;
  final String reason;
  final DateTime loanTime;
  final DateTime expectedReturnTime;
  final DateTime? actualReturnTime;
  final String status; // borrowed, returned, overdue
  final String registeredBy;
  final String? idDocument;
  final String? idPhotoUrl;
  final String? notes;

  ExternalLoanModel({
    required this.id,
    required this.personName,
    required this.personType,
    required this.classroomNumber,
    required this.reason,
    required this.loanTime,
    required this.expectedReturnTime,
    this.actualReturnTime,
    required this.status,
    required this.registeredBy,
    this.idDocument,
    this.idPhotoUrl,
    this.notes,
  });

  ExternalLoanModel copyWith({
    int? id,
    String? personName,
    String? personType,
    String? classroomNumber,
    String? reason,
    DateTime? loanTime,
    DateTime? expectedReturnTime,
    DateTime? actualReturnTime,
    String? status,
    String? registeredBy,
    String? idDocument,
    String? idPhotoUrl,
    String? notes,
  }) {
    return ExternalLoanModel(
      id: id ?? this.id,
      personName: personName ?? this.personName,
      personType: personType ?? this.personType,
      classroomNumber: classroomNumber ?? this.classroomNumber,
      reason: reason ?? this.reason,
      loanTime: loanTime ?? this.loanTime,
      expectedReturnTime: expectedReturnTime ?? this.expectedReturnTime,
      actualReturnTime: actualReturnTime ?? this.actualReturnTime,
      status: status ?? this.status,
      registeredBy: registeredBy ?? this.registeredBy,
      idDocument: idDocument ?? this.idDocument,
      idPhotoUrl: idPhotoUrl ?? this.idPhotoUrl,
      notes: notes ?? this.notes,
    );
  }
}
