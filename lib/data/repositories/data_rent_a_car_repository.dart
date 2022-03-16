import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/data/exceptions/car_already_rented_exception.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/rent_a_car_repository.dart';

class DataRentACarRepository implements RentACarRepository {
  static final _instance = DataRentACarRepository._internal();
  DataRentACarRepository._internal();
  factory DataRentACarRepository() => _instance;

  StreamController<List<Car>> _rentedCarsStreamController =
      StreamController.broadcast();

  List<Car>? rentedCars;

  bool isRented = false;

  @override
  Future<void> cancelRent(String uid, Car car) async {
    try {
      if (rentedCars == null) {
        rentedCars = [];
      }

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'rentedCars': FieldValue.arrayRemove([car.toJson()])
      });

      rentedCars!.remove(
          rentedCars!.firstWhere((element) => element.name == car.name));

      _rentedCarsStreamController.add(rentedCars!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _initRentedCars(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      List<Car> rentedCarsToBe = [];
      User user = User.fromJson(snapshot);
      rentedCarsToBe.addAll(user.rentedCars.toList());

      rentedCars = rentedCarsToBe;

      _rentedCarsStreamController.add(rentedCars!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<Car>> getRentedCars(String uid) {
    try {
      Future.delayed(Duration(seconds: 1)).then((_) async {
        _initRentedCars(uid);
      });
      return _rentedCarsStreamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> rentACar(String uid, Car car) async {
    isRented = false;
    try {
      if (rentedCars == null) {
        rentedCars = [];
      }
      if (rentedCars!.contains(car)) {
        throw CarAlreadyRentedException();
      }

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'rentedCars': FieldValue.arrayUnion([car.toJson()])
      });
      rentedCars!.add(car);

      _rentedCarsStreamController.add(rentedCars!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
