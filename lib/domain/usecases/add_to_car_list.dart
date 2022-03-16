import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class AddToCarsList extends UseCase<void, AddToCarsListParams> {
  final CarsListRepository _carsListRepository;

  AddToCarsList(this._carsListRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(AddToCarsListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _carsListRepository.addToCarsList(params!.car);
      controller.close();
    } catch (e, st) {
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddToCarsListParams {
  final Car car;

  AddToCarsListParams(
    this.car,
  );
}
