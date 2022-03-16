import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/usecases/rent_a_car.dart';

class CarPresenter extends Presenter {
  late Function rentACarOnComplete;
  late Function rentACarOnError;

  final RentACar _rentACar;
  CarPresenter(
    RentACarRepository _rentACarRepository,
    UserRepository _userRepository,
  ) : _rentACar = RentACar(_rentACarRepository, _userRepository);

  void rentACar(Car car) {
    _rentACar.execute(_RentACarObserver(this), RentACarParams(car));
  }

  @override
  void dispose() {
    _rentACar.dispose();
  }
}

class _RentACarObserver extends Observer<void> {
  final CarPresenter _presenter;

  _RentACarObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.rentACarOnComplete();
  }

  @override
  void onError(e) {
    _presenter.rentACarOnError(e);
  }

  @override
  void onNext(_) {}
}
