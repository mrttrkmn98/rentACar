import 'package:shopping_list/domain/entities/car.dart';

class Brand {
  final String id;
  final String name;
  final List<Car> cars;

  Brand({
    required this.id,
    required this.name,
    required this.cars,
  });

  Brand.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json['name'],
        cars = json['cars'] == null || json['cars'].length == 0
            ? <Car>[]
            : List<Car>.from(
                json['cars'].map((car) => Car.fromJsonWithId(car, id)),
              );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cars': cars.map((car) => car.toJson()).toList(),
    };
  }
}
