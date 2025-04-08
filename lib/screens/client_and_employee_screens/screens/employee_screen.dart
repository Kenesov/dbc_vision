import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../widgets/employee_detail_dialog.dart';
import '../widgets/add_employee_dialog.dart';
import '../widgets/edit_employee_dialog.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late List<Employee> employees;
  bool _isLoading = true;
  String? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    // Имитация загрузки данных
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          employees = getMockEmployees();
          _isLoading = false;
        });
      }
    });
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddEmployeeDialog(),
    ).then((value) {
      if (value != null && value is Employee) {
        setState(() {
          employees.add(value);
        });
      }
    });
  }

  void _showEditEmployeeDialog(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => EditEmployeeDialog(employee: employee),
    ).then((value) {
      if (value != null && value is Employee) {
        setState(() {
          final index = employees.indexWhere((e) => e.id == value.id);
          if (index != -1) {
            employees[index] = value;
          }
        });
      }
    });
  }

  void _showEmployeeDetailDialog(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => EmployeeDetailDialog(employee: employee),
    );
  }

  void _deleteEmployee(String id) {
    setState(() {
      employees.removeWhere((employee) => employee.id == id);
    });
  }

  void _showOptionsMenu(BuildContext context, Employee employee) {
    setState(() {
      _selectedEmployee = employee.id;
    });

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red.shade700, size: 20),
              const SizedBox(width: 8),
              Text('Удалить', style: TextStyle(color: Colors.red.shade700)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              const Text('Изменить', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'attendance',
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              const Text('Показать посещаемость', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
      ],
    ).then((value) {
      setState(() {
        _selectedEmployee = null;
      });

      if (value == 'delete') {
        _deleteEmployee(employee.id);
      } else if (value == 'edit') {
        _showEditEmployeeDialog(employee);
      } else if (value == 'attendance') {
       // Navigator.push(
       //     context,
       //     MaterialPageRoute(builder: (context) => AttendanceScreen(employee: employee))
       // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _isLoading ? _buildLoadingState() : _buildEmployeeList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible( // Birinchi Text ni Flexible bilan o'radik
                  child: const Text(
                    'Сотрудники',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF4304cb),
                    ),
                    overflow: TextOverflow.ellipsis, // Matn uzun bo'lsa qisqartiriladi
                  ),
                ),
                Flexible( // Ikkinchi Text ni Flexible bilan o'radik
                  child: const Text(
                    ' / Посещаемость',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis, // Matn uzun bo'lsa qisqartiriladi
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: _showAddEmployeeDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4304cb),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text('Добавить сотрудника'),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmployeeList() {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Фото',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Имя',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Позиция',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              final isSelected = _selectedEmployee == employee.id;

              return Container(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.grey.shade50 : Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () => _showEmployeeDetailDialog(employee),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              employee.photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 30);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              employee.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            employee.position,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Icon(
                                Icons.more_horiz,
                                color: isSelected ? const Color(0xFF4304cb) : Colors.grey,
                              ),
                              onPressed: () => _showOptionsMenu(context, employee),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

