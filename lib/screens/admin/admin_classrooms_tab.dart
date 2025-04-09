import 'package:flutter/material.dart';
import '../../config/app_colors.dart'; 
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';


class AdminClassroomsTab extends StatelessWidget {
  const AdminClassroomsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final classrooms = appState.classrooms;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Aulas Disponibles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filtrar'),
                    onPressed: () {
                      // Implementar filtrado
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: classrooms.length,
                itemBuilder: (context, index) {
                  final classroom = classrooms[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.meeting_room,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Aula ${classroom.number}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  classroom.building,
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
                                  const Icon(Icons.layers,
                                      color: AppColors.primary),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Piso: ${classroom.floor}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.people,
                                      color: AppColors.primary),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Capacidad: ${classroom.capacity} personas',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    classroom.hasProjector
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: classroom.hasProjector
                                        ? AppColors.success
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Proyector',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    classroom.hasComputer
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: classroom.hasComputer
                                        ? AppColors.success
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Computadora',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton.icon(
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Editar'),
                                    onPressed: () {
                                      // Implementar edición
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.visibility),
                                    label: const Text('Ver Horarios'),
                                    onPressed: () {
                                      // Implementar vista de horarios
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
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
