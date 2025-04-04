import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePicker extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final Function(DateTimeRange) onRangeSelected;

  const DateRangePicker({
    super.key,
    this.initialDateRange,
    required this.onRangeSelected,
  });

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    if (args.value is DateTimeRange) {
                      _selectedDateRange = args.value;
                    }
                  });
                },
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                  _selectedDateRange?.start ?? DateTime.now().subtract(const Duration(days: 7)),
                  _selectedDateRange?.end ?? DateTime.now(),
                ),
                startRangeSelectionColor: const Color(0xFFE65209),
                endRangeSelectionColor: const Color(0xFFE65209),
                rangeSelectionColor: const Color(0xFFE65209).withOpacity(0.3),
                selectionTextStyle: const TextStyle(color: Colors.white),
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(fontSize: 12),
                ),
                headerStyle: const DateRangePickerHeaderStyle(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedDateRange != null) {
                    widget.onRangeSelected(_selectedDateRange!);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Save', style: TextStyle(color: Color(0xFFE65209))),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDateRange(DateTimeRange? dateRange) {
    if (dateRange == null) {
      return 'Select Date Range';
    }
    final start = "${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year}";
    final end = "${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}";
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDateRange(_selectedDateRange),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xFFE65209), size: 20),
          onPressed: () => _selectDateRange(context),
        ),
      ],
    );
  }
}