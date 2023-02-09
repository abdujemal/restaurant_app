// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_bloc.dart';

class FoodState extends Equatable {
  RequestState foodState;
  RequestState foodFavState;
  String foodFavError;
  List<FoodModel> foods;
  String foodsError;
  List<ReviewModel> reviews;
  RequestState reviewState;
  String reviewError;
  List<FoodModel> searchFoods;
  RequestState searchFoodsState;
  String searchFoodsError;
  RequestState addReviewState;
  String addReviewError;

  FoodState(
      {this.foodFavState = RequestState.idle,
      this.foodFavError = "",
      this.foodState = RequestState.idle,
      this.foods = const [],
      this.foodsError = "",
      this.reviewState = RequestState.idle,
      this.reviews = const [],
      this.reviewError = "",
      this.searchFoods = const [],
      this.searchFoodsError = "",
      this.searchFoodsState = RequestState.idle,
      this.addReviewError = "",
      this.addReviewState = RequestState.idle});

  @override
  List<Object> get props => [
        foodState,
        foods,
        foodsError,
        foodFavState,
        foodFavError,
        reviewState,
        reviews,
        reviewError,
        addReviewError,
        addReviewState,
        searchFoods,
        searchFoodsError,
        searchFoodsState
      ];

  FoodState copyWith({
    RequestState? foodState,
    RequestState? foodFavState,
    String? foodFavError,
    List<FoodModel>? foods,
    String? foodsError,
    List<ReviewModel>? reviews,
    RequestState? reviewState,
    String? reviewError,
    List<FoodModel>? searchFoods,
    RequestState? searchFoodsState,
    String? searchFoodsError,
    RequestState? addReviewState,
    String? addReviewError,
  }) {
    return FoodState(
      foodState: foodState ?? this.foodState,
      foodFavState: foodFavState ?? this.foodFavState,
      foodFavError: foodFavError ?? this.foodFavError,
      foods: foods ?? this.foods,
      foodsError: foodsError ?? this.foodsError,
      reviews: reviews ?? this.reviews,
      reviewState: reviewState ?? this.reviewState,
      reviewError: reviewError ?? this.reviewError,
      searchFoods: searchFoods ?? this.searchFoods,
      searchFoodsState: searchFoodsState ?? this.searchFoodsState,
      searchFoodsError: searchFoodsError ?? this.searchFoodsError,
      addReviewError: addReviewError ?? this.addReviewError,
      addReviewState: addReviewState ?? this.addReviewState
    );
  }
}
