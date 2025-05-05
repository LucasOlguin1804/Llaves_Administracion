// screens/docente/docente_schedule_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule_model.dart';
import '../../providers/app_state.dart';
import '../../dialogs/key_request_dialog.dart';
import '../../config/app_colors.dart';

class DocenteScheduleTab extends StatelessWidget {
  const DocenteScheduleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final schedules = [...appState.schedules];

        if (schedules.isEmpty) {
          return const Center(
            child: Text('No hay horarios disponibles'),
          );
        }

        // Agrupar horarios por día
        final groupedByDay = <String, List<ScheduleModel>>{};

        for (var schedule in schedules) {
          groupedByDay.putIfAbsent(schedule.dayOfWeek, () => []).add(schedule);
        }

        final orderedDays = [
          'Lunes',
          'Martes',
          'Miércoles',
          'Miercoles', // en caso de error de escritura
          'Jueves',
          'Viernes',
          'Sábado',
          'Sabado',
          'Domingo'
        ];

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orderedDays.length,
          itemBuilder: (context, index) {
            final day = orderedDays[index];
            final daySchedules = groupedByDay[day] ?? [];

            if (daySchedules.isEmpty) {
              return const SizedBox.shrink();
            }

            final color = _colorForDay(day);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 24,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...daySchedules
                    .map((schedule) => DocenteScheduleCard(schedule: schedule))
                    .toList(),
                const SizedBox(height: 24),
              ],
            );
          },
        );
      },
    );
  }

  Color _colorForDay(String day) {
    switch (day.toLowerCase()) {
      case 'lunes':
        return const Color(0xFFB3E5FC); // Celeste claro
      case 'martes':
        return const Color(0xFFC8E6C9); // Verde muy clarito
      case 'miércoles':
      case 'miercoles':
        return const Color(0xFFFFF9C4); // Amarillo pastel
      case 'jueves':
        return const Color(0xFFD1C4E9); // Lavanda suave
      case 'viernes':
        return const Color(0xFFB2DFDB); // Aqua suave
      case 'sábado':
      case 'sabado':
        return const Color(0xFFFFCCBC); // Durazno pastel
      case 'domingo':
        return const Color(0xFFD7CCC8); // Marrón muy clarito
      default:
        return const Color(0xFFE0E0E0); // Gris claro de respaldo
    }
  }
}

class DocenteScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;

  const DocenteScheduleCard({Key? key, required this.schedule})
      : super(key: key);

  Color _colorForDay(String day) {
    switch (day.toLowerCase()) {
      case 'lunes':
        return Colors.blue;
      case 'martes':
        return Colors.green;
      case 'miércoles':
      case 'miercoles':
        return Colors.orange;
      case 'jueves':
        return Colors.purple;
      case 'viernes':
        return Colors.teal;
      case 'sábado':
      case 'sabado':
        return Colors.red;
      case 'domingo':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForDay(schedule.dayOfWeek);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.school, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    schedule.subjectName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    schedule.dayOfWeek,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Aula: ${schedule.classroomNumber}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Horario: ${schedule.startTime} - ${schedule.endTime}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.key),
                      label: const Text('Solicitar Llave'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              KeyRequestDialog(scheduleId: schedule.id),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
