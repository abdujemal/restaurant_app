import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/presentation/controller/food%20controlelr/food_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/widget/grid_product.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10.0),
            const Text(
              "My Favorite Items",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10.0),
            BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                List<FoodModel> favFoods = state.foods
                    .where((element) => element.isFav == true)
                    .toList();
                return 
                favFoods.isEmpty ?
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child:Center(child: Text("No favourite"),),
                ):
                 GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.25),
                  ),
                  itemCount: favFoods.length,
                  itemBuilder: (BuildContext context, int index) {
                    FoodModel food = favFoods[index];
                    return GridProduct(
                      foodModel: food,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
