import 'package:shopping_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> initializeRepository();
  User get currentUser;
}
