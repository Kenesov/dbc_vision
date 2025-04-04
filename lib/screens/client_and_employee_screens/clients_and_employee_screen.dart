import 'package:dbc_vision/screens/client_and_employee_screens/screens/client_screen.dart';
import 'package:dbc_vision/screens/client_and_employee_screens/screens/employee_screen.dart';
import 'package:flutter/material.dart';

class ClientsAndEmployeeScreen extends StatefulWidget {
  const ClientsAndEmployeeScreen({super.key});

  @override
  State<ClientsAndEmployeeScreen> createState() => _ClientsAndEmployeeScreenState();
}

class _ClientsAndEmployeeScreenState extends State<ClientsAndEmployeeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Clients',
              icon: Icon(Icons.people),
            ),
            Tab(
              text: 'Employees',
              icon: Icon(Icons.badge),
            ),
          ],
          indicatorWeight: 3,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ClientsScreen(),
          EmployeesScreen(),
        ],
      ),
    );
  }
}