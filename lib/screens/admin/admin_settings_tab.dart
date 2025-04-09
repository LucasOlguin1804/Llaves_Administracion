import 'package:flutter/material.dart';
import '../../config/app_colors.dart'; 
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';
import '../../screens/login/login_screen.dart';

class AdminSettingsTab extends StatelessWidget {
  const AdminSettingsTab({super.key});

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
                    // Implementar cambio de tema
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
                    // Implementar cambio
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
                    // Implementar cambio
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.history, color: AppColors.primary),
                  title: const Text('Historial de Llaves'),
                  subtitle: const Text('Ver registro histórico de entregas'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Implementar vista de historial
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Acerca de',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info, color: AppColors.primary),
                  title: Text('KeyMaster Pro'),
                  subtitle: Text('Versión 1.0.0'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.help, color: AppColors.primary),
                  title: Text('Ayuda y Soporte'),
                  subtitle: Text('Contactar al equipo de soporte'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.description, color: AppColors.primary),
                  title: Text('Términos y Condiciones'),
                  subtitle: Text('Leer políticas de uso'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
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
