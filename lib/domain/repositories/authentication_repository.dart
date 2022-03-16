abstract class AuthenticationRepository {
  Future<void> registerWithEmail(
      String firstName, String lastName, String email, String password);
  Future<void> signInWithEmail(String email, String password);
  Future<void> signOut();
}
