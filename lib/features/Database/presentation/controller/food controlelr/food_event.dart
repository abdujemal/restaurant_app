// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodsEvent extends FoodEvent {}

class GetReviewEvent extends FoodEvent {
  String foodId;
  GetReviewEvent(this.foodId);
}

class SearchFoodsEvent extends FoodEvent {
  String query;
  SearchFoodsEvent(this.query);
}

class AddReviewEvent extends FoodEvent {
  ReviewModel reviewModel;
  AddReviewEvent(this.reviewModel);
}

class AddToFavouriteEvent extends FoodEvent {
  FoodModel foodModel;
  AddToFavouriteEvent(this.foodModel);
}

class RemoveToFavouriteEvent extends FoodEvent {
  FoodModel foodModel;
  RemoveToFavouriteEvent(this.foodModel);
}
