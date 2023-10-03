import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Database/data/models/cart_model.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_event.dart';
import 'package:restaurant_app/features/Database/presentation/screens/notifications.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/presentation/widget/add_review_bottom_sheet.dart';
import 'package:restaurant_app/features/Database/presentation/widget/smooth_star_rating.dart';

import '../controller/cart_controller/cart_bloc.dart';
import '../controller/food controlelr/food_bloc.dart';
import '../widget/badge.dart';

class ProductDetails extends StatefulWidget {
  final FoodModel foodModel;

  const ProductDetails({super.key, required this.foodModel});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var scafoldKey = GlobalKey<ScaffoldState>();
  bool isFav = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isFav = widget.foodModel.isFav;
    });

    context.read<FoodBloc>().add(GetReviewEvent(widget.foodModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Item Details",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.foodModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        isFav = !isFav;
                      });

                      if (isFav) {
                        context
                            .read<FoodBloc>()
                            .add(RemoveToFavouriteEvent(widget.foodModel));
                      } else {
                        context
                            .read<FoodBloc>()
                            .add(AddToFavouriteEvent(widget.foodModel));
                      }
                    },
                    fillColor: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.foodModel.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: widget.foodModel.ratings.toDouble(),
                    size: 10.0,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "${widget.foodModel.ratings.toDouble()}  (${widget.foodModel.numOfReviews} Reviews)",
                    style: const TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "${widget.foodModel.quantity} Pieces",
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "\$${widget.foodModel.price}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Product Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.foodModel.description.replaceAll('"', "").trim(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                ),
                TextButton(
                    onPressed: () {
                      scafoldKey.currentState!.showBottomSheet(
                        (context) => AddReviewBottomSheet(foodModel: widget.foodModel,),
                        constraints: BoxConstraints(maxHeight: 300));
                    },
                    child: const Text("add"))
              ],
            ),
            const SizedBox(height: 20.0),
            BlocConsumer<FoodBloc, FoodState>(
              listener: (context, state) {
                if (state.reviewState == RequestState.error) {
                  Constants.toast(state.reviewError, ToastType.error);
                }
              },
              builder: (context, state) {
                if (state.reviewState == RequestState.loading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 60),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                if (state.reviews.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 60),
                    child: Center(
                      child: Text("No Ratings"),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      ReviewModel comment = state.reviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              comment.image,
                            ),
                          ),
                          title: Text(comment.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SmoothStarRating(
                                    starCount: 5,
                                    color: Constants.ratingBG,
                                    allowHalfRating: true,
                                    rating: 5.0,
                                    size: 12.0,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    comment.date,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7.0),
                              Text(
                                comment.text,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: ElevatedButton(
          child: const Text(
            "ADD TO CART",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            context.read<CartBloc>().add(AddToCartEvent(CartModel(
                img: widget.foodModel.image,
                id: widget.foodModel.id,
                name: widget.foodModel.name,
                numOfReviews: widget.foodModel.numOfReviews.toString(),
                price: widget.foodModel.price.toDouble(),
                quantity: 1,
                ratings: widget.foodModel.ratings.toDouble())));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
