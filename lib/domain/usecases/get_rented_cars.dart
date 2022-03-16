import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class GetRentedCars extends UseCase<List<Car>, void> {
  final RentACarRepository _rentACarRepository;
  final UserRepository _userRepository;
  final StreamController<List<Car>> _controller;

  GetRentedCars(this._rentACarRepository, this._userRepository)
      : _controller = StreamController.broadcast();
  @override
  Future<Stream<List<Car>?>> buildUseCaseStream(void params) async {
    try {
      final String uid = _userRepository.currentUser.uid;
      _rentACarRepository.getRentedCars(uid).listen((List<Car>? rentedCars) {
        _controller.add(rentedCars!);
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
