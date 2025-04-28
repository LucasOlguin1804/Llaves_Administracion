import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../models/external_loan_model.dart';
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ExternalLoanDialog extends StatefulWidget {
  const ExternalLoanDialog({super.key});

  @override
  _ExternalLoanDialogState createState() => _ExternalLoanDialogState();
}

class _ExternalLoanDialogState extends State<ExternalLoanDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reasonController = TextEditingController();
  final _idDocumentController = TextEditingController();
  String _personType = 'cleaning';
  String _selectedClassroom = 'A101';
  DateTime _expectedReturnTime = DateTime.now().add(const Duration(hours: 2));

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    _idDocumentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final classrooms = appState.classrooms;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_alt, color: Colors.white),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Nuevo Préstamo Externo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la Persona',
                        hintText: 'Ingrese el nombre completo',
                        prefixIcon:
                            Icon(Icons.person, color: AppColors.primary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Personal',
                        prefixIcon:
                            Icon(Icons.category, color: AppColors.primary),
                      ),
                      value: _personType,
                      items: const [
                        DropdownMenuItem(
                          value: 'cleaning',
                          child: Text('Personal de Limpieza'),
                        ),
                        DropdownMenuItem(
                          value: 'maintenance',
                          child: Text('Personal de Mantenimiento'),
                        ),
                        DropdownMenuItem(
                          value: 'guest',
                          child: Text('Invitado'),
                        ),
                        DropdownMenuItem(
                          value: 'other',
                          child: Text('Otro'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _personType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Aula',
                        prefixIcon:
                            Icon(Icons.meeting_room, color: AppColors.primary),
                      ),
                      value: _selectedClassroom,
                      items: classrooms.map((classroom) {
                        return DropdownMenuItem(
                          value: classroom.number,
                          child: Text(
                              '${classroom.number} (${classroom.buildingId})'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedClassroom = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _reasonController,
                      decoration: const InputDecoration(
                        labelText: 'Motivo',
                        hintText: 'Ingrese el motivo del préstamo',
                        prefixIcon:
                            Icon(Icons.description, color: AppColors.primary),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un motivo';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _expectedReturnTime,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                        );
                        if (picked != null) {
                          final TimeOfDay? timePicked = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(_expectedReturnTime),
                          );
                          if (timePicked != null) {
                            setState(() {
                              _expectedReturnTime = DateTime(
                                picked.year,
                                picked.month,
                                picked.day,
                                timePicked.hour,
                                timePicked.minute,
                              );
                            });
                          }
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Hora Estimada de Devolución',
                          prefixIcon:
                              Icon(Icons.event, color: AppColors.primary),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(_expectedReturnTime),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _idDocumentController,
                      decoration: const InputDecoration(
                        labelText: 'Documento de Identidad',
                        hintText: 'Ingrese el número de documento',
                        prefixIcon: Icon(Icons.badge, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar Foto de ID'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Función de cámara no implementada en el prototipo'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final loan = ExternalLoanModel(
                                id: 0, // Se asignará en el método createExternalLoan
                                personName: _nameController.text,
                                personType: _personType,
                                classroomNumber: _selectedClassroom,
                                reason: _reasonController.text,
                                loanTime: DateTime.now(),
                                expectedReturnTime: _expectedReturnTime,
                                status: 'borrowed',
                                registeredBy: '',
                                idDocument:
                                    _idDocumentController.text.isNotEmpty
                                        ? _idDocumentController.text
                                        : null,
                              );

                              appState.createExternalLoan(loan);
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Préstamo externo registrado correctamente'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          },
                          child: const Text('Registrar Préstamo'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
