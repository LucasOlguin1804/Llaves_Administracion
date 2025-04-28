import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/classroom_model.dart';
import '../../config/app_colors.dart';

class AdminClassroomsTab extends StatefulWidget {
  const AdminClassroomsTab({super.key});

  @override
  State<AdminClassroomsTab> createState() => _AdminClassroomsTabState();
}

class _AdminClassroomsTabState extends State<AdminClassroomsTab> {
  List<ClassroomModel> _classrooms = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchClassrooms();
  }

  Future<void> fetchClassrooms() async {
    final url = Uri.parse('http://localhost:3000/api/classrooms');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _classrooms = data.map((e) => ClassroomModel.fromJson(e)).toList();
          _loading = false;
        });
      } else {
        throw Exception('Error al obtener aulas');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Aulas Disponibles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _classrooms.length,
            itemBuilder: (context, index) {
              final classroom = _classrooms[index];
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
                          const Icon(Icons.meeting_room, color: Colors.white),
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
  }
}
