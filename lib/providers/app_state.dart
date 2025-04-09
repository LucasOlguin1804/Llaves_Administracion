// Importar ChangeNotifier de Flutter
import 'package:flutter/material.dart';

// Importar los modelos que estás usando
import '../models/user_model.dart';               // Para UserModel
import '../models/schedule_model.dart';           // Para ScheduleModel
import '../models/key_request_model.dart';       // Para KeyRequestModel
import '../models/classroom_model.dart';          // Para ClassroomModel
import '../models/external_loan_model.dart';      // Para ExternalLoanModel

// Importar la librería para trabajar con JSON
import 'dart:convert';                        // Para jsonEncode y jsonDecode



class AppState extends ChangeNotifier {
  UserModel? _currentUser;
  List<ScheduleModel> _schedules = [];
  List<KeyRequestModel> _requests = [];
  List<ClassroomModel> _classrooms = [];
  List<ExternalLoanModel> _externalLoans = [];

  UserModel? get currentUser => _currentUser;
  List<ScheduleModel> get schedules => _schedules;
  List<KeyRequestModel> get requests => _requests;
  List<ClassroomModel> get classrooms => _classrooms;
  List<ExternalLoanModel> get externalLoans => _externalLoans;

  void setUser(UserModel user) {
    _currentUser = user;
    loadUserData();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _schedules = [];
    _requests = [];
    _externalLoans = [];
    notifyListeners();
  }

  Future<void> loadUserData() async {
    if (_currentUser == null) return;

    // En una app real, esto obtendría datos de tu API
    await Future.delayed(const Duration(milliseconds: 500));

    _classrooms = [
      ClassroomModel(
        id: 1,
        number: 'A101',
        building: 'Edificio A',
        floor: '1',
        capacity: 30,
        hasProjector: true,
        hasComputer: true,
      ),
      ClassroomModel(
        id: 2,
        number: 'B202',
        building: 'Edificio B',
        floor: '2',
        capacity: 45,
        hasProjector: true,
        hasComputer: true,
      ),
      ClassroomModel(
        id: 3,
        number: 'C303',
        building: 'Edificio C',
        floor: '3',
        capacity: 60,
        hasProjector: true,
        hasComputer: true,
      ),
      ClassroomModel(
        id: 4,
        number: 'D104',
        building: 'Edificio D',
        floor: '1',
        capacity: 25,
        hasProjector: false,
        hasComputer: true,
      ),
      ClassroomModel(
        id: 5,
        number: 'E205',
        building: 'Edificio E',
        floor: '2',
        capacity: 35,
        hasProjector: true,
        hasComputer: false,
      ),
    ];

    if (_currentUser!.role == 'professor') {
      _schedules = [
        ScheduleModel(
          id: 1,
          subjectName: 'Matemáticas Avanzadas',
          classroomNumber: 'A101',
          startTime: '08:00',
          endTime: '10:00',
          dayOfWeek: 'Lunes',
          professorName: _currentUser!.name,
        ),
        ScheduleModel(
          id: 2,
          subjectName: 'Cálculo Diferencial',
          classroomNumber: 'B202',
          startTime: '13:00',
          endTime: '15:00',
          dayOfWeek: 'Miércoles',
          professorName: _currentUser!.name,
        ),
        ScheduleModel(
          id: 3,
          subjectName: 'Álgebra Lineal',
          classroomNumber: 'C303',
          startTime: '10:00',
          endTime: '12:00',
          dayOfWeek: 'Viernes',
          professorName: _currentUser!.name,
        ),
      ];
    } else if (_currentUser!.role == 'admin') {
      _requests = [
        KeyRequestModel(
          id: 1,
          professorName: 'Dr. Martínez',
          classroomNumber: 'A101',
          subjectName: 'Matemáticas Avanzadas',
          startTime: '08:00',
          endTime: '10:00',
          dayOfWeek: 'Lunes',
          needsDataControl: true,
          status: 'pending',
          requestTime: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        KeyRequestModel(
          id: 2,
          professorName: 'Dra. Rodríguez',
          classroomNumber: 'B202',
          subjectName: 'Física Cuántica',
          startTime: '13:00',
          endTime: '15:00',
          dayOfWeek: 'Miércoles',
          needsDataControl: false,
          status: 'approved',
          requestTime: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        KeyRequestModel(
          id: 3,
          professorName: 'Dr. López',
          classroomNumber: 'D104',
          subjectName: 'Química Orgánica',
          startTime: '15:00',
          endTime: '17:00',
          dayOfWeek: 'Jueves',
          needsDataControl: true,
          status: 'completed',
          requestTime: DateTime.now().subtract(const Duration(days: 1)),
        ),
        KeyRequestModel(
          id: 4,
          professorName: 'Dra. Sánchez',
          classroomNumber: 'E205',
          subjectName: 'Biología Celular',
          startTime: '09:00',
          endTime: '11:00',
          dayOfWeek: 'Martes',
          needsDataControl: true,
          status: 'pending',
          requestTime: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ];
      // Cargar préstamos externos
      _externalLoans = [
        ExternalLoanModel(
          id: 1,
          personName: 'María García',
          personType: 'cleaning',
          classroomNumber: 'A101',
          reason: 'Limpieza programada',
          loanTime: DateTime.now().subtract(const Duration(hours: 3)),
          expectedReturnTime: DateTime.now().add(const Duration(hours: 1)),
          status: 'borrowed',
          registeredBy: 'Administrador',
        ),
        ExternalLoanModel(
          id: 2,
          personName: 'Juan Pérez',
          personType: 'maintenance',
          classroomNumber: 'B202',
          reason: 'Reparación de proyector',
          loanTime: DateTime.now().subtract(const Duration(hours: 5)),
          expectedReturnTime: DateTime.now().subtract(const Duration(hours: 3)),
          status: 'overdue',
          registeredBy: 'Administrador',
        ),
        ExternalLoanModel(
          id: 3,
          personName: 'Dr. Visitante',
          personType: 'guest',
          classroomNumber: 'C303',
          reason: 'Conferencia especial',
          loanTime: DateTime.now().subtract(const Duration(days: 1)),
          expectedReturnTime:
              DateTime.now().subtract(const Duration(hours: 20)),
          actualReturnTime: DateTime.now().subtract(const Duration(hours: 22)),
          status: 'returned',
          registeredBy: 'Administrador',
        ),
      ];
    }

    notifyListeners();
  }

  Future<void> requestKey(int scheduleId, bool needsDataControl) async {
    // En una app real, esto enviaría la solicitud a tu API
    await Future.delayed(const Duration(milliseconds: 500));

    // Encontrar el horario
    final schedule = _schedules.firstWhere((s) => s.id == scheduleId);

    // Crear una nueva solicitud
    final request = KeyRequestModel(
      id: DateTime.now().millisecondsSinceEpoch,
      professorName: _currentUser!.name,
      classroomNumber: schedule.classroomNumber,
      subjectName: schedule.subjectName,
      startTime: schedule.startTime,
      endTime: schedule.endTime,
      dayOfWeek: schedule.dayOfWeek,
      needsDataControl: needsDataControl,
      status: 'pending',
      requestTime: DateTime.now(),
    );

    _requests.add(request);
    notifyListeners();
  }

  Future<void> approveRequest(int requestId) async {
    // En una app real, esto actualizaría el estado de la solicitud en tu API
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(status: 'approved');
      notifyListeners();
    }
  }

  Future<void> completeRequest(int requestId) async {
    // En una app real, esto actualizaría el estado de la solicitud en tu API
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(status: 'completed');
      notifyListeners();
    }
  }

  Future<void> createExternalLoan(ExternalLoanModel loan) async {
    // En una app real, esto enviaría la solicitud a tu API
    await Future.delayed(const Duration(milliseconds: 500));

    final newLoan = loan.copyWith(
      id: DateTime.now().millisecondsSinceEpoch,
      loanTime: DateTime.now(),
      registeredBy: _currentUser!.name,
    );

    _externalLoans.add(newLoan);
    notifyListeners();
  }

  Future<void> returnExternalLoan(int loanId) async {
    // En una app real, esto actualizaría el estado del préstamo en tu API
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _externalLoans.indexWhere((l) => l.id == loanId);
    if (index != -1) {
      _externalLoans[index] = _externalLoans[index].copyWith(
        status: 'returned',
        actualReturnTime: DateTime.now(),
      );
      notifyListeners();
    }
  }

  String generateQrCodeData(int scheduleId) {
    final schedule = _schedules.firstWhere((s) => s.id == scheduleId);
    final data = {
      'professorId': _currentUser!.id,
      'professorName': _currentUser!.name,
      'scheduleId': schedule.id,
      'subjectName': schedule.subjectName,
      'classroomNumber': schedule.classroomNumber,
      'startTime': schedule.startTime,
      'endTime': schedule.endTime,
      'dayOfWeek': schedule.dayOfWeek,
      'timestamp': DateTime.now().toIso8601String(),
    };
    return jsonEncode(data);
  }

  KeyRequestModel? parseQrCodeData(String data) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(data);
      return KeyRequestModel(
        id: DateTime.now().millisecondsSinceEpoch,
        professorName: decoded['professorName'],
        classroomNumber: decoded['classroomNumber'],
        subjectName: decoded['subjectName'],
        startTime: decoded['startTime'],
        endTime: decoded['endTime'],
        dayOfWeek: decoded['dayOfWeek'],
        needsDataControl: false, // Esto vendría de la solicitud del profesor
        status: 'pending',
        requestTime: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
}
