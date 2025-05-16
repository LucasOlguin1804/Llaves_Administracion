// screens/admin/admin_classroom_map_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/classroom_model.dart';
import '../../models/schedule_model.dart';
import '../../providers/app_state.dart';
import '../../config/app_colors.dart';

class AdminClassroomMapTab extends StatefulWidget {
  const AdminClassroomMapTab({super.key});

  @override
  State<AdminClassroomMapTab> createState() => _AdminClassroomMapTabState();
}

class _AdminClassroomMapTabState extends State<AdminClassroomMapTab> {
  String? selectedBuildingId;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final classrooms = appState.classrooms;
    final schedules = appState.schedules;

    final buildingOptions =
        classrooms.map((c) => c.buildingId.toString()).toSet().toList();

    final filteredClassrooms = selectedBuildingId == null
        ? classrooms
        : classrooms
            .where((c) => c.buildingId.toString() == selectedBuildingId)
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Edificio'),
            value: selectedBuildingId,
            items: buildingOptions.map((b) {
              return DropdownMenuItem(value: b, child: Text('Edificio $b'));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedBuildingId = value;
              });
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: filteredClassrooms.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, 
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.2, 
              ),
              itemBuilder: (context, index) {
                final classroom = filteredClassrooms[index];
                final claseActual = _buscarClaseActual(classroom.id, schedules);

                final yaPrestada = appState.requests.any((r) =>
                    r.classroomNumber == classroom.number &&
                    r.status == 'approved' &&
                    r.startTime == claseActual?.startTime &&
                    r.endTime == claseActual?.endTime);

                final colorFondo = yaPrestada
                    ? Colors.red.withOpacity(0.25)
                    : claseActual != null
                        ? Colors.orange.withOpacity(0.25)
                        : Colors.green.withOpacity(0.2);

                final colorBorde = yaPrestada
                    ? Colors.red
                    : claseActual != null
                        ? Colors.orange
                        : Colors.green;

                return GestureDetector(
                  onTap: () {
                    _mostrarDialogoAula(context, classroom, claseActual);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorFondo,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorBorde),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        classroom.number,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
/*
  ScheduleModel? _buscarClaseActual(
      int classroomId, List<ScheduleModel> schedules) {
    final now = DateTime.now();
    final today = _diaAtexto(now.weekday);

    for (var s in schedules) {
      if (s.classroomId == classroomId &&
          s.dayOfWeek.toLowerCase() == today.toLowerCase()) {
        final start = _parseTime(s.startTime);
        final end = _parseTime(s.endTime);

        if (now.isAfter(start) && now.isBefore(end)) {
          return s;
        }
      }
    }

    return null;
  }
*/

  ScheduleModel? _buscarClaseActual(
      int classroomId, List<ScheduleModel> schedules) {
    // 👇 Simula lunes a las 08:35
    final simulatedDay = 'Lunes';
    final simulatedTime = '08:35:00';

    for (var s in schedules) {
      if (s.classroomId == classroomId &&
          s.dayOfWeek.toLowerCase() == simulatedDay.toLowerCase() &&
          simulatedTime.compareTo(s.startTime) >= 0 &&
          simulatedTime.compareTo(s.endTime) <= 0) {
        return s;
      }
    }
    return null;
  }

  DateTime _parseTime(String timeStr) {
    final now = DateTime(2025, 5, 13, 8, 35); // lunes 8:35

    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final second = parts.length > 2 ? int.parse(parts[2]) : 0;
    return DateTime(now.year, now.month, now.day, hour, minute, second);
  }

  String _diaAtexto(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  void _mostrarDialogoAula(BuildContext context, ClassroomModel classroom,
      ScheduleModel? claseActual) {
    final appState = Provider.of<AppState>(context, listen: false);

    final yaPrestada = claseActual != null &&
        appState.requests.any((r) =>
            r.classroomNumber == classroom.number &&
            r.status == 'approved' &&
            r.startTime == claseActual.startTime &&
            r.endTime == claseActual.endTime);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Aula ${classroom.number}'),
        content: claseActual == null
            ? const Text('No hay clase en este momento.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Materia: ${claseActual.subjectName}'),
                  Text('Docente: ${claseActual.professorName}'),
                  Text(
                      'Horario: ${claseActual.startTime} - ${claseActual.endTime}'),
                  const SizedBox(height: 10),
                  Text(yaPrestada
                      ? '¿Deseas marcar como devuelto?'
                      : '¿Deseas marcar como prestado?'),
                ],
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          if (claseActual != null)
            TextButton(
              onPressed: () async {
                if (yaPrestada) {
                  final request = appState.requests.firstWhere((r) =>
                      r.classroomNumber == classroom.number &&
                      r.status == 'approved' &&
                      r.startTime == claseActual.startTime &&
                      r.endTime == claseActual.endTime);

                  await appState.completeRequest(request.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marcado como devuelto')),
                  );
                } else {
                  final userId = appState.currentUser?.id ?? 1; // admin
                  await appState.createManualKeyRequest(
                    userId: userId,
                    scheduleId: claseActual.id,
                    classroomId: claseActual.classroomId,
                    needsDataControl: false,
                    approvedBy: userId,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marcado como prestado')),
                  );
                }

                Navigator.pop(context);
              },
              child: Text(yaPrestada ? 'Marcar como Devuelto' : 'Prestar'),
            ),
        ],
      ),
    );
  }
}
