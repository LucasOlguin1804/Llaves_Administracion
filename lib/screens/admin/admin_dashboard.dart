import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../providers/app_state.dart';
import 'package:provider/provider.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/admin/admin_classrooms_tab.dart';
import '../../screens/admin/admin_requests_tab.dart';
import '../../screens/admin/admin_users_tab.dart';
import '../../screens/admin/admin_settings_tab.dart';
import '../../dialogs/qr_scanner_view.dart';
import '../../dialogs/external_loan_dialog.dart';
import '../../widgets/cards/external_loan_card.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isScanning = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Bienvenido, ${user.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                AppColors.primaryLight,
                                AppColors.primary
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? const Icon(Icons.person, size: 30)
                                : null,
                          ),
                        ),
                      ],
                    ),
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
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: const [
                      Tab(icon: Icon(Icons.key), text: 'Solicitudes'),
                      Tab(
                          icon: Icon(Icons.people_alt),
                          text: 'Préstamos Externos'),
                      Tab(icon: Icon(Icons.meeting_room), text: 'Aulas'),
                      Tab(icon: Icon(Icons.people), text: 'Usuarios'),
                      Tab(icon: Icon(Icons.settings), text: 'Ajustes'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _isScanning
                    ? QrScannerView(
                        onCancel: () {
                          setState(() {
                            _isScanning = false;
                          });
                        },
                      )
                    : AdminRequestsTab(
                        onScanQr: () {
                          setState(() {
                            _isScanning = true;
                          });
                        },
                      ),
                ExternalLoansTab(),
                AdminClassroomsTab(),
                AdminUsersTab(),
                AdminSettingsTab(),
              ],
            ),
          ),
          floatingActionButton: _selectedIndex == 0 && !_isScanning
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isScanning = true;
                    });
                  },
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.qr_code_scanner),
                )
              : _selectedIndex == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ExternalLoanDialog(),
                        );
                      },
                      backgroundColor: AppColors.primary,
                      child: const Icon(Icons.add),
                    )
                  : null,
        );
      },
    );
  }
}

class ExternalLoansTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        final externalLoans = appState.externalLoans;

        if (externalLoans.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.people_alt,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No hay préstamos externos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Los préstamos a personal externo aparecerán aquí',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo Préstamo Externo'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ExternalLoanDialog(),
                    );
                  },
                ),
              ],
            ),
          );
        }

        // Agrupar préstamos por estado
        final activeBorrows =
            externalLoans.where((loan) => loan.status == 'borrowed').toList();
        final overdueLoans =
            externalLoans.where((loan) => loan.status == 'overdue').toList();
        final returnedLoans =
            externalLoans.where((loan) => loan.status == 'returned').toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Préstamos Externos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo Préstamo'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ExternalLoanDialog(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Préstamos activos
              if (activeBorrows.isNotEmpty) ...[
                const Text(
                  'Préstamos Activos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ...activeBorrows.map((loan) => ExternalLoanCard(loan: loan)),
                const SizedBox(height: 16),
              ],

              // Préstamos vencidos
              if (overdueLoans.isNotEmpty) ...[
                const Text(
                  'Préstamos Vencidos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 8),
                ...overdueLoans.map((loan) => ExternalLoanCard(loan: loan)),
                const SizedBox(height: 16),
              ],

              // Préstamos devueltos
              if (returnedLoans.isNotEmpty) ...[
                const Text(
                  'Préstamos Devueltos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                ...returnedLoans.map((loan) => ExternalLoanCard(loan: loan)),
              ],
            ],
          ),
        );
      },
    );
  }
}
