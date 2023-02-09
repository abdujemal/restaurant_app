import 'package:equatable/equatable.dart';
import 'package:restaurant_app/features/Database/data/models/cart_model.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';

abstract class CartEvent extends Equatable {}

class AddToCartEvent extends CartEvent {
  CartModel cartModel;
  AddToCartEvent(this.cartModel);
  @override
  List<Object?> get props => [cartModel];
}

class IncreaseQuantityEvent extends CartEvent {
  CartModel cartModel;
  IncreaseQuantityEvent(this.cartModel);
  
  @override
  List<Object?> get props => [cartModel];
}

class DecreaseQuantityEvent extends CartEvent {
  CartModel cartModel;
  DecreaseQuantityEvent(this.cartModel);
  
  @override
  List<Object?> get props => [cartModel];
}

class GetTotalPriceEvent extends CartEvent{
  @override
  List<Object?> get props => [];
  
}

class EmpitateMyCartEvent extends CartEvent{
  @override
  List<Object?> get props => [];

}

class RemoveToCartEvent extends CartEvent {
  CartModel cartModel;
  RemoveToCartEvent(this.cartModel);
  @override
  List<Object?> get props => [cartModel];
}
