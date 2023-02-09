import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/presentation/screens/details.dart';
import 'package:restaurant_app/features/Database/presentation/widget/smooth_star_rating.dart';

import '../../../../core/util/const.dart';
import '../controller/food controlelr/food_bloc.dart';

class GridProduct extends StatelessWidget {
  final FoodModel foodModel;

  GridProduct({Key? key, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "${foodModel.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: -10.0,
                bottom: 3.0,
                child: BlocListener<FoodBloc, FoodState>(
                  listener: (context, state) {
                    if (state.foodFavState == RequestState.loaded) {
                      print("get foods");
                      context.read<FoodBloc>().add(GetFoodsEvent());
                    }
                  },
                  child: RawMaterialButton(
                    onPressed: () {
                      if (foodModel.isFav) {
                        context
                            .read<FoodBloc>()
                            .add(RemoveToFavouriteEvent(foodModel));
                      } else {
                        context
                            .read<FoodBloc>()
                            .add(AddToFavouriteEvent(foodModel));
                      }
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        foodModel.isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "${foodModel.name}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                SmoothStarRating(
                  starCount: 5,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: foodModel.ratings.toDouble(),
                  size: 10.0,
                ),
                Text(
                  " ${foodModel.ratings} (${foodModel.numOfReviews} Reviews)",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(foodModel: foodModel,);
            },
          ),
        );
      },
    );
  }
}
