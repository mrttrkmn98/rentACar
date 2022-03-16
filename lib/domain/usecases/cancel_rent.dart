import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class CancelRent extends UseCase<void, CancelRentParams> {
  final RentACarRepository _rentACarRepository;
  final UserRepository _userRepository;

  CancelRent(
    this._rentACarRepository,
    this._userRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(CancelRentParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      String uid = _userRepository.currentUser.uid;
      await _rentACarRepository.cancelRent(uid, params!.car);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
    return controller.stream;
  }
}

class CancelRentParams {
  final Car car;

  CancelRentParams(this.car);
}
