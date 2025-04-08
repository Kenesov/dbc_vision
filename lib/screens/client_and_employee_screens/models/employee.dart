class Employee {
  final String id;
  final String name;
  final String position;
  final String phoneNumber;
  final String photoUrl;
  final String email;
  final String schedule;
  final String branch;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.phoneNumber,
    required this.photoUrl,
    this.email = '',
    this.schedule = '09:00-18:00',
    this.branch = 'Главный офис',
  });
}
List<Employee> getMockEmployees() {
  return [
    Employee(
      id: '1',
      name: 'Отемуратов',
      position: 'Test',
      phoneNumber: '998970355284',
      photoUrl: 'https://picsum.photos/id/1001/200', // To'g'ri ID
      email: 'xQSylZo@example.com',
      schedule: '00:03-23:00',
      branch: 'Куйградский район',
    ),
    Employee(
      id: '2',
      name: 'Орынбаева',
      position: 'Test',
      phoneNumber: '998986691861',
      photoUrl: 'https://picsum.photos/id/1002/200', // To'g'ri ID
      email: 'orynbaeva@example.com',
      schedule: '09:00-18:00',
      branch: 'Главный офис',
    ),
    Employee(
      id: '3',
      name: 'Арзуов',
      position: 'Test',
      phoneNumber: '998963292911',
      photoUrl: 'https://picsum.photos/id/1003/200', // To'g'ri ID
      email: 'arzuov@example.com',
      schedule: '09:00-18:00',
      branch: 'Филиал 1',
    ),
    Employee(
      id: '4',
      name: 'Садикова',
      position: 'Test',
      phoneNumber: '998931599000',
      photoUrl: 'https://picsum.photos/id/1004/200', // To'g'ri ID
      email: 'sadikova@example.com',
      schedule: '09:00-18:00',
      branch: 'Филиал 2',
    ),
    Employee(
      id: '5',
      name: 'Утеулиев',
      position: 'Test',
      phoneNumber: '998934896250',
      photoUrl: 'https://picsum.photos/id/1005/200', // To'g'ri ID
      email: 'uteuliev@example.com',
      schedule: '09:00-18:00',
      branch: 'Главный офис',
    ),
    Employee(
      id: '6',
      name: 'Аллаабергенов',
      position: 'Test',
      phoneNumber: '998929669725',
      photoUrl: 'https://picsum.photos/id/1006/200', // To'g'ri ID
      email: 'allaabergenov@example.com',
      schedule: '09:00-18:00',
      branch: 'Филиал 1',
    ),
    Employee(
      id: '7',
      name: 'Сеитов',
      position: 'Test',
      phoneNumber: '998990029785',
      photoUrl: 'https://picsum.photos/id/1008/200', // To'g'ri ID
      email: 'seitov@example.com',
      schedule: '09:00-18:00',
      branch: 'Главный офис',
    ),
  ];
}