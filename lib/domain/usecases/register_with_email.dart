import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';

class RegisterWithEmail extends UseCase<void, RegisterWithEmailParams> {
  final AuthenticationRepository _authenticationRepository;

  RegisterWithEmail(this._authenticationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      RegisterWithEmailParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _authenticationRepository.registerWithEmail(
          params!.firstName, params.lastName, params.email, params.password);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class RegisterWithEmailParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterWithEmailParams(
      this.firstName, this.lastName, this.email, this.password);
}
