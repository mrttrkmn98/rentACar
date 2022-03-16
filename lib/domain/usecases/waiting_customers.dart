import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/admin_repository.dart';

class WaitingCustomersApproval extends UseCase<List<User>, void> {
  final AdminRepository _adminRepository;
  final StreamController<List<User>> _controller;

  WaitingCustomersApproval(this._adminRepository)
      : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<User>?>> buildUseCaseStream(void params) async {
    try {
      _adminRepository
          .waitingCustomers()
          .listen((List<User>? waitingCustomers) {
        _controller.add(waitingCustomers!);
      });
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
