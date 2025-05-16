import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../providers/app_state.dart';
import 'package:provider/provider.dart';

class KeyRequestDialog extends StatefulWidget {
  final int scheduleId;

  const KeyRequestDialog({Key? key, required this.scheduleId})
      : super(key: key);

  @override
  _KeyRequestDialogState createState() => _KeyRequestDialogState();
}

class _KeyRequestDialogState extends State<KeyRequestDialog> {
  bool _needsDataControl = false;
  String? _additionalNotes;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final schedule =
        appState.schedules.firstWhere((s) => s.id == widget.scheduleId);

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
                const Icon(Icons.key, color: Colors.white),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Solicitar Llave',
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
                  schedule.subjectName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aula: ${schedule.classroomNumber}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Horario: ${schedule.startTime} - ${schedule.endTime}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Día: ${schedule.dayOfWeek}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Opciones Adicionales',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Control de Datos'),
                  subtitle: const Text(
                      '¿Necesita un dispositivo de control de datos?'),
                  value: _needsDataControl,
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      _needsDataControl = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Notas Adicionales',
                    hintText: 'Agregue cualquier información adicional aquí',
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    _additionalNotes = value;
                  },
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
  appState.requestKey(
    widget.scheduleId,
    _needsDataControl,
    notes: _additionalNotes ?? '',
  );
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Solicitud de llave enviada correctamente'),
      backgroundColor: AppColors.success,
    ),
  );
}
,
                      child: const Text('Enviar Solicitud'),
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
