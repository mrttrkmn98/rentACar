import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/car/car_view.dart';
import 'package:shopping_list/app/pages/home/home_presenter.dart';
import 'package:shopping_list/app/pages/login/login_view.dart';
import 'package:shopping_list/app/pages/operations/operations_view.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/entities/user.dart' as ent;
import 'package:shopping_list/domain/repositories/car_list_repository.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(
    CarsListRepository _carsListRepository,
    UserRepository _userRepository,
  ) : _presenter = HomePresenter(
          _carsListRepository,
          _userRepository,
        );

  List<Car>? cars;
  List<Brand>? brands;
  bool isScroll = false;

  ent.User? user;

  @override
  void initListeners() {
    _presenter.getCurrentUserOnNext = (ent.User response) {
      user = response;
      refreshUI();
    };

    _presenter.getCurrentUserOnError = (e) {};

    _presenter.getBrandsOnNext = (List<Brand> response) {
      brands = response;
      refreshUI();
    };

    _presenter.getBrandsOnError = (e) {};

    _presenter.getCarsOnNext = (List<Car> response) {
      cars = response;
      refreshUI();
    };

    _presenter.getCarsOnError = (e) {};

    _presenter.removeFromCarsListOnComplete = () {};

    _presenter.removeFromCarsListOnError = (e) {};
  }

  @override
  void onInitState() {
    _presenter.getCurrentUser();
    _presenter.getBrands();
    _presenter.getCars();

    super.onInitState();
  }

  void removeFromShoppingList(String id, String brand) {
    _presenter.removeFromCarsList(id, brand);
  }

  void navigateToOperationsPage() {
    Navigator.push(
      getContext(),
      MaterialPageRoute(builder: (context) => OperationsView()),
    );
  }

  void navigateToCarPage(Car car) {
    Navigator.push(
      getContext(),
      MaterialPageRoute(
        builder: (context) => CarView(car),
      ),
    );
  }

  void changeAppBarHeight() {
    isScroll = true;

    print(isScroll);
  }

  void changeAppBarHeightt() {
    isScroll = false;
    print(isScroll);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      getContext(),
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
    );
  }
}
