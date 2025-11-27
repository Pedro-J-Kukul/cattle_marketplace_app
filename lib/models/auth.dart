// File: lib/models/auth.dart 
class AuthToken {
  final String token;
  final String? expiry;

  AuthToken({required this.token, this.expiry});

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['token'],
      expiry: json['expiry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiry': expiry,
    };
  }
}