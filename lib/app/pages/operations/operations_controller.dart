import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/login/login_view.dart';
import 'package:shopping_list/app/pages/operations/operations_presenter.dart';
import 'package:shopping_list/app/pages/waiting_customers.dart/waiting_customers_view.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class OperationsController extends Controller {
  final OperationsPresenter _presenter;

  OperationsController(CarsListRepository carsListRepository)
      : _presenter = OperationsPresenter(
          carsListRepository,
        );

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  TextEditingController textController6 = TextEditingController();

  @override
  void onDisposed() {
    _presenter.dispose();
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();
    textController6.dispose();
    super.onDisposed();
  }

  @override
  void initListeners() {
    _presenter.addToCarsListOnComplete = () {
      refreshUI();
    };
    _presenter.addToCarsListOnError = (e) {};

    _presenter.addBrandOnComplete = () {
      refreshUI();
    };
    _presenter.addBrandOnError = (e) {};
  }

  void addCarToStoreList(Car car) {
    _presenter.addProductToCarsList(car);
    textController1.clear();
    textController2.clear();
    textController3.clear();
    textController4.clear();
    textController5.clear();
  }

  void addBrand(Brand brand) {
    _presenter.addBrand(brand);
    textController6.clear();
  }

  void navigateToWaitingCustomers() {
    Navigator.push(getContext(),
        MaterialPageRoute(builder: (context) => WaitingCustomersView()));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(
        getContext(), MaterialPageRoute(builder: (context) => LoginView()));
  }
}
