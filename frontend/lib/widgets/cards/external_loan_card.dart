import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/app_colors.dart';
import '../../models/external_loan_model.dart';
import '../../models/classroom_model.dart';
import 'package:intl/intl.dart';

class ExternalLoanCard extends StatefulWidget {
  final ExternalLoanModel loan;
  final List<ClassroomModel> classrooms;
  final VoidCallback? onMarkedReturned;

  const ExternalLoanCard({
    Key? key,
    required this.loan,
    required this.classrooms,
    this.onMarkedReturned,
  }) : super(key: key);

  @override
  State<ExternalLoanCard> createState() => _ExternalLoanCardState();
}

class _ExternalLoanCardState extends State<ExternalLoanCard> {
  bool markedReturned = false;
  bool markedOverdue = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 25), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final classroom = widget.classrooms.firstWhere(
      (c) => c.id == loan.classroomId,
      orElse: () => ClassroomModel(
        id: loan.classroomId,
        number: 'Desconocido',
        buildingId: 0,
        capacity: 0,
        hasProjector: false,
        hasComputer: false,
      ),
    );

    final bool isOverdue = loan.expectedReturnTime.isBefore(DateTime.now());

    Color? cardColor;
    if (markedReturned) {
      cardColor = AppColors.success.withValues(alpha:0.9);
    } else if (markedOverdue || isOverdue) {
      cardColor = AppColors.error.withValues(alpha:0.7);
    } else {
      cardColor = AppColors.info.withValues(alpha:0.9);
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isOverdue ? AppColors.error : AppColors.info,
          child: Icon(
            isOverdue ? Icons.warning : Icons.access_time,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Nombre: ${loan.personName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: ${loan.tipoPersona}'),
            Text('Aula: ${classroom.number}'),
            Text('Devuelve: ${DateFormat('yyyy-MM-dd – kk:mm').format(loan.expectedReturnTime)}'),
            if (markedReturned) const Text('Devuelto ✅'),
            if (markedOverdue) const Text('Vencido ✖'),
          ],
        ),
        trailing: TextButton(
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Confirmar'),
                content: Text(isOverdue
                    ? '¿Marcar este préstamo como vencido?'
                    : '¿Marcar este préstamo como devuelto?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Sí, confirmar'),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              if (isOverdue) {
                final res = await http.put(
                  Uri.parse('http://localhost:3000/api/external-loans/${loan.id}/vencer'),
                );
                if (res.statusCode == 200) {
                  setState(() {
                    markedOverdue = true;
                  });
                }
              } else {
                final res = await http.put(
                  Uri.parse('http://localhost:3000/api/external-loans/${loan.id}/devolver'),
                );
                if (res.statusCode == 200) {
                  setState(() {
                    markedReturned = true;
                  });
                }
              }

              await Future.delayed(const Duration(seconds: 3));
              if (widget.onMarkedReturned != null) {
                widget.onMarkedReturned!();
              }
            }
          },
          child: Text(
            isOverdue ? 'Marcar como vencido' : 'Marcar como devuelto',
          ),
        ),
      ),
    );
  }
}
