import 'package:dbc_vision/screens/widgets/widgets_grafik/chart_card.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/date_stats_table.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/date_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/hourly_stats_table.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/hourly_visits_chart.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/summary_card.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/weekly_stats_table.dart';
import 'package:dbc_vision/screens/widgets/widgets_grafik/weekly_visits_chart.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistikalar', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF4304cb),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today,),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/photo_2025-03-31_17-27-52.jpg-iYjFvpE0vxP7lsGqamKFxcrELhLQjU.jpeg',
            ),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildHourlyVisitsTab(),
            _buildWeeklyVisitsTab(),
            _buildDateVisitsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyVisitsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          ChartCard(
            title: 'Время посещения клиентов',
            chart: const HourlyVisitsChart(),
            height: 300,
          ),
          const SizedBox(height: 24),
          const HourlyStatsTable(),
        ],
      ),
    );
  }

  Widget _buildWeeklyVisitsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          ChartCard(
            title: 'Посещения по дням недели',
            chart: const WeeklyVisitsChart(),
            height: 300,
          ),
          const SizedBox(height: 24),
          const WeeklyStatsTable(),
        ],
      ),
    );
  }

  Widget _buildDateVisitsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          const SizedBox(height: 24),
          ChartCard(
            title: 'Посещения по датам',
            chart: const DateVisitsChart(),
            height: 300,
          ),
          const SizedBox(height: 24),
          const DateStatsTable(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: 'Всего посещений',
                value: '8,742',
                icon: Icons.people,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SummaryCard(
                title: 'Среднее в день',
                value: '291',
                icon: Icons.calendar_today,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: 'Пиковое время',
                value: '16:00',
                icon: Icons.access_time,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SummaryCard(
                title: 'Пиковый день',
                value: 'Пн',
                icon: Icons.date_range,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}