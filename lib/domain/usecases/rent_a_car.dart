import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class RentACar extends UseCase<void, RentACarParams> {
  final RentACarRepository _rentACarRepository;
  final UserRepository _userRepository;

  RentACar(
    this._rentACarRepository,
    this._userRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(RentACarParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      String uid = _userRepository.currentUser.uid;
      await _rentACarRepository.rentACar(uid, params!.car);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class RentACarParams {
  final Car car;

  RentACarParams(this.car);
}
