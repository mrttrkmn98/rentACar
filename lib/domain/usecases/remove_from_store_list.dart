import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class RemoveFromCarsList extends UseCase<void, RemoveFromCarsListParams> {
  final CarsListRepository _carsListRepository;

  RemoveFromCarsList(this._carsListRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      RemoveFromCarsListParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _carsListRepository.removeFromCarsList(params!.id, params.brand);
      controller.close();
    } catch (e, st) {
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class RemoveFromCarsListParams {
  final String id;
  final String brand;

  RemoveFromCarsListParams(this.id, this.brand);
}
