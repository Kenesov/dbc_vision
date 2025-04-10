import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySettingsScreen extends StatefulWidget {
  const MySettingsScreen({super.key});

  @override
  State<MySettingsScreen> createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  bool _isDarkMode = true; // Default to dark mode
  String _selectedLanguage = 'Uzbek';
  final List<String> _languages = ['Uzbek', 'Russian', 'Karakalpak', 'English'];
  final Map<String, String> _languageLabels = {
    'Uzbek': 'O\'zbek tili',
    'Russian': 'Rus tili',
    'Karakalpak': 'Qoraqalpoq tili',
    'English': 'English tili',
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? true;
      _selectedLanguage = prefs.getString('language') ?? 'Uzbek';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setString('language', _selectedLanguage);
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    _saveSettings();
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _saveSettings();
    Navigator.pop(context);
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Tilni tanlang',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _languages.length,
              itemBuilder: (BuildContext context, int index) {
                final language = _languages[index];
                final isSelected = language == _selectedLanguage;

                return ListTile(
                  title: Text(
                    _languageLabels[language] ?? language,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  leading: isSelected
                      ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4355B9),
                  )
                      : const Icon(
                    Icons.circle_outlined,
                    color: Colors.white54,
                  ),
                  onTap: () => _changeLanguage(language),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Bekor qilish',
                style: TextStyle(
                  color: Color(0xFF4355B9),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Akkauntdan chiqish',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Haqiqatan ham akkauntdan chiqmoqchimisiz?',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Yo\'q',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Implement logout functionality
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Akkauntdan chiqildi'),
                    backgroundColor: Color(0xFF4355B9),
                  ),
                );
              },
              child: const Text(
                'Ha',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4355B9),
        elevation: 0,
        title: const Text(
          'Mening Sozlamalarim',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile section
            Container(
              width: double.infinity,
              color: const Color(0xFF4355B9),
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Abdulaziz Karimov',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'abdulaziz.karimov@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Settings section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.language,
                        color: Color(0xFF4355B9),
                      ),
                      title: const Text(
                        'Til',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        _languageLabels[_selectedLanguage] ?? _selectedLanguage,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white54,
                      ),
                      onTap: _showLanguageDialog,
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    SwitchListTile(
                      secondary: Icon(
                        _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: const Color(0xFF4355B9),
                      ),
                      title: const Text(
                        'Qorong\'i rejim',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      value: _isDarkMode,
                      activeColor: const Color(0xFF4355B9),
                      onChanged: _toggleDarkMode,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Akkauntdan chiqish',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white54,
                  ),
                  onTap: _showLogoutDialog,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // App version
            const Text(
              'Versiya 1.0.0',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
