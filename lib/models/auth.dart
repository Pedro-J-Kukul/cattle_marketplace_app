// File: lib/models/auth/auth_token.dart 
class AuthToken {
  final String plaintext;
  AuthToken({required this.plaintext});

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      plaintext: json['plaintext'],
    );
  }
}