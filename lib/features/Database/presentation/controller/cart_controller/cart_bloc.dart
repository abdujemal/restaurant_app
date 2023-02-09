import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCartEvent>((event, emit) {
      emit(state.copyWith(
          cartList: [...state.cartList, event.cartModel],
          totalPrice: state.totalPrice +
              (event.cartModel.price * event.cartModel.quantity)));
    });

    on<RemoveToCartEvent>((event, emit) {
      emit(state.copyWith(
          cartList:
              state.cartList.where((e) => e != event.cartModel).toList()));
    });

    on<IncreaseQuantityEvent>((event, emit) {
      emit(state.copyWith(
          totalPrice: state.totalPrice + event.cartModel.price,
          cartList: state.cartList.map((e) {
            if (e == event.cartModel) {
              return e.copyWith(quantity: e.quantity + 1);
            }
            return e;
          }).toList()));
    });

    on<DecreaseQuantityEvent>((event, emit) {
      if (event.cartModel.quantity == 1) {
        emit(state.copyWith(
            totalPrice: state.totalPrice - event.cartModel.price,
            cartList:
                state.cartList.where((e) => e != event.cartModel).toList()));
      } else {
        emit(state.copyWith(
            totalPrice: state.totalPrice - event.cartModel.price,
            cartList: state.cartList.map((e) {
              if (e == event.cartModel) {
                return e.copyWith(quantity: e.quantity - 1);
              }
              return e;
            }).toList()));
      }
    });

    on<EmpitateMyCartEvent>((event, emit) {
      emit(state.copyWith(cartList: [], totalPrice: 0));
    });
  }
}
