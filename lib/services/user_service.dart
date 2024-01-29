import 'package:realm/realm.dart';

class UserService {
  final App atlasApp;

  UserService(this.atlasApp);

  searchUser({required String email}) {}

  Future<User> createUser(String email, String password) async {
    EmailPasswordAuthProvider authProvider =
        EmailPasswordAuthProvider(atlasApp);
    await authProvider.registerUser(email, password);
    return loginUser(email, password);
  }

  Future<User> loginUser(String email, String password) async {
    Credentials credentials = Credentials.emailPassword(email, password);
    return atlasApp.logIn(credentials);
  }

  Future<void> logoutUser() async {
    return atlasApp.currentUser!.logOut();
  }
}
