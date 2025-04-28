import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Usuarios del Sistema',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Nuevo Usuario'),
                onPressed: () {
                  // Implementar creación de usuario
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildUserCard(
                  name: 'Dr. Martínez',
                  email: 'martinez@universidad.edu',
                  role: 'professor',
                  avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
                ),
                _buildUserCard(
                  name: 'Dra. Rodríguez',
                  email: 'rodriguez@universidad.edu',
                  role: 'professor',
                  avatarUrl: 'https://randomuser.me/api/portraits/women/28.jpg',
                ),
                _buildUserCard(
                  name: 'Dr. López',
                  email: 'lopez@universidad.edu',
                  role: 'professor',
                  avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                ),
                _buildUserCard(
                  name: 'Administrador',
                  email: 'admin@universidad.edu',
                  role: 'admin',
                  avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                ),
                _buildUserCard(
                  name: 'Personal de Limpieza',
                  email: 'limpieza@universidad.edu',
                  role: 'maintenance',
                  avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String role,
    String? avatarUrl,
  }) {
    String roleText;
    Color roleColor;

    switch (role) {
      case 'admin':
        roleText = 'Administrador';
        roleColor = AppColors.primary;
        break;
      case 'professor':
        roleText = 'Docente';
        roleColor = AppColors.info;
        break;
      case 'maintenance':
        roleText = 'Mantenimiento';
        roleColor = AppColors.warning;
        break;
      default:
        roleText = 'Usuario';
        roleColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  avatarUrl != null ? NetworkImage(avatarUrl) : null,
              child:
                  avatarUrl == null ? const Icon(Icons.person, size: 30) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: roleColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      roleText,
                      style: TextStyle(
                        color: roleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.primary),
              onPressed: () {
                // Implementar edición de usuario
              },
            ),
          ],
        ),
      ),
    );
  }
}
