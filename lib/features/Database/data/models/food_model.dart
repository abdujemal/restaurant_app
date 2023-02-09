// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:restaurant_app/features/Database/domain/entities/food_entity.dart';

class FoodModel extends FoodEntity {
  String id;
  String name;
  String description;
  String image;
  int price;
  int quantity;
  int numOfReviews;
  int ratings;
  bool isFav;

  FoodModel({
    required this.isFav,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.numOfReviews,
    required this.ratings,
  }) : super(
            isFav: isFav,
            id: id,
            name: name,
            description: description,
            image: image,
            price: price,
            quantity: quantity,
            numOfReviews: numOfReviews,
            ratings: ratings);

  factory FoodModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return FoodModel(
        isFav: false,
        id: snapshot["id"],
        name: snapshot['name'],
        description: snapshot['description'],
        image: snapshot['image'],
        price: snapshot['price'],
        quantity: snapshot['quantity'],
        numOfReviews: snapshot['numOfReviews'],
        ratings: snapshot['ratings']);
  }

  factory FoodModel.fromFirebseMap(Map<String, dynamic> snapshot, bool isFav) {
    return FoodModel(
        isFav: isFav,
        id: snapshot["id"],
        name: snapshot['name'],
        description: snapshot['description'],
        image: snapshot['image'],
        price: snapshot['price'],
        quantity: snapshot['quantity'],
        numOfReviews: snapshot['numOfReviews'],
        ratings: snapshot['ratings']);
  }

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? price,
    int? quantity,
    int? numOfReviews,
    int? ratings,
    bool? isFav,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      numOfReviews: numOfReviews ?? this.numOfReviews,
      ratings: ratings ?? this.ratings,
      isFav: isFav ?? this.isFav,
    );
  }
}
