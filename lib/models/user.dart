class User {
  final int? id;
  final String name;
  final String username;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final String? location; // ciudad, país u otra info breve

  User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    this.avatarUrl,
    this.phone,
    this.location,
  });

  // Factory para respuestas del API original (jsonplaceholder)
  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? '';
    return User(
      id: json['id'],
      name: name,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: null,
      phone: json['phone'],
      location: json['address'] != null
          ? '${json['address']['city'] ?? ''}, ${json['address']['zipcode'] ?? ''}'
          : null,
    );
  }

  // Factory para la respuesta de randomuser.me
  factory User.fromRandomUserJson(Map<String, dynamic> json) {
    final nameObj = json['name'] as Map<String, dynamic>?;
    final locationObj = json['location'] as Map<String, dynamic>?;
    final pictureObj = json['picture'] as Map<String, dynamic>?;

    final fullName = nameObj != null
        ? '${nameObj['first'] ?? ''} ${nameObj['last'] ?? ''}'.trim()
        : (json['login'] != null ? json['login']['username'] : '');

    final username = (json['login'] != null && json['login']['username'] != null)
        ? json['login']['username']
        : (nameObj != null ? '${nameObj['first']}' : 'unknown');

    final locationStr = locationObj != null
        ? '${locationObj['city'] ?? ''}, ${locationObj['country'] ?? ''}'.trim()
        : null;

    return User(
      id: null,
      name: fullName,
      username: username,
      email: json['email'] ?? '',
      // Priorizar imagen grande si está disponible
      avatarUrl: pictureObj != null ? pictureObj['large'] ?? pictureObj['medium'] ?? pictureObj['thumbnail'] : null,
      phone: json['phone'] ?? json['cell'],
      location: locationStr,
    );
  }
}

// ...existing code...
