import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/operations/operations_view.dart';
import 'package:shopping_list/app/pages/waiting_customers.dart/waiting_customers_presenter.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/admin_repository.dart';

class WaitingCustomersController extends Controller {
  final WaitingCustomersPresenter _presenter;

  WaitingCustomersController(
    AdminRepository _adminRepository,
  ) : _presenter = WaitingCustomersPresenter(_adminRepository);

  List<User>? users;
  List<Car> cars = [];

  @override
  void initListeners() {
    _presenter.waitingCustomersOnNext = (List<User> response) {
      users = [];
      users = response;
      users!.removeWhere((user) => user.rentedCars.length == 0);
      users!.forEach((user) => cars.addAll(user.rentedCars));
      print(users);
      refreshUI();
    };

    _presenter.waitingCustomersOnError = (e) {};
  }

  @override
  void onInitState() {
    _presenter.getWaitingCustomers();
    super.onInitState();
  }

  void navigateToOperationsPage() {
    Navigator.push(
      getContext(),
      MaterialPageRoute(
        builder: (context) => OperationsView(),
      ),
    );
  }
}
