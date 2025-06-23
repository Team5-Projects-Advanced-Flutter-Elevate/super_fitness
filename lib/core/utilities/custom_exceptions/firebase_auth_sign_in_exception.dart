class FirebaseAuthSignInException implements Exception {
  @override
  String toString() {
    return "User Account already exists";
  }
}
