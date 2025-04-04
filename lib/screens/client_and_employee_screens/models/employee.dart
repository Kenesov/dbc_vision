class Employee {
  final String id;
  final String name;
  final String position;
  final String phoneNumber;
  final String photoUrl;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.phoneNumber,
    required this.photoUrl,
  });
}

// Mock data
List<Employee> getMockEmployees() {
  return [
    Employee(
      id: '4',
      name: 'Jumishi 1',
      position: 'Менеджер',
      phoneNumber: '000000000',
      photoUrl: 'https://picsum.photos/id/1001/200',
    ),
    Employee(
      id: '5',
      name: 'Jum2',
      position: 'Администратор',
      phoneNumber: '910000000',
      photoUrl: 'https://picsum.photos/id/1002/200',
    ),
    Employee(
      id: '6',
      name: 'Jum 3',
      position: 'Консультант',
      phoneNumber: '921000000',
      photoUrl: 'https://picsum.photos/id/1003/200',
    ),
    Employee(
      id: '8',
      name: 'Jum 4',
      position: 'Менеджер',
      phoneNumber: '991111111',
      photoUrl: 'https://picsum.photos/id/1004/200',
    ),
    Employee(
      id: '9',
      name: 'Jum 5',
      position: 'Консультант',
      phoneNumber: '991111112',
      photoUrl: 'https://picsum.photos/id/1005/200',
    ),
    Employee(
      id: '10',
      name: 'Jum 6',
      position: 'Администратор',
      phoneNumber: '991111113',
      photoUrl: 'https://picsum.photos/id/1006/200',
    ),
    Employee(
      id: '11',
      name: 'Jum 7',
      position: 'Консультант',
      phoneNumber: '991111114',
      photoUrl: 'https://picsum.photos/id/1007/200',
    ),
    Employee(
      id: '12',
      name: 'Jum 8',
      position: 'Менеджер',
      phoneNumber: '991111115',
      photoUrl: 'https://picsum.photos/id/1008/200',
    ),
  ];
}

