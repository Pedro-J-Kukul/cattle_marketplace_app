// File lib/models/user.dart

// User model class
// Represents a user in the application
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final bool isActivated;
  final bool isVerified;
  final String role;

  // Constructor for the User class
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isActivated,
    required this.isVerified,
    required this.role,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isActivated: json['is_activated'] ?? false,
      isVerified: json['is_verified'] ?? false,
      role: json['role'] ?? 'staff',
    );
  }

  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'is_activated': isActivated,
      'is_verified': isVerified,
      'role': role,
    };
  }
}
