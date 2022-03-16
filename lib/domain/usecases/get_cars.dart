import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class GetCars extends UseCase<List<Car>, void> {
  final CarsListRepository _carsListRepository;
  final StreamController<List<Car>> _controller;

  GetCars(this._carsListRepository)
      : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Car>?>> buildUseCaseStream(void params) async {
    try {
      _carsListRepository.getCars().listen((List<Car>? cars) {
        _controller.add(cars!);
      });
    } catch (e, st) {
      _controller.addError(e, st);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
