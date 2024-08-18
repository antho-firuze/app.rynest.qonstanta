class User {
  final String? id;
  final String? email;
  final String? fullName;
  final String? phone;
  final String? photoUrl;
  final List<dynamic>? role;
  User(
      {this.id,
      this.email,
      this.fullName,
      this.phone,
      this.photoUrl,
      this.role});

  // User.initial()
  //     : username = '',
  //       email = '',
  //       fullName = '',
  //       photoUrl = '',
  //       role = [];

  User.fromJson(Map<String, dynamic> json, {String? id})
      : this(
          id: id ?? json['id'],
          email: json['email'] ?? '',
          fullName: json['fullname'] ?? '',
          phone: json['phone'] ?? '',
          photoUrl: json['photoUrl'] ?? '',
          role: json['role'] ?? [],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'fullname': fullName,
        'phone': phone,
        'photoUrl': photoUrl,
        'role': role,
      };
}
