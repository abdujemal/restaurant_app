import 'package:restaurant_app/features/Database/data/data_source/database_data_src.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class DatabaseRepoImpl extends DatabaseRepo {
  DatabaseDataSrc dataSrc;
  DatabaseRepoImpl(this.dataSrc);

  @override
  Future<Either<Exception, bool>> addToFavorite(FoodModel foodModel) async {
    try {
      final res = await dataSrc.addToFavorite(foodModel);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<FoodModel>>> getFoods() async {
    try {
      final res = await dataSrc.getFoods();
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<ReviewModel>>> getReviews(String foodID) async {
    try {
      final res = await dataSrc.getReviews(foodID);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, void>> placeAnOrder() {
    // TODO: implement placeAnOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, bool>> removeToFavorite(FoodModel foodModel) async {
    try {
      final res = await dataSrc.removeToFavorite(foodModel);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<FoodModel>>> searchFoods(String query) async {
    try {
      final res = await dataSrc.searchFoods(query);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Exception, List<ReviewModel>>> addReview(ReviewModel reviewModel) async {
    try {
      final res = await dataSrc.addReview(reviewModel);
      return right(res);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
