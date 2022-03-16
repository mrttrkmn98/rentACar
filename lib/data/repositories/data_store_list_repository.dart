import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/repositories/car_list_repository.dart';

class DataStoreListRepository implements CarsListRepository {
  static final _instance = DataStoreListRepository._internal();
  DataStoreListRepository._internal();
  factory DataStoreListRepository() => _instance;

  StreamController<List<Car>> _carStreamController =
      StreamController.broadcast();

  StreamController<List<Brand>> _brandStreamController =
      StreamController.broadcast();

  List<Car>? cars;
  List<Brand>? brands;
  bool isCarsFetched = false;
  bool isBrandsFetched = false;

  @override
  Future<void> addToCarsList(Car car) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      final selectedBrand = snapshot.docs
          .firstWhere((doc) => doc.data().values.contains(car.brand));

      await FirebaseFirestore.instance
          .collection('brands')
          .doc(selectedBrand.id)
          .collection('cars')
          .add(car.toJson());

      cars!.add(car);

      _carStreamController.add(cars!);
      _brandStreamController.add(brands!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFromCarsList(String id, String brand) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      final selectedBrand =
          snapshot.docs.firstWhere((doc) => doc.data().values.contains(brand));

      await FirebaseFirestore.instance
          .collection('brands')
          .doc(selectedBrand.id)
          .collection('cars')
          .doc(id)
          .delete();

      cars!.remove(id);

      _carStreamController.add(cars!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _initBrands() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      brands = [];

      snapshot.docs.forEach(
        (doc) {
          brands!.add(Brand.fromJson(doc.data(), doc.id));
        },
      );

      _brandStreamController.add(brands!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<void> _initCars() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      cars = [];

      snapshot.docs.forEach((doc) async {
        final snapshot2 = await doc.reference.collection('cars').get();
        snapshot2.docs.forEach((docIn) {
          cars!.add(Car.fromJsonWithId(docIn.data(), docIn.id));
        });
      });
      Future.delayed(Duration(seconds: 2))
          .then((_) => _carStreamController.add(cars!));
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<Car>> getCars() {
    try {
      Future.delayed(Duration(seconds: 3)).then((_) async {
        _initCars();
      });
      return _carStreamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<Brand>> getBrands() {
    try {
      Future.delayed(Duration(seconds: 3)).then((_) async {
        _initBrands();
      });
      return _brandStreamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> addBrand(Brand brand) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('brands')
          .add(brand.toJson());

      brands!.add(
        Brand(id: doc.id, name: brand.name, cars: brand.cars),
      );

      _brandStreamController.add(brands!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
