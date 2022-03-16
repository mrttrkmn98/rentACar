import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';
import 'package:shopping_list/domain/usecases/add_brand.dart';
import 'package:shopping_list/domain/usecases/add_to_car_list.dart';

class OperationsPresenter extends Presenter {
  late Function addToCarsListOnComplete;
  late Function addToCarsListOnError;

  late Function addBrandOnComplete;
  late Function addBrandOnError;

  final AddToCarsList _addToCarsList;
  final AddBrand _addBrand;

  OperationsPresenter(
    CarsListRepository carsListRepository,
  )   : _addToCarsList = AddToCarsList(carsListRepository),
        _addBrand = AddBrand(carsListRepository);

  void addProductToCarsList(Car car) {
    _addToCarsList.execute(
        _AddToCarsListObserver(this), AddToCarsListParams(car));
  }

  void addBrand(Brand brand) {
    _addBrand.execute(_AddBrandObserver(this), AddBrandParams(brand));
  }

  @override
  void dispose() {
    _addToCarsList.dispose();
    _addBrand.dispose();
  }
}

class _AddBrandObserver extends Observer<void> {
  final OperationsPresenter _presenter;

  _AddBrandObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addBrandOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addBrandOnError(e);
  }

  @override
  void onNext(_) {}
}

class _AddToCarsListObserver extends Observer<void> {
  final OperationsPresenter _presenter;

  _AddToCarsListObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addToCarsListOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addToCarsListOnError(e);
  }

  @override
  void onNext(_) {}
}
