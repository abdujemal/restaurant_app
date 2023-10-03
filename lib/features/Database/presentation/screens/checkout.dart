import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/data/models/cart_model.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_state.dart';
import 'package:restaurant_app/features/Database/presentation/screens/main_screen.dart';
import 'package:restaurant_app/features/Database/presentation/widget/cart_item.dart';

import '../../../Authentication/presentation/bloc/login_controller/login_bloc.dart';
import '../../../Authentication/presentation/bloc/login_controller/login_state.dart';
import '../controller/cart_controller/cart_event.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final TextEditingController _couponlControl = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 130),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Shipping Address",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        state.currentUser!.fullName,
                        style: TextStyle(
                          //                    fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Text(state.currentUser!.address),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Card(
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(state.currentUser!.fullName),
                        subtitle: Text(
                          "5506 7744 8610 9638",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        leading: Icon(
                          FontAwesomeIcons.creditCard,
                          size: 50.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Items",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
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
          ],
        ),
      ),
      bottomSheet: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Card(
            elevation: 4.0,
            child: Container(
              height: 130,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 225, 224, 224),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 234, 234, 234),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          hintText: "Coupon Code",
                          prefixIcon: Icon(
                            Icons.redeem,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        maxLines: 1,
                        controller: _couponlControl,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "\$ ${state.totalPrice}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Text(
                              "Delivery charges included",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                        width: 150.0,
                        height: 50.0,
                        child: ElevatedButton(
                          // ignore: deprecated_member_use
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                          ),

                          child: Text(
                            "Place Order".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (state.totalPrice != 0) {
                              context
                                  .read<CartBloc>()
                                  .add(EmpitateMyCartEvent());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainScreen()));
                              Constants.toast(
                                  "you have successfully placed your order.",
                                  ToastType.success);
                            } else {
                              Constants.toast("you have nothing on your cart.",
                                  ToastType.error);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
