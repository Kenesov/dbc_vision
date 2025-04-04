import 'package:flutter/material.dart';

class HourlyStatsTable extends StatelessWidget {
  const HourlyStatsTable({super.key});

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
              'Детальная статистика по часам',
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
                      'Час',
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
                  _buildDataRow('00:00 - 01:00', 136, 1.6),
                  _buildDataRow('08:00 - 09:00', 245, 2.8),
                  _buildDataRow('12:00 - 13:00', 450, 5.1),
                  _buildDataRow('16:00 - 17:00', 1230, 14.1),
                  _buildDataRow('20:00 - 21:00', 510, 5.8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}