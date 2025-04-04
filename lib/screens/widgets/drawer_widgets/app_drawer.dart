import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4304cb),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage('assets/logo/img_1.png'),
                  width: 60,
                  height: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                const Text(
                  'DBC VISION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF4304cb)),
            title: const Text('Главная'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF4304cb)),
            title: const Text('Профиль'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF4304cb)),
            title: const Text('Настройки'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Color(0xFF4304cb)),
            title: const Text('Выйти'),
            onTap: () {
              // Navigate to login screen (uncomment and import LoginScreen if needed)
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (_) => const LoginScreen()),
              // );
            },
          ),
        ],
      ),
    );
  }
}