import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import '../../widgets/cards/request_card.dart';
import '../../models/key_request_model.dart';

class AdminRequestsTab extends StatelessWidget {
  const AdminRequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final List<KeyRequestModel> pending =
            appState.requests.where((r) => r.status == 'pending').toList();
        final List<KeyRequestModel> approved =
            appState.requests.where((r) => r.status == 'approved').toList();
        final List<KeyRequestModel> completed =
            appState.requests.where((r) => r.status == 'completed').toList();

        final bool hasRequests =
            pending.isNotEmpty || approved.isNotEmpty || completed.isNotEmpty;

        if (!hasRequests) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.inbox, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No hay solicitudes pendientes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Las solicitudes de llaves aparecerán aquí',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (pending.isNotEmpty) ...[
              const Text(
                '🔶 Solicitudes Pendientes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...pending.map((r) => RequestCard(request: r, isAdmin: true)),
              const SizedBox(height: 24),
            ],
            if (approved.isNotEmpty) ...[
              const Text(
                '✅ Solicitudes Prestadas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...approved.map((r) => RequestCard(request: r, isAdmin: true)),
              const SizedBox(height: 24),
            ],
            if (completed.isNotEmpty) ...[
              const Text(
                '📦 Solicitudes Completadas',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 8),
              ...completed.map((r) => RequestCard(request: r, isAdmin: true)),
              const SizedBox(height: 24),
            ],
          ],
        );
      },
    );
  }
}
