import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/rented_cars/rented_cars_presenter.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class RentedCarsController extends Controller {
  final RentedCarsPresenter _presenter;

  RentedCarsController(
    RentACarRepository _rentACarRepository,
    UserRepository _userRepository,
  ) : _presenter = RentedCarsPresenter(
          _rentACarRepository,
          _userRepository,
        );

  List<Car>? rentedCars;

  @override
  void initListeners() {
    _presenter.getRentedCarsOnNext = (List<Car> response) {
      rentedCars = response;
      refreshUI();
    };

    _presenter.getRentedCarsOnError = (e) {};

    _presenter.cancelRentOnComplete = () {};

    _presenter.cancelRentOnError = (e) {};
  }

  @override
  void onInitState() {
    _presenter.getRentedCars();
    refreshUI();
    super.onInitState();
  }

  void cancelRent(Car car) {
    _presenter.cancelRent(car);
    refreshUI();
  }

  void pop() {
    Navigator.pop(getContext());
  }
}
