import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/car/car_presenter.dart';
import 'package:shopping_list/data/exceptions/car_already_rented_exception.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/types/enums/banner_type.dart';

class CarController extends Controller {
  final CarPresenter _presenter;

  CarController(
    RentACarRepository rentACarRepository,
    UserRepository userRepository,
    this.car,
  ) : _presenter = CarPresenter(rentACarRepository, userRepository);

  final Car car;
  List<Car> rentedCars = [];
  bool isPopped = false;

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  void initListeners() {
    _presenter.rentACarOnComplete = () {
      refreshUI();
      showBanner(
          BannerType.SUCCESS, 'Arac kiralama isteginiz basarili', getContext());
    };

    _presenter.rentACarOnError = (e) {
      if (e is CarAlreadyRentedException) {
        showBanner(BannerType.ERROR, 'Zaten kiraladiniz', getContext());
      }
    };
  }

  void rentACar(Car car) {
    _presenter.rentACar(car);
    refreshUI();
  }

  void closePage() {
    if (!isPopped) Navigator.of(getContext()).pop();
    isPopped = true;
  }
}
