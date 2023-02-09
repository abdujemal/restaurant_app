// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/data/models/cart_model.dart';

class CartState extends Equatable {
  List<CartModel> cartList;
  double totalPrice;

  CartState({
    this.cartList = const [],
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [cartList];

  

  CartState copyWith({
    List<CartModel>? cartList,
    double? totalPrice,
  }) {
    return CartState(
      cartList: cartList ?? this.cartList,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
