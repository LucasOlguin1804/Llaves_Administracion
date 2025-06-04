import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';
import '../models/schedule_model.dart';
import '../models/key_request_model.dart';
import '../models/classroom_model.dart';
import '../models/external_loan_model.dart';

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
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _schedules = [];
    _requests = [];
    _externalLoans = [];
    notifyListeners();
  }

  // ============================
  // Horarios del docente
  // ============================
  Future<void> fetchSchedulesForDocente(int userId) async {
    final url =
        Uri.parse('http://localhost:3000/api/schedules/docente/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        _schedules = (data['schedules'] as List)
            .map((e) => ScheduleModel(
                  id: e['schedule_id'],
                  subjectName: e['subjectName'],
                  classroomNumber: e['classroomNumber'],
                  startTime: e['start_time'],
                  endTime: e['end_time'],
                  dayOfWeek: e['day_of_week'],
                  professorName: e['professorName'] ?? '',
                  classroomId:
                      e['classroom_id'], 
                ))
            .toList();

        notifyListeners();
      }
    } else {
      throw Exception('Error al cargar horarios');
    }
  }

  // ============================
  // Solicitar llave (crea una solicitud nueva)
  // ============================
  Future<void> requestKey(int scheduleId, bool needsDataControl,
      {String notes = ''}) async {
    final user = _currentUser;
    if (user == null) return;

    final schedule = _schedules.firstWhere((s) => s.id == scheduleId);

    final data = {
      'user_id': user.id,
      'classroom_id': schedule.classroomId,
      'schedule_id': scheduleId,
      'needs_data_control': needsDataControl ? 1 : 0,
      'notes': notes,
    };

    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/key-requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (res.statusCode == 201) {
        await fetchKeyRequests(); 
      } else {
        throw Exception('Error al enviar solicitud: ${res.body}');
      }
    } catch (e) {
      print('Excepción al enviar solicitud: $e');
    }
  }

  Future<void> fetchAllSchedules() async {
    final url = Uri.parse('http://localhost:3000/api/schedules/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        _schedules = (data['schedules'] as List)
            .map((e) => ScheduleModel(
                  id: e['schedule_id'],
                  subjectName: e['subjectName'],
                  classroomNumber: e['classroomNumber'],
                  classroomId: e['classroom_id'],
                  startTime: e['start_time'],
                  endTime: e['end_time'],
                  dayOfWeek: e['day_of_week'],
                  professorName: e['professorName'] ?? '',
                ))
            .toList();
        notifyListeners();
      }
    } else {
      throw Exception('Error al cargar todos los horarios');
    }
  }

  Future<void> registrarPrestamoManual({
    required int userId,
    required int classroomId,
    required int scheduleId,
  }) async {
    final data = {
      'user_id': userId,
      'classroom_id': classroomId,
      'schedule_id': scheduleId,
      'needs_data_control': 0,
      'notes': '',
      'estado': 'approved', 
      'approved_by': _currentUser?.id,
    };

    final url = Uri.parse('http://localhost:3000/api/key-requests/manual');

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (res.statusCode == 201) {
      await fetchKeyRequests();
    } else {
      throw Exception('Error al registrar préstamo manual');
    }
  }

  Future<void> createManualKeyRequest({
    required int userId,
    required int scheduleId,
    required int classroomId,
    required bool needsDataControl,
    required int approvedBy,
  }) async {
    final data = {
      'user_id': userId,
      'classroom_id': classroomId,
      'schedule_id': scheduleId,
      'needs_data_control': needsDataControl ? 1 : 0,
      'estado': 'approved',
      'approved_by': approvedBy,
      'notes': 'Prestado manualmente',
    };

    final res = await http.post(
      Uri.parse('http://localhost:3000/api/key-requests/manual'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (res.statusCode == 201) {
      await fetchKeyRequests(); 
    } else {
      throw Exception('Error al registrar préstamo manual: ${res.body}');
    }
  }

  Future<void> fetchClassrooms() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/api/classrooms'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _classrooms = (data as List)
            .map((e) => ClassroomModel.fromJson({
                  'classroom_id': e['classroom_id'],
                  'number': e['number'],
                  'building_id': e['building_id'] ?? 0,
                  'capacity': e['capacity'] ?? 0,
                  'has_projector': e['has_projector'] ?? 0,
                  'has_computers': e['has_computers'] ?? 0,
                }))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Error al cargar aulas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> fetchExternalLoans() async {
    final url = Uri.parse('http://localhost:3000/api/external-loans');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _externalLoans =
            data.map((e) => ExternalLoanModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        print('Error al obtener préstamos externos: ${response.body}');
      }
    } catch (e) {
      print('Excepción al cargar préstamos externos: $e');
    }
  }

  Future<void> approveRequest(int requestId) async {
    final res = await http.put(
      Uri.parse('http://localhost:3000/api/key-requests/$requestId/approve'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'admin_id': _currentUser?.id}),
    );

    if (res.statusCode == 200) {
      await fetchKeyRequests();
    } else {
      throw Exception('Error al aprobar la solicitud');
    }
  }

  Future<void> completeRequest(int requestId) async {
    final res = await http.put(
      Uri.parse('http://localhost:3000/api/key-requests/$requestId/complete'),
    );

    if (res.statusCode == 200) {
      await fetchKeyRequests();
    } else {
      throw Exception('Error al marcar como devuelta');
    }
  }

  Future<void> fetchKeyRequests() async {
    try {
      final res =
          await http.get(Uri.parse('http://localhost:3000/api/key-requests'));

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List;
        _requests = data.map((e) => KeyRequestModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        throw Exception('Error al obtener solicitudes: ${res.body}');
      }
    } catch (e) {
      print('Excepción al obtener solicitudes: $e');
    }
  }
}
