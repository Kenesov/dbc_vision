class UserSettings {
  final String language;
  final bool darkMode;

  UserSettings({
    required this.language,
    required this.darkMode,
  });

  UserSettings copyWith({
    String? language,
    bool? darkMode,
  }) {
    return UserSettings(
      language: language ?? this.language,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  factory UserSettings.initial() {
    return UserSettings(
      language: 'Uzbek',
      darkMode: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'darkMode': darkMode,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      language: json['language'] as String,
      darkMode: json['darkMode'] as bool,
    );
  }
}
