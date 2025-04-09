import 'package:flutter/material.dart';
import '../../config/app_colors.dart';          
import '../../models/external_loan_model.dart'; 
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ExternalLoanCard extends StatelessWidget {
  final ExternalLoanModel loan;

  const ExternalLoanCard({Key? key, required this.loan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (loan.status) {
      case 'borrowed':
        statusColor = AppColors.info;
        statusIcon = Icons.access_time;
        statusText = 'Prestado';
        break;
      case 'overdue':
        statusColor = AppColors.error;
        statusIcon = Icons.warning;
        statusText = 'Vencido';
        break;
      case 'returned':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'Devuelto';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
        statusText = 'Desconocido';
    }

    String personTypeText;
    IconData personTypeIcon;

    switch (loan.personType) {
      case 'cleaning':
        personTypeText = 'Limpieza';
        personTypeIcon = Icons.cleaning_services;
        break;
      case 'maintenance':
        personTypeText = 'Mantenimiento';
        personTypeIcon = Icons.build;
        break;
      case 'guest':
        personTypeText = 'Invitado';
        personTypeIcon = Icons.person;
        break;
      default:
        personTypeText = 'Otro';
        personTypeIcon = Icons.category;
    }

    final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    loan.personName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
                    Icon(personTypeIcon, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Tipo: $personTypeText',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Aula: ${loan.classroomNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.description, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Motivo: ${loan.reason}',
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Prestado: ${dateFormat.format(loan.loanTime)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.event, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Devolución esperada: ${dateFormat.format(loan.expectedReturnTime)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (loan.actualReturnTime != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success),
                      const SizedBox(width: 8),
                      Text(
                        'Devuelto: ${dateFormat.format(loan.actualReturnTime!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                if (loan.status == 'borrowed' || loan.status == 'overdue')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.message),
                        label: const Text('Recordatorio'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Recordatorio enviado'),
                              backgroundColor: AppColors.info,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text('Marcar Devuelto'),
                        onPressed: () {
                          appState.returnExternalLoan(loan.id);
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
