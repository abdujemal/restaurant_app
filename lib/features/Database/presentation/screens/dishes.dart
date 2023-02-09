import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/presentation/screens/notifications.dart';
import 'package:restaurant_app/features/Database/presentation/widget/badge.dart';
import 'package:restaurant_app/features/Database/presentation/widget/grid_product.dart';

import '../controller/food controlelr/food_bloc.dart';

class DishesScreen extends StatefulWidget {
  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Dishes",
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
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Chinese",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: state.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodModel food = state.foods[index];
                    return GridProduct(
                      foodModel: food,
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Italian",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: state.foods.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodModel food = state.foods[index];
                    return GridProduct(
                      foodModel: food,
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "African",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Divider(),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
