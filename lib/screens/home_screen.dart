
import 'package:dbc_vision/screens/employee/employee_screen.dart';
import 'package:dbc_vision/screens/my_settings/my_settings_screen.dart';
import 'package:dbc_vision/screens/widgets/app_bar.dart';
import 'package:dbc_vision/screens/widgets/cards_widgets/summary2_card.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/age_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/client_donut_chart.dart';
import 'package:dbc_vision/screens/widgets/chart_widgets/gender_pie_chart.dart';
import 'package:dbc_vision/screens/widgets/cards_widgets/expandable_chart_card.dart';
import 'package:dbc_vision/screens/widgets/navigation_widgets/app_botton_navigation.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/date_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/hourly_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/cards_widgets/summary_card.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/weekly_visits_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'client/clients_and_employee_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Dastlab "Statestika" ekrani ko'rinadi
  final ScrollController _scrollController = ScrollController();
  DateTimeRange? selectedDateRange;
  bool _isLoading = true; // Loading holatini qo'shdik

  @override
  void initState() {
    super.initState();
    // So'nggi 30 kunlik standart sana oralig'ini o'rnatamiz
    selectedDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );

    // 2 soniyadan so'ng loading holatini o'chiramiz
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showDateRangePicker() {
    showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4304cb), // Kalendarning asosiy rangi
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    ).then((picked) {
      if (picked != null) {
        setState(() {
          selectedDateRange = picked;
          _isLoading = true; // Yangi sana tanlanganda loading holatini yoqamiz
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          });
        });
      }
    });
  }

  Widget _buildDateRangeSelector() {
    final formatter = DateFormat('dd.MM.yyyy');
    String dateText = selectedDateRange != null
        ? '${formatter.format(selectedDateRange!.start)} - ${formatter.format(selectedDateRange!.end)}'
        : 'Sana oralig\'ini tanlang';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GestureDetector(
        onTap: _showDateRangePicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedDateRange != null ? Colors.black87 : Colors.grey,
                  letterSpacing: 0.3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4304cb).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF4304cb),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0: // Statestika
        return Scaffold(
          appBar: const ModernAppBar( // ModernAppBar bilan almashtirdik
            title: 'DBCVISION',
            centerTitle: true,
          ),
          body: Column(
            children: [
              _buildDateRangeSelector(), // Yangilangan date range selector
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Summary2Card(
                            title: 'Number',
                            value: '450',
                            icon: Icons.person_add,
                            color: Colors.blue, // Moviy rang
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SummaryCard(
                            title: 'On Leave',
                            value: '20',
                            icon: Icons.calendar_today,
                            color: Colors.orange, // To‘q sariq rang
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Summary2Card(
                            title: 'New Joinee',
                            value: '200',
                            icon: Icons.person,
                            color: Colors.green, // Yashil rang
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SummaryCard(
                            title: 'Upcoming Holiday',
                            value: '4',
                            icon: Icons.event,
                            color: Colors.cyan, // Ochiq ko‘k rang
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Kiruvchi mijozlar',
                      chart: GenderPieChart(isLoading: _isLoading),
                      height: 200,
                      isLoading: _isLoading,
                      accentColor: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Mijozlar yoshi',
                      chart: AgePieChart(isLoading: _isLoading),
                      height: 230,
                      isLoading: _isLoading,
                      accentColor: Colors.green,

                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Kiruvchi mijozlar',
                      chart: ClientDonutChart(isLoading: _isLoading),
                      height: 200,
                      isLoading: _isLoading,
                      accentColor: Colors.teal,

                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Mijozlar tashrif vaqti',
                      chart: HourlyVisitsChart(isLoading: _isLoading),
                      height: 300,
                      isLoading: _isLoading,
                      accentColor: Colors.blue,

                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Hafta kunlari bo‘yicha tashriflar',
                      chart: WeeklyVisitsChart(isLoading: _isLoading),
                      height: 300,
                      isLoading: _isLoading,
                      accentColor: Colors.green,

                    ),
                    const SizedBox(height: 8),
                    ExpandableChartCard(
                      title: 'Sanalar bo‘yicha tashriflar',
                      chart: DateVisitsChart(isLoading: _isLoading),
                      height: 300,
                      isLoading: _isLoading,
                      accentColor: Colors.red,

                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1: // Mijozlar va Xodimlar Ma'lumotlari
        return const ClientsAndEmployeeScreen();
      case 2: // Konversiya (StatisticsScreen)
        return const EmployeesScreen();
      case 3: // Mening Sozlamalarim
        return const MySettingsScreen();
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