class Client {
  final String id;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final int visitCount;
  final String photoUrl;

  Client({
    required this.id,
    required this.firstSeen,
    required this.lastSeen,
    required this.visitCount,
    required this.photoUrl,
  });
}

// Mock data
List<Client> getMockClients() {
  return List.generate(
    20,
        (index) => Client(
      id: '${9500 + index}',
      firstSeen: DateTime.now().subtract(Duration(days: index * 2)),
      lastSeen: DateTime.now().subtract(Duration(hours: index)),
      visitCount: 1 + (index % 5),
      photoUrl: 'https://picsum.photos/id/${200 + index}/200',
    ),
  );
}

