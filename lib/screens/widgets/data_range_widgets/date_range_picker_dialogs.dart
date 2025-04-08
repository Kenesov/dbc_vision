import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerDialogs extends StatelessWidget {
  final DateTimeRange? initialDateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTimeRange) onDateRangeSelected;

  const DateRangePickerDialogs({
    super.key, // Updated to use super.key syntax
    this.initialDateRange,
    required this.firstDate,
    required this.lastDate,
    required this.onDateRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Выберите диапазон дат',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4304cb),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4304cb),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  initialDateRange: initialDateRange,
                  firstDate: firstDate,
                  lastDate: lastDate,
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color(0xFF4304cb),
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
                if (picked != null) {
                  onDateRangeSelected(picked);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Выбрать даты',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Отмена',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}