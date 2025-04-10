class UserProfile {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserProfile.mock() {
    return UserProfile(
      id: '1',
      name: 'Abdulaziz Karimov',
      email: 'abdulaziz.karimov@gmail.com',
      photoUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }
}
