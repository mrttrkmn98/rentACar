import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/usecases/cancel_rent.dart';
import 'package:shopping_list/domain/usecases/get_rented_cars.dart';

class RentedCarsPresenter extends Presenter {
  late Function getRentedCarsOnNext;
  late Function getRentedCarsOnError;

  late Function cancelRentOnComplete;
  late Function cancelRentOnError;

  final GetRentedCars _getRentedCars;
  final CancelRent _cancelRent;

  RentedCarsPresenter(
      RentACarRepository _rentACarRepository, UserRepository userRepository)
      : _getRentedCars = GetRentedCars(_rentACarRepository, userRepository),
        _cancelRent = CancelRent(_rentACarRepository, userRepository);

  void getRentedCars() {
    _getRentedCars.execute(_GetRentedCarsObserver(this));
  }

  void cancelRent(Car car) {
    _cancelRent.execute(_CancelRentObserver(this), CancelRentParams(car));
  }

  @override
  void dispose() {
    _getRentedCars.dispose();
    _cancelRent.dispose();
  }
}

class _GetRentedCarsObserver extends Observer<List<Car>> {
  final RentedCarsPresenter _presenter;

  _GetRentedCarsObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getRentedCarsOnError(e);
  }

  @override
  void onNext(List<Car>? response) {
    _presenter.getRentedCarsOnNext(response);
  }
}

class _CancelRentObserver extends Observer<void> {
  final RentedCarsPresenter _presenter;

  _CancelRentObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.cancelRentOnComplete();
  }

  @override
  void onError(e) {
    _presenter.cancelRentOnError(e);
  }

  @override
  void onNext(_) {}
}
