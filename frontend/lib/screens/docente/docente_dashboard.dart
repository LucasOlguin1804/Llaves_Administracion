// screens/docente/docente_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../providers/app_state.dart';
import '../login/login_screen.dart';
import 'docente_schedule_tab.dart';
import 'docente_requests_tab.dart';
import 'docente_profile_tab.dart';

class DocenteDashboard extends StatefulWidget {
  const DocenteDashboard({super.key});

  @override
  State<DocenteDashboard> createState() => _DocenteDashboardState();
}

class _DocenteDashboardState extends State<DocenteDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final user = appState.currentUser;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Por favor inicie sesión')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Text(
              'Bienvenido, ${user.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  appState.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(icon: Icon(Icons.calendar_today), text: 'Horario'),
                Tab(icon: Icon(Icons.key), text: 'Solicitudes'),
                Tab(icon: Icon(Icons.person), text: 'Perfil'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              DocenteScheduleTab(),
              DocenteRequestsTab(),
              DocenteProfileTab(),
            ],
          ),
        );
      },
    );
  }
}
