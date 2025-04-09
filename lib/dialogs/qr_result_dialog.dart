import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../models/key_request_model.dart';
import '../providers/app_state.dart';


class QrResultDialog extends StatelessWidget {
  final KeyRequestModel request;

  const QrResultDialog({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                const Icon(Icons.qr_code, color: Colors.white),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Código QR Escaneado',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profesor: ${request.professorName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Asignatura: ${request.subjectName}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Aula: ${request.classroomNumber}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Horario: ${request.startTime} - ${request.endTime}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Día: ${request.dayOfWeek}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  '¿El profesor necesita un dispositivo de control de datos?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        final newRequest =
                            request.copyWith(needsDataControl: false);
                        appState.requests.add(newRequest);
                        appState.approveRequest(newRequest.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Llave aprobada'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        final newRequest =
                            request.copyWith(needsDataControl: true);
                        appState.requests.add(newRequest);
                        appState.approveRequest(newRequest.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Llave y control de datos aprobados'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: const Text('Sí'),
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
