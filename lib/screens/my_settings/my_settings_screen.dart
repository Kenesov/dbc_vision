import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySettingsScreen extends StatefulWidget {
  const MySettingsScreen({super.key});

  @override
  State<MySettingsScreen> createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'Uzbek';
  String _selectedBranch = 'Tashkent';

  final List<String> _languages = ['Uzbek', 'Russian', 'Karakalpak', 'English'];
  final Map<String, String> _languageLabels = {
    'Uzbek': 'O\'zbek tili',
    'Russian': 'Rus tili',
    'Karakalpak': 'Qoraqalpoq tili',
    'English': 'English tili',
  };

  final List<String> _branches = ['Tashkent', 'Nukus', 'Samarqand'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'Uzbek';
      _selectedBranch = prefs.getString('branch') ?? 'Tashkent';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setString('language', _selectedLanguage);
    await prefs.setString('branch', _selectedBranch);
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

  void _changeBranch(String branch) {
    setState(() {
      _selectedBranch = branch;
    });
    _saveSettings();
    Navigator.pop(context);
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Tilni tanlang',
            style: TextStyle(
              color: Colors.black87,
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
                      color: Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  leading: isSelected
                      ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF7E57C2),
                  )
                      : const Icon(
                    Icons.circle_outlined,
                    color: Colors.black54,
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
                  color: Color(0xFF7E57C2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showBranchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Filial tanlang',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _branches.length,
              itemBuilder: (BuildContext context, int index) {
                final branch = _branches[index];
                final isSelected = branch == _selectedBranch;

                return ListTile(
                  title: Text(
                    branch,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  leading: isSelected
                      ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF7E57C2),
                  )
                      : const Icon(
                    Icons.circle_outlined,
                    color: Colors.black54,
                  ),
                  onTap: () => _changeBranch(branch),
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
                  color: Color(0xFF7E57C2),
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Akkauntdan chiqish',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Haqiqatan ham akkauntdan chiqmoqchimisiz?',
            style: TextStyle(
              color: Colors.black54,
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
                    backgroundColor: Color(0xFF7E57C2),
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
    // App colors based on the screenshots
    const Color primaryColor = Color(0xFF7E57C2); // Purple
    const Color backgroundColor = Color(0xFFF8F9FA); // Light gray background
    const Color cardColor = Colors.white;
    const Color textColor = Color(0xFF333333);
    const Color secondaryTextColor = Color(0xFF757575);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mening Sozlamalarim',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/logo/img.png',
            color: primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // Centered profile section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryColor.withOpacity(0.2),
                        width: 3,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,

                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Abdulaziz Karimov',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 14,
                        color: secondaryTextColor,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'abdulaziz.karimov@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Administrator',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Settings section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Branch selection
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_city,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Filial',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      _selectedBranch,
                      style: const TextStyle(
                        color: secondaryTextColor,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: _showBranchDialog,
                  ),

                  const Divider(height: 1),

                  // Language option
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Til',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      _languageLabels[_selectedLanguage] ?? _selectedLanguage,
                      style: const TextStyle(
                        color: secondaryTextColor,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: _showLanguageDialog,
                  ),

                  const Divider(height: 1),

                  // Dark mode toggle
                  SwitchListTile(
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Qorong\'i rejim',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    value: _isDarkMode,
                    activeColor: primaryColor,
                    onChanged: _toggleDarkMode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Logout button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'Akkauntdan chiqish',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                onTap: _showLogoutDialog,
              ),
            ),

            const SizedBox(height: 24),

            // Version info
            const Text(
              'Versiya 1.0.0',
              style: TextStyle(
                color: secondaryTextColor,
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
