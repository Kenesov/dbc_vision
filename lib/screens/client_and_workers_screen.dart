import 'package:flutter/material.dart';

class ClientAndWorkersScreen extends StatelessWidget {
  const ClientAndWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klient va Ishilar'),
        backgroundColor: const Color(0xFFE65209),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Qidiruv funksiyasi qo'shilishi mumkin
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Klient va Ishilar Info',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}