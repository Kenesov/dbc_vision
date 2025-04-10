import 'package:flutter/material.dart';
import 'package:dbc_vision/screens/client_and_employee_screens/screens/client_screen.dart';
import 'package:dbc_vision/screens/client_and_employee_screens/screens/employee_screen.dart';
import 'package:intl/intl.dart';

class ClientsAndEmployeeScreen extends StatefulWidget {
  const ClientsAndEmployeeScreen({super.key});

  @override
  State<ClientsAndEmployeeScreen> createState() => _ClientsAndEmployeeScreenState();
}

class _ClientsAndEmployeeScreenState extends State<ClientsAndEmployeeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTimeRange? _selectedDateRange;
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');
  bool _isFilterVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Default date range - last 30 days
    _selectedDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF6A3DE8),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Color(0xFF6A3DE8)),
            onPressed: () {
              setState(() {
                _isFilterVisible = !_isFilterVisible;
              });
            },
            tooltip: 'Filter by date range',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(_isFilterVisible ? 120 : 60),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
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
                  labelColor: const Color(0xFF6A3DE8),
                  unselectedLabelColor: const Color(0xFF9E9E9E),
                  indicatorColor: const Color(0xFF6A3DE8),
                  indicatorWeight: 3,
                ),
              ),
              if (_isFilterVisible)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 60,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectDateRange,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EAFA),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE0D5F9)),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Color(0xFF6A3DE8),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${_dateFormat.format(_selectedDateRange!.start)} - ${_dateFormat.format(_selectedDateRange!.end)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6A3DE8),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedDateRange = DateTimeRange(
                              start: DateTime.now().subtract(const Duration(days: 30)),
                              end: DateTime.now(),
                            );
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6A3DE8),
                          backgroundColor: const Color(0xFFF0EAFA),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClientsScreen(dateRange: _selectedDateRange),
          EmployeesScreen(dateRange: _selectedDateRange),
        ],
      ),
    );
  }
}
