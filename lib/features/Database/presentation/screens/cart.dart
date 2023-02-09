import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_event.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_state.dart';
import 'package:restaurant_app/features/Database/presentation/screens/checkout.dart';
import 'package:restaurant_app/features/Database/presentation/widget/cart_item.dart';

import '../../data/models/cart_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return 
            state.cartList.isEmpty?
            const Center(child: Text("Empty cart"),):
             ListView.builder(
              itemCount: state.cartList.length,
              itemBuilder: (BuildContext context, int index) {
                CartModel cartModel = state.cartList[index];
                return CartItem(
                  cartModel: cartModel,
                  onDecrease: () {
                    context
                        .read<CartBloc>()
                        .add(DecreaseQuantityEvent(cartModel));
                  },
                  onIncrease: () {
                    context
                        .read<CartBloc>()
                        .add(IncreaseQuantityEvent(cartModel));
                  },
                );
              },
            );
          },
        ),
      ),

      floatingActionButton:
       
       FloatingActionButton(
        tooltip: "Checkout",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Checkout();
              },
            ),
          );
        },
        child: const Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
