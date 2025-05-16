import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class ExternalLoanDialog extends StatefulWidget {
  const ExternalLoanDialog({super.key});

  @override
  _ExternalLoanDialogState createState() => _ExternalLoanDialogState();
}

class _ExternalLoanDialogState extends State<ExternalLoanDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  String? _selectedClassroomId;
  int? _associatedKeyId;
  String? _personType = 'Personal de limpieza';
  DateTime _expectedReturnTime = DateTime.now().add(const Duration(hours: 2));

  final List<String> _personTypes = [
    'Personal de Mantenimiento',
    'Personal de limpieza',
    'Invitado',
    'Otro'
  ];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).fetchClassrooms();
  }

  Future<void> _fetchKeyForClassroom(String classroomId) async {
    try {
      final res = await http.get(
        Uri.parse('http://localhost:3000/api/keys?classroom_id=$classroomId'),
      );

      final data = json.decode(res.body);
      if (data.isNotEmpty) {
        setState(() {
          _associatedKeyId = data[0]['key_id'];
        });
      } else {
        setState(() {
          _associatedKeyId = null;
        });
      }
    } catch (e) {
      print('[FLUTTER] Error al obtener llave: $e');
    }
  }

  Future<void> _submitLoan() async {
    if (!_formKey.currentState!.validate() ||
        _associatedKeyId == null ||
        _selectedClassroomId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor, completa todos los campos correctamente.')),
      );
      return;
    }

    final userId =
        Provider.of<AppState>(context, listen: false).currentUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Usuario no autenticado')));
      return;
    }

    final data = {
      'person_name': _nameController.text,
      'tipo_persona': _personType,
      'classroom_id': int.parse(_selectedClassroomId!),
      'key_id': _associatedKeyId,
      'expected_return_time': _expectedReturnTime.toIso8601String(),
      'registered_by': userId
    };

    setState(() => _isSubmitting = true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/external-loans'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Préstamo registrado con éxito')));
      } else {
        throw Exception('Error: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al enviar: $e')));
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final classrooms = appState.classrooms;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuevo Préstamo Externo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: 'Nombre de la persona'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _personType,
                  decoration: InputDecoration(labelText: 'Tipo de persona'),
                  items: _personTypes.map((tipo) {
                    return DropdownMenuItem(value: tipo, child: Text(tipo));
                  }).toList(),
                  onChanged: (value) => setState(() => _personType = value),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedClassroomId,
                  decoration: InputDecoration(labelText: 'Aula'),
                  items: classrooms.map((classroom) {
                    return DropdownMenuItem(
                      value: classroom.id.toString(),
                      child: Text(classroom.number),
                    );
                  }).toList(),
                  onChanged: (value) async {
                    setState(() => _selectedClassroomId = value);
                    await _fetchKeyForClassroom(value!);
                    if (_associatedKeyId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'No hay llave disponible para esta aula.')),
                      );
                    }
                  },
                  validator: (value) =>
                      value == null ? 'Selecciona un aula' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Fecha devolución: ${DateFormat('yyyy-MM-dd').format(_expectedReturnTime)}'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _expectedReturnTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _expectedReturnTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              _expectedReturnTime.hour,
                              _expectedReturnTime.minute,
                            );
                          });
                        }
                      },
                      child: Text('Cambiar Fecha'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Hora devolución: ${DateFormat('HH:mm').format(_expectedReturnTime)}'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(_expectedReturnTime),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _expectedReturnTime = DateTime(
                              _expectedReturnTime.year,
                              _expectedReturnTime.month,
                              _expectedReturnTime.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      },
                      child: Text('Cambiar Hora'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar')),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitLoan,
                      child: Text('Guardar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
