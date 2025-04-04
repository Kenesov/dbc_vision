import 'package:flutter/material.dart';

class DateStatsTable extends StatelessWidget {
  const DateStatsTable({super.key});

  DataRow _buildDataRowWithChange(String date, int value, double change) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            date,
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
          Row(
            children: [
              Icon(
                change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                color: change >= 0 ? Colors.green : Colors.red,
                size: 12, // Reduced icon size
              ),
              const SizedBox(width: 4),
              Text(
                '${change.abs().toStringAsFixed(1)}%',
                style: TextStyle(
                  color: change >= 0 ? Colors.green : Colors.red,
                  fontSize: 12, // Reduced font size
                ),
              ),
            ],
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
              'Детальная статистика по датам',
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
                      'Дата',
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
                      'Изменение',
                      style: TextStyle(fontSize: 12), // Reduced font size
                    ),
                  ),
                ],
                rows: [
                  _buildDataRowWithChange('01.03.2025', 295, 5.2),
                  _buildDataRowWithChange('02.03.2025', 180, -39.0),
                  _buildDataRowWithChange('03.03.2025', 310, 72.2),
                  _buildDataRowWithChange('04.03.2025', 275, -11.3),
                  _buildDataRowWithChange('05.03.2025', 290, 5.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}