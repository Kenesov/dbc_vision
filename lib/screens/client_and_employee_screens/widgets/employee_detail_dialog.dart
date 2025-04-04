import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeDetailDialog extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailDialog({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: NetworkImage(employee.photoUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    employee.position,
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.badge, 'ID сотрудника:', employee.id),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.phone, 'Номер телефона:', employee.phoneNumber),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Call functionality would go here
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text('Позвонить'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Закрыть'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

