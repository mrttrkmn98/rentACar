import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String id;
  final String name;
  final String imageUrl;
  final int price;
  final String brand;
  final String color;

  Car({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.brand,
    required this.color,
  });

  Car.fromJsonWithDocument(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        name = json['name'] == null ? '' : json['name'] as String,
        imageUrl = json['imageUrl'] == null ? '' : json['imageUrl'] as String,
        price = json['price'] == null ? 0 : json['price'] as int,
        brand = json['brand'] == null ? '' : json['brand'] as String,
        color = json['color'] == null ? '' : json['color'] as String;

  Car.fromJsonWithId(Map<String, dynamic> json, String id)
      : id = id,
        name = json['name'],
        imageUrl = json['imageUrl'],
        price = json['price'],
        brand = json['brand'],
        color = json['color'];

  Car.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json['name'],
        imageUrl = json['imageUrl'],
        price = json['price'],
        brand = json['brand'],
        color = json['color'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'brand': brand,
      'color': color,
    };
  }
}
