import 'package:shopping_list/domain/entities/user.dart';

abstract class AdminRepository {
  Stream<List<User>> waitingCustomers();
}
