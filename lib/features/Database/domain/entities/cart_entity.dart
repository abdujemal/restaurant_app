// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  String id, name, numOfReviews, img;
  double price, ratings;
  int quantity;

  CartEntity({
    required this.img,
    required this.id,
    required this.name,
    required this.numOfReviews,
    required this.price,
    required this.quantity,
    required this.ratings,
  });
  @override
  List<Object?> get props =>
      [id, name, numOfReviews, price, ratings, quantity, img];
}
