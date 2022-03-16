import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/entities/user.dart' as ent;

class InitializeApp extends UseCase<void, void> {
  UserRepository _userRepository;

  InitializeApp(this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.initializeRepository();
      final ent.User user = _userRepository.currentUser;
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}
