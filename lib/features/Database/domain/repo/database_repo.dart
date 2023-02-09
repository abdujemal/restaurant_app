import 'package:dartz/dartz.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';

import '../../data/models/food_model.dart';

abstract class DatabaseRepo{
  Future<Either<Exception, List<FoodModel>>> searchFoods(String query);

  Future<Either<Exception, List<FoodModel>>> getFoods();

  Future<Either<Exception, void>> placeAnOrder();  

  Future<Either<Exception, List<ReviewModel>>> getReviews(String foodID);

  Future<Either<Exception, List<ReviewModel>>> addReview(ReviewModel reviewModel);

  Future<Either<Exception, bool>> addToFavorite(FoodModel foodModel);

  Future<Either<Exception, bool>> removeToFavorite(FoodModel foodModel);
}