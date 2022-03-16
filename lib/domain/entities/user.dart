import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/domain/entities/car.dart';

class User {
  final String uid;
  String? firstName;
  String? lastName;
  String? email;
  final List<Car> rentedCars;

  User(
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.rentedCars,
  );

  User.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : uid = json.id,
        firstName =
            json['firstName'] == null ? '' : json['firstName'] as String?,
        lastName = json['lastName'] == null ? '' : json['lastName'] as String?,
        email = json['email'] == null ? '' : json['email'] as String?,
        rentedCars =
            json['rentedCars'] == null || json['rentedCars'].length == 0
                ? <Car>[]
                : List<Car>.from(
                    json['rentedCars'].map((car) => Car.fromJson(car, json.id)),
                  );

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'rentedCars': [], 
    };
  }
}
