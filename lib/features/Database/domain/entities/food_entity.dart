// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  String id;
  String name;
  String description;
  String image;
  int price;
  int quantity;
  int numOfReviews;
  int ratings;
  bool isFav;

  FoodEntity({
    required this.isFav,
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.numOfReviews,
    required this.ratings,
  });

  @override
  List<Object?> get props =>
      [id, name, description, image, price, quantity, numOfReviews, ratings];
}
