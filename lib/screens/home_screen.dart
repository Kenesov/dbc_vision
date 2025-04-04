import 'package:dbc_vision/screens/client_and_employee_screens/clients_and_employee_screen.dart';
import 'package:dbc_vision/screens/statistics_screen.dart';
import 'package:dbc_vision/screens/widgets/cards_widgets/stat_card.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/age_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/client_donut_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/gender_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/drawer_widgets/app_drawer.dart';
import 'package:dbc_vision/screens/widgets/navigation_widgets/app_botton_navigation.dart';
import 'package:dbc_vision/screens/widgets/expandable_chart_card.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/date_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/hourly_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/weekly_visits_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0; // Dastlab "Statestika" ekrani ko'rinadi
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState(); // super.initState() ni birinchi chaqirish
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
    _scrollController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0: // Statestika
        return Scaffold(
          appBar: AppBar(
            title: const Text('Statestika'),
            backgroundColor: const Color(0xFFF6F6F6),
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'По часам'),
                Tab(text: 'По дням'),
                Tab(text: 'По датам'),
              ],
            ),
          ),
          drawer: const AppDrawer(),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Входящие клиенты',
                            value: '3803',
                            icon: Icons.person_add,
                            iconColor: Colors.blue,
                            iconBackgroundColor: Colors.blue.withAlpha(25),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: StatCard(
                            title: 'Новые клиенты',
                            value: '3171',
                            icon: Icons.person_outline,
                            iconColor: Colors.green,
                            iconBackgroundColor: Colors.green.withAlpha(25),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Постоянные клиенты',
                            value: '632',
                            icon: Icons.people,
                            iconColor: Colors.indigoAccent,
                            iconBackgroundColor: Colors.orange.withAlpha(25),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: StatCard(
                            title: 'Среднее в день',
                            value: '123',
                            icon: Icons.calendar_today,
                            iconColor: Colors.purple,
                            iconBackgroundColor: Colors.purple.withAlpha(25),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Входящие клиенты',
                      chart: const GenderPieChart(),
                      height: 150,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Возраст клиентов',
                      chart: const AgePieChart(),
                      height: 150,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Входящие клиенты',
                      chart: const ClientDonutChart(),
                      height: 150,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Время посещения клиентов',
                      chart: const HourlyVisitsChart(),
                      height: 300,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Посещения по дням недели',
                      chart: const WeeklyVisitsChart(),
                      height: 300,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Посещения по датам',
                      chart: const DateVisitsChart(),
                      height: 300,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1: // Klient va Ishilar Info
        return const ClientsAndEmployeeScreen();
      case 2: // Konversiya (StatisticsScreen)
        return const StatisticsScreen();
      case 3: // Moy Nostroyka
        return Scaffold(
          appBar: AppBar(
            title: const Text('Moy Nostroyka'),
            backgroundColor: const Color(0xFFE65209),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
          body: const Center(
            child: Text(
              'Moy Nostroyka',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}