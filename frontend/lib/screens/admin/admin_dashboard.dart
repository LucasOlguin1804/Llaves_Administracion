import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../providers/app_state.dart';
import '../login/login_screen.dart';
import 'admin_classrooms_tab.dart';
import 'admin_requests_tab.dart';
import 'admin_users_tab.dart';
import 'admin_settings_tab.dart';
import '../../dialogs/external_loan_dialog.dart';
import '../../widgets/cards/external_loan_card.dart';
import '../../models/external_loan_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
                  pinned: true,
                  expandedHeight: 180,
                  backgroundColor: AppColors.primary,
                  flexibleSpace: Container(
                    padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Bienvenido, ${user.name}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Container(
                      color: AppColors.primary,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.white,
                        tabs: const [
                          Tab(icon: Icon(Icons.key), text: 'Solicitudes'),
                          Tab(icon: Icon(Icons.people_alt), text: 'Préstamos'),
                          Tab(icon: Icon(Icons.meeting_room), text: 'Aulas'),
                          Tab(icon: Icon(Icons.people), text: 'Usuarios'),
                          Tab(icon: Icon(Icons.settings), text: 'Ajustes'),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        appState.logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: const [
                AdminRequestsTab(),
                ExternalLoansTab(),
                AdminClassroomsTab(),
                AdminUsersTab(),
                AdminSettingsTab(),
              ],
            ),
          ),
          floatingActionButton: _selectedIndex == 1
              ? FloatingActionButton(
                  onPressed: () => _ExternalLoansTabState.openLoanDialog(context),
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}

class ExternalLoansTab extends StatefulWidget {
  const ExternalLoansTab({Key? key}) : super(key: key);

  @override
  State<ExternalLoansTab> createState() => _ExternalLoansTabState();
}

class _ExternalLoansTabState extends State<ExternalLoansTab> {
  static late BuildContext _staticContext;
  static late void Function(void Function()) _setState;
  static List<ExternalLoanModel> _visibleLoans = [];

  @override
  void initState() {
    super.initState();
    _staticContext = context;
    _setState = setState;
    final appState = Provider.of<AppState>(context, listen: false);
    appState.fetchExternalLoans().then((_) {
      setState(() {
        _visibleLoans = List.from(appState.externalLoans);
      });
    });
  }

  static Future<void> openLoanDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const ExternalLoanDialog(),
    );

    final appState = Provider.of<AppState>(_staticContext, listen: false);
    await appState.fetchExternalLoans();

    _setState(() {
      _visibleLoans = List.from(appState.externalLoans);
    });
  }

  void _removeLoanFromUI(int loanId) {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _visibleLoans.removeWhere((loan) => loan.id == loanId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final classrooms = Provider.of<AppState>(context).classrooms;

    if (_visibleLoans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_alt, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No hay préstamos externos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Los préstamos a personal externo aparecerán aquí',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Nuevo Préstamo Externo'),
              onPressed: () => openLoanDialog(context),
            ),
          ],
        ),
      );
    }

    final activeBorrows = _visibleLoans.where((loan) => loan.estado == 'prestada').toList();
    final overdueLoans = _visibleLoans.where((loan) => loan.estado == 'vencida').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Préstamos Externos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (activeBorrows.isNotEmpty) ...[
            const Text('Activos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 8),
            ...activeBorrows.map((loan) => ExternalLoanCard(
                  loan: loan,
                  classrooms: classrooms,
                  onMarkedReturned: () => _removeLoanFromUI(loan.id),
                )),
            const SizedBox(height: 16),
          ],
          if (overdueLoans.isNotEmpty) ...[
            const Text('Vencidos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.error)),
            const SizedBox(height: 8),
            ...overdueLoans.map((loan) => ExternalLoanCard(
                  loan: loan,
                  classrooms: classrooms,
                )),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
