import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;
  final bool isDarkMode;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> languageLabels = {
      'Uzbek': 'O\'zbek tili',
      'Russian': 'Rus tili',
      'Karakalpak': 'Qoraqalpoq tili',
      'English': 'English tili',
    };

    final List<String> languages = ['Uzbek', 'Russian', 'Karakalpak', 'English'];

    return AlertDialog(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
      title: Text(
        'Tilni tanlang',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (BuildContext context, int index) {
            final language = languages[index];
            final isSelected = language == selectedLanguage;

            return ListTile(
              title: Text(
                languageLabels[language] ?? language,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              leading: isSelected
                  ? Icon(
                Icons.check_circle,
                color: const Color(0xFF4355B9),
              )
                  : Icon(
                Icons.circle_outlined,
                color: isDarkMode ? Colors.white54 : Colors.black54,
              ),
              onTap: () => onLanguageChanged(language),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Bekor qilish',
            style: TextStyle(
              color: const Color(0xFF4355B9),
            ),
          ),
        ),
      ],
    );
  }
}
