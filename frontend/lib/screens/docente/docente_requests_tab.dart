import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';
import '../../widgets/cards/request_card.dart';

class DocenteRequestsTab extends StatefulWidget {
  const DocenteRequestsTab({Key? key}) : super(key: key);

  @override
  State<DocenteRequestsTab> createState() => _DocenteRequestsTabState();
}

class _DocenteRequestsTabState extends State<DocenteRequestsTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AppState>(context, listen: false).fetchKeyRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final userId = appState.currentUser?.id;
        if (userId == null) {
          return const Center(child: Text('Usuario no autenticado'));
        }

        final myRequests = appState.requests
            .where((r) => r.userId == userId)
            .toList();

        final pending = myRequests.where((r) => r.status == 'pending').toList();
        final approved = myRequests.where((r) => r.status == 'approved').toList();
        final completed = myRequests.where((r) => r.status == 'completed').toList();

        final bool hasRequests =
            pending.isNotEmpty || approved.isNotEmpty || completed.isNotEmpty;

        if (!hasRequests) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No has realizado solicitudes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Solicita llaves desde la pestaña de horarios',
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
              ...pending.map((r) => RequestCard(request: r, isAdmin: false)),
              const SizedBox(height: 24),
            ],
            if (approved.isNotEmpty) ...[
              const Text(
                '✅ Llaves Prestadas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...approved.map((r) => RequestCard(request: r, isAdmin: false)),
              const SizedBox(height: 24),
            ],
            if (completed.isNotEmpty) ...[
              const Text(
                '📦 Llaves Devueltas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 8),
              ...completed.map((r) => RequestCard(request: r, isAdmin: false)),
              const SizedBox(height: 24),
            ],
          ],
        );
      },
    );
  }
}
