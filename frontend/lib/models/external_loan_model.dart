class ExternalLoanModel {
  final int id;
  final String personName;
  final String tipoPersona;
  final int classroomId;
  final int keyId;
  final String estado;
  final DateTime loanTime;
  final DateTime expectedReturnTime;
  final DateTime? actualReturnTime;
  final String registeredBy;

  ExternalLoanModel({
    required this.id,
    required this.personName,
    required this.tipoPersona,
    required this.classroomId,
    required this.keyId,
    required this.estado,
    required this.loanTime,
    required this.expectedReturnTime,
    this.actualReturnTime,
    required this.registeredBy,
  });

  factory ExternalLoanModel.fromJson(Map<String, dynamic> json) {
    return ExternalLoanModel(
      id: json['loan_id'],
      personName: json['person_name'],
      tipoPersona: json['tipo_persona'],
      classroomId: json['classroom_id'],
      keyId: json['key_id'],
      estado: json['estado'],
      loanTime: DateTime.parse(json['loan_time']).toLocal(),
      expectedReturnTime: DateTime.parse(json['expected_return_time']).toLocal(),
      actualReturnTime: json['actual_return_time'] != null
          ? DateTime.parse(json['actual_return_time']).toLocal()
          : null,
      registeredBy: json['registered_by'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_id': id,
      'person_name': personName,
      'tipo_persona': tipoPersona,
      'classroom_id': classroomId,
      'key_id': keyId,
      'estado': estado,
      'loan_time': loanTime.toIso8601String(),
      'expected_return_time': expectedReturnTime.toIso8601String(),
      'actual_return_time': actualReturnTime?.toIso8601String(),
      'registered_by': registeredBy,
    };
  }
}
