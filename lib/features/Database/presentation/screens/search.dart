import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/presentation/screens/details.dart';
import 'package:restaurant_app/features/Database/presentation/widget/smooth_star_rating.dart';

import '../controller/food controlelr/food_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),

          Card(
            elevation: 6.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                onSubmitted: (value) {
                  print("Submitted");
                  context.read<FoodBloc>().add(SearchFoodsEvent(value));
                },
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),

          const SizedBox(height: 5.0),

          // Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: Text(
          //     "",
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),

          BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              if (state.searchFoods.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text("No Result"),
                  ),
                );
              }
              if (state.searchFoodsState == RequestState.loading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.searchFoods.length,
                itemBuilder: (BuildContext context, int index) {
                  FoodModel food = state.foods[index];
                  return ListTile(
                    title: Text(
                      food.name,
                      style: const TextStyle(
                        //                    fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        food.image,
                      ),
                    ),
                    trailing: Text("\$${food.price}"),
                    subtitle: Row(
                      children: <Widget>[
                        SmoothStarRating(
                          starCount: 1,
                          color: Constants.ratingBG,
                          allowHalfRating: true,
                          rating: food.ratings.toDouble(),
                          size: 12.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          "${food.ratings.toDouble()} (${food.numOfReviews} Reviews)",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetails(foodModel: food)));
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
