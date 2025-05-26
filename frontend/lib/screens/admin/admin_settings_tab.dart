//import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import '../../screens/login/login_screen.dart';

class AdminSettingsTab extends StatefulWidget {
  const AdminSettingsTab({super.key});

  @override
  State<AdminSettingsTab> createState() => _AdminSettingsTabState();
}

class _AdminSettingsTabState extends State<AdminSettingsTab> {
  int? selectedYear;
  String? selectedSemester;
  PlatformFile? selectedFile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configuración del Sistema',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.notifications, color: AppColors.primary),
                  title: Text('Notificaciones'),
                  subtitle: Text('Configurar alertas y recordatorios'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.backup, color: AppColors.primary),
                  title: Text('Respaldo de Datos'),
                  subtitle: Text('Configurar copias de seguridad automáticas'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.security, color: AppColors.primary),
                  title: Text('Seguridad'),
                  subtitle: Text('Configurar opciones de seguridad'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(),
                SwitchListTile(
                  secondary:
                      const Icon(Icons.dark_mode, color: AppColors.primary),
                  title: const Text('Modo Oscuro'),
                  subtitle: const Text('Cambiar apariencia de la aplicación'),
                  value: false,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Configuración de Llaves',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary:
                      const Icon(Icons.approval, color: AppColors.primary),
                  title: const Text('Aprobación Automática'),
                  subtitle: const Text(
                      'Aprobar solicitudes automáticamente para profesores regulares'),
                  value: false,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    
                  },
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.timer, color: AppColors.primary),
                  title: const Text('Recordatorios de Devolución'),
                  subtitle:
                      const Text('Enviar recordatorios para devolver llaves'),
                  value: true,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.history, color: AppColors.primary),
                  title: const Text('Historial de Llaves'),
                  subtitle: const Text('Ver registro histórico de entregas'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Importar Horarios desde Excel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: 'Año'),
            items: [2024, 2025, 2026].map((year) {
              return DropdownMenuItem(value: year, child: Text('$year'));
            }).toList(),
            onChanged: (val) => setState(() => selectedYear = val),
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Semestre'),
            items: ['1', '2'].map((sem) {
              return DropdownMenuItem(value: sem, child: Text('Semestre $sem'));
            }).toList(),
            onChanged: (val) => setState(() => selectedSemester = val),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.upload_file),
            label: const Text('Seleccionar Archivo Excel'),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx'],
                withData: true,
              );

              if (result != null && result.files.single.bytes != null) {
                setState(() => selectedFile = result.files.single);
              }
            },
          ),
          if (selectedFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('Archivo seleccionado: ${selectedFile!.name}'),
            ),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('Importar'),
            onPressed: (selectedYear != null &&
                    selectedSemester != null &&
                    selectedFile != null)
                ? () async {
                    final uri =
                        Uri.parse("http://localhost:3000/api/import-excel");
                    final request = http.MultipartRequest('POST', uri);
                    request.fields['anio'] = selectedYear.toString();
                    request.fields['semestre'] = selectedSemester!;
                    request.files.add(http.MultipartFile.fromBytes(
                      'file',
                      selectedFile!.bytes!,
                      filename: selectedFile!.name,
                    ));

                    final response = await request.send();
                    if (response.statusCode == 200) {
                      final body = await response.stream.bytesToString();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Importación exitosa: $body')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Error al importar: ${response.statusCode}')),
                      );
                    }
                  }
                : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar Sesión'),
              onPressed: () {
                Provider.of<AppState>(context, listen: false).logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
