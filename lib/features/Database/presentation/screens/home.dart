import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/presentation/controller/food%20controlelr/food_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/screens/categories_screen.dart';
import 'package:restaurant_app/features/Database/presentation/screens/dishes.dart';
import 'package:restaurant_app/core/util/categories.dart';
import 'package:restaurant_app/features/Database/presentation/widget/grid_product.dart';
import 'package:restaurant_app/features/Database/presentation/widget/home_category.dart';
import 'package:restaurant_app/features/Database/presentation/widget/slider_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            return ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Dishes",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "View More",
                        style: TextStyle(
                          //                      fontSize: 22,
                          //                      fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return DishesScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10.0),

                //Slider Here

                state.foodState == RequestState.loading?
                Constants.carsolShimmer(MediaQuery.of(context).size.height / 2.4):
                CarouselSlider(
                    options: CarouselOptions(
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height / 2.4,
                      viewportFraction: 1.0,
                      onPageChanged: (index, cpr) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    items: map<Widget>(
                      state.foods,
                      (index, i) {
                        FoodModel food = state.foods[index];
                        return SliderItem(foodModel: food,);
                      },
                    ).toList()),
                const SizedBox(height: 20.0),
                const Text(
                  "Food Categories",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),

                Container(
                  height: 65.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories == null ? 0 : categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map cat = categories[index];
                      return HomeCategory(
                        tap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return CategoriesScreen();
                              },
                            ),
                          );
                        },
                        icon: cat['icon'],
                        title: cat['name'],
                        items: cat['items'].toString(),
                        isHome: true,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Popular Items",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "View More",
                        style: TextStyle(
                          //                      fontSize: 22,
                          //                      fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),

                state.foodState == RequestState.loading ?
                Constants.foodShimmer(context):
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: state.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodModel food = state.foods[index];
                    return GridProduct(foodModel: food,);
                  },
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
