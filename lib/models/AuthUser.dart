class AuthUser {
  final String uid;
  final bool isEmailVerified;
  final String? email;

  AuthUser({required this.uid, required this.isEmailVerified, required this.email});
}