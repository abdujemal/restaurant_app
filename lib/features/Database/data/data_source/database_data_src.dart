import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import '../models/review_model.dart';

abstract class DatabaseDataSrc {
  Future<List<FoodModel>> searchFoods(String query);

  Future<List<FoodModel>> getFoods();

  Future<void> placeAnOrder();

  Future<List<ReviewModel>> getReviews(String foodID);

  Future<List<ReviewModel>> addReview(ReviewModel reviewModel);

  Future<bool> addToFavorite(FoodModel foodModel);

  Future<bool> removeToFavorite(FoodModel foodModel);

  // Future<void> addToCart();

  // Future<void> removeFromCart(String id);
}
