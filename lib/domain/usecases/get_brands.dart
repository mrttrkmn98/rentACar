import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class GetBrands extends UseCase<List<Brand>, void> {
  final CarsListRepository _carsListRepository;
  final StreamController<List<Brand>> _controller;

  GetBrands(this._carsListRepository)
      : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<Brand>?>> buildUseCaseStream(void params) async {
    try {
      _carsListRepository.getBrands().listen((List<Brand>? brands) {
        _controller.add(brands!);
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
