import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';

class SignInWithEmail extends UseCase<void, SignInWithEmailParams> {
  final AuthenticationRepository _authenticationRepository;

  SignInWithEmail(this._authenticationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(SignInWithEmailParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _authenticationRepository.signInWithEmail(
          params!.email, params.password);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;

  SignInWithEmailParams(this.email, this.password);
}
