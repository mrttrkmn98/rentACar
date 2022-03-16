import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/admin_repository.dart';

class DataWaitingCustomersRepository implements AdminRepository {
  static final _instance = DataWaitingCustomersRepository._internal();
  DataWaitingCustomersRepository._internal();
  factory DataWaitingCustomersRepository() => _instance;

  StreamController<List<User>> _streamController = StreamController.broadcast();

  List<Car>? cars;
  List<User>? users;

  Future<void> _initWaitingCustomers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      users = [];

      snapshot.docs.forEach((doc) {
        users!.add(User.fromJson(doc));
      });

      _streamController.add(users!);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Stream<List<User>> waitingCustomers() {
    try {
      Future.delayed(Duration(seconds: 1)).then((_) async {
        _initWaitingCustomers();
      });
      return _streamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
