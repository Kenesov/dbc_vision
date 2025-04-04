import 'package:flutter/material.dart';

class WeeklyStatsTable extends StatelessWidget {
  const WeeklyStatsTable({super.key});

  DataRow _buildDataRow(String label, int value, double percentage) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            label,
            style: const TextStyle(fontSize: 12), // Reduced font size
          ),
        ),
        DataCell(
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 12), // Reduced font size
          ),
        ),
        DataCell(
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 12), // Reduced font size
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Reduced border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(8), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Детальная статистика по дням недели',
              style: TextStyle(
                fontSize: 14, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16, // Reduced column spacing
                columns: const [
                  DataColumn(
                    label: Text(
                      'День',
                      style: TextStyle(fontSize: 12), // Reduced font size
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Посещения',
                      style: TextStyle(fontSize: 12), // Reduced font size
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '% от общего',
                      style: TextStyle(fontSize: 12), // Reduced font size
                    ),
                  ),
                ],
                rows: [
                  _buildDataRow('Понедельник', 1850, 21.2),
                  _buildDataRow('Вторник', 1420, 16.2),
                  _buildDataRow('Среда', 1020, 11.7),
                  _buildDataRow('Четверг', 1340, 15.3),
                  _buildDataRow('Пятница', 1410, 16.1),
                  _buildDataRow('Суббота', 1020, 11.7),
                  _buildDataRow('Воскресенье', 620, 7.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}