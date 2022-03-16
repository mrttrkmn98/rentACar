import 'package:shopping_list/domain/entities/car.dart';

abstract class RentACarRepository {
  Future<void> rentACar(String uid, Car car);
  Future<void> cancelRent(String uid, Car car);
  Stream<List<Car>> getRentedCars(String uid);
}
