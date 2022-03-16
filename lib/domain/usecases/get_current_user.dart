import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class GetCurrentUser extends UseCase<User, void> {
  final UserRepository _userRepository;

  GetCurrentUser(this._userRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(void params) async {
    StreamController<User> controller = StreamController();
    try {
      User currentUser = _userRepository.currentUser;
      controller.add(currentUser);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}
