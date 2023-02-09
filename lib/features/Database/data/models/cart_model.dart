// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:restaurant_app/features/Database/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  String id;
  String name;
  String numOfReviews;
  String img;
  double price;
  double ratings;
  int quantity;

  CartModel(
      {required this.img,
      required this.id,
      required this.name,
      required this.numOfReviews,
      required this.price,
      required this.quantity,
      required this.ratings})
      : super(
            img: img,
            id: id,
            name: name,
            numOfReviews: numOfReviews,
            price: price,
            quantity: quantity,
            ratings: ratings);

  CartModel copyWith({
    String? id,
    String? name,
    String? numOfReviews,
    String? img,
    double? price,
    double? ratings,
    int? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      numOfReviews: numOfReviews ?? this.numOfReviews,
      img: img ?? this.img,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
      quantity: quantity ?? this.quantity,
    );
  }
}
