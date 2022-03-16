import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class AddBrand extends UseCase<void, AddBrandParams> {
  final CarsListRepository _carsListRepository;

  AddBrand(this._carsListRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(AddBrandParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _carsListRepository.addBrand(params!.brand);
      controller.close();
    } catch (e, st) {
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class AddBrandParams {
  final Brand brand;

  AddBrandParams(
    this.brand,
  );
}
