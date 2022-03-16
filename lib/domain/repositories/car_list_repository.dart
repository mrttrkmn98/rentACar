import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';

abstract class CarsListRepository {
  Future<void> addToCarsList(Car car);
  Future<void> removeFromCarsList(String id, String brand);
  Future<void> addBrand(Brand brand);
  Stream<List<Brand>> getBrands();
  Stream<List<Car>> getCars();
}
