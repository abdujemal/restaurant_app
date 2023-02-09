import 'package:flutter/material.dart';
import 'package:restaurant_app/features/Database/data/models/cart_model.dart';
import 'package:restaurant_app/features/Database/presentation/screens/details.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/presentation/widget/smooth_star_rating.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final Function onIncrease;
  final Function onDecrease;

  CartItem({Key? key, required this.cartModel, required this.onIncrease, required this.onDecrease}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return ProductDetails();
          //     },
          //   ),
          // );
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width / 3.5,
                width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "${cartModel.img}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${cartModel.name}",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 12.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "${cartModel.ratings} (${cartModel.numOfReviews} Reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      "20 Pieces",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "\$${cartModel.price}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      "Quantity: ",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconButton(
                        onPressed: () => onIncrease(),
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    Text("${cartModel.quantity}"),
                    IconButton(
                        onPressed:() => onDecrease(),
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
