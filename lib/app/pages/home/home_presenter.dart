import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/usecases/get_brands.dart';
import 'package:shopping_list/domain/usecases/get_cars.dart';
import 'package:shopping_list/domain/usecases/get_current_user.dart';
import 'package:shopping_list/domain/usecases/remove_from_store_list.dart';

class HomePresenter extends Presenter {
  late Function getBrandsOnNext;
  late Function getBrandsOnError;

  late Function getCarsOnNext;
  late Function getCarsOnError;

  late Function removeFromCarsListOnComplete;
  late Function removeFromCarsListOnError;

  late Function getCurrentUserOnNext;
  late Function getCurrentUserOnError;

  final RemoveFromCarsList _removeFromCarsList;
  final GetBrands _getBrands;
  final GetCars _getCars;
  final GetCurrentUser _getCurrentUser;

  HomePresenter(
      CarsListRepository _carsListRepository, UserRepository _userRepository)
      : _removeFromCarsList = RemoveFromCarsList(_carsListRepository),
        _getBrands = GetBrands(_carsListRepository),
        _getCars = GetCars(_carsListRepository),
        _getCurrentUser = GetCurrentUser(_userRepository);

  void getCurrentUser() {
    _getCurrentUser.execute(_GetCurrentUserObserver(this));
  }

  void getBrands() {
    _getBrands.execute(_GetBrandsObserver(this));
  }

  void getCars() {
    _getCars.execute(_GetCarsObserver(this));
  }

  void removeFromCarsList(String id, String brand) {
    _removeFromCarsList.execute(
        _RemoveFromCarsListObserver(this), RemoveFromCarsListParams(id, brand));
  }

  @override
  void dispose() {
    _getBrands.dispose();
    _getCars.dispose();
    _removeFromCarsList.dispose();
    _getCurrentUser.dispose();
  }
}

class _GetCurrentUserObserver extends Observer<User> {
  final HomePresenter _presenter;

  _GetCurrentUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(error) {
    _presenter.getCurrentUserOnError(error);
  }

  @override
  void onNext(User? user) {
    print(user);
    _presenter.getCurrentUserOnNext(user);
  }
}

class _GetCarsObserver extends Observer<List<Car>> {
  final HomePresenter _presenter;

  _GetCarsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getCarsOnError(e);
  }

  @override
  void onNext(List<Car>? response) {
    _presenter.getCarsOnNext(response);
  }
}

class _GetBrandsObserver extends Observer<List<Brand>> {
  final HomePresenter _presenter;

  _GetBrandsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getBrandsOnError(e);
  }

  @override
  void onNext(List<Brand>? response) {
    _presenter.getBrandsOnNext(response);
  }
}

class _RemoveFromCarsListObserver extends Observer<void> {
  final HomePresenter _presenter;

  _RemoveFromCarsListObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeFromCarsListOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeFromCarsListOnError(e);
  }

  @override
  void onNext(_) {}
}
